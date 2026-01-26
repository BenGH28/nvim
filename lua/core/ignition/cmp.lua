local source = {}

-- Path to Ignition data directory
local data_path = "C:\\Program Files\\Inductive Automation\\Ignition\\data"

local base_paths = {
  data_path .. "\\projects\\global\\ignition\\script-python",
  data_path .. "\\projects\\global\\ignition\\script-project",
}

-- Cache for module structure
local module_cache = nil
local cache_time = 0
local CACHE_TTL = 30000 -- 30 seconds in ms

-- Scan directory recursively for modules (folders with code.py)
local function scan_modules()
  local now = vim.uv.now()
  if module_cache and (now - cache_time) < CACHE_TTL then
    return module_cache
  end

  local modules = {}

  local function scan_dir(path, prefix)
    local handle = vim.uv.fs_scandir(path)
    if not handle then return end

    while true do
      local name, ftype = vim.uv.fs_scandir_next(handle)
      if not name then break end

      if ftype == "directory" then
        local full_path = path .. "\\" .. name
        local module_name = prefix == "" and name or (prefix .. "." .. name)

        -- Check if it has code.py (valid module)
        local code_path = full_path .. "\\code.py"
        local stat = vim.uv.fs_stat(code_path)
        if stat then
          table.insert(modules, {
            path = module_name,
            file = code_path,
          })
        end

        -- Recurse into subdirectory
        scan_dir(full_path, module_name)
      end
    end
  end

  for _, base in ipairs(base_paths) do
    scan_dir(base, "")
  end

  module_cache = modules
  cache_time = now
  return modules
end

-- Extract docstring starting at given line index
local function extract_docstring(lines, start_idx)
  if start_idx > #lines then return nil end

  local first_line = lines[start_idx]

  -- Check for docstring start (""" or ''')
  local _, quote = first_line:match('^(%s*)(""")')
  if not quote then
    _, quote = first_line:match("^(%s*)(''')")
  end
  if not quote then return nil end

  -- Single-line docstring: """content""" or '''content'''
  local single_content = first_line:match('^%s*' .. quote .. '(.-)' .. quote .. '%s*$')
  if single_content then
    return single_content:gsub("^%s*", ""):gsub("%s*$", "")
  end

  -- Multi-line docstring
  local docstring_lines = {}
  local first_content = first_line:match('^%s*' .. quote .. '(.*)$')
  if first_content and first_content ~= "" then
    docstring_lines[#docstring_lines + 1] = first_content
  end

  for i = start_idx + 1, #lines do
    local line = lines[i]
    -- Check for closing triple quote
    local end_match = line:match('^(.-)' .. quote)
    if end_match then
      local trimmed = end_match:gsub("^%s*", ""):gsub("%s*$", "")
      if trimmed ~= "" then
        docstring_lines[#docstring_lines + 1] = trimmed
      end
      break
    else
      docstring_lines[#docstring_lines + 1] = (line:gsub("^%s*", ""))
    end
    -- Limit docstring length
    if #docstring_lines > 10 then break end
  end

  return table.concat(docstring_lines, "\n"):gsub("^%s*", ""):gsub("%s*$", "")
end

-- Strip `self` or `cls` from parameter list for display
local function strip_self_param(params)
  if not params then return "" end
  -- Remove leading self/cls with optional comma and whitespace
  local stripped = params:gsub("^%s*self%s*,?%s*", ""):gsub("^%s*cls%s*,?%s*", "")
  return stripped
end

-- Parse a function definition that may span multiple lines
-- Returns: func_name, params, end_line_idx (or nil if not a function def)
local function parse_function_def(lines, start_idx, indent_pattern)
  local line = lines[start_idx]
  local indent, func_name, rest = line:match("^(" .. indent_pattern .. ")def%s+([%w_]+)%(%s*(.*)$")
  if not func_name then return nil end

  -- Check if signature completes on this line
  local params_end = rest:match("^(.-)%)%s*:")
  if params_end then
    return indent, func_name, params_end, start_idx
  end

  -- Multi-line signature: collect params until we find ):\s*$
  local param_parts = { rest }
  for i = start_idx + 1, math.min(start_idx + 20, #lines) do
    local cont_line = lines[i]
    local closing = cont_line:match("^%s*(.-)%)%s*:?%s*$")
    if closing then
      param_parts[#param_parts + 1] = closing
      local full_params = table.concat(param_parts, " ")
      -- Normalize whitespace
      full_params = full_params:gsub("%s+", " "):gsub("^%s*", ""):gsub("%s*$", "")
      return indent, func_name, full_params, i
    else
      param_parts[#param_parts + 1] = cont_line:gsub("^%s*", "")
    end
  end

  return nil -- Never found closing
end

-- Extract symbols (def/class) from a code.py file
local function get_symbols(filepath)
  local stat = vim.uv.fs_stat(filepath)
  if not stat then return {} end

  local symbols = {}
  local lines = vim.fn.readfile(filepath)

  -- Track current class context for method parsing
  local current_class = nil
  local current_class_indent = nil

  for i, line in ipairs(lines) do
    -- Match top-level class definitions with optional parent classes
    local class_name, parents_str = line:match("^class%s+([%w_]+)%s*%(([^)]+)%)")
    if not class_name then
      class_name = line:match("^class%s+([%w_]+)")
    end

    if class_name then
      current_class = class_name
      current_class_indent = 0
      local docstring = extract_docstring(lines, i + 1)

      -- Parse parent classes
      local parents = {}
      if parents_str then
        for parent in parents_str:gmatch("[%w_.]+") do
          table.insert(parents, parent)
        end
      end

      table.insert(symbols, {
        name = class_name,
        kind = 7, -- Class
        docstring = docstring,
        parents = parents,
      })
    elseif current_class then
      -- Check if we've left the class (non-indented, non-empty, non-comment line)
      if not line:match("^%s") and not line:match("^%s*$") and not line:match("^%s*#") then
        current_class = nil
        current_class_indent = nil
      else
        -- Match class-level attributes (single indent, not in a method)
        local class_indent, attr_name, attr_value = line:match("^(%s+)([%w_]+)%s*=%s*(.+)$")
        if class_indent and attr_name and not attr_name:match("^_") then
          -- Verify it's at class level (single indent, not deeper)
          local indent_len = #class_indent
          -- Simple heuristic: class attributes typically have 2-4 spaces of indent
          if indent_len > 0 and indent_len <= 4 then
            -- Check if this is NOT inside a method (next non-empty line shouldn't be more indented unless it's the first line after class)
            local is_class_attr = true
            -- Look back to see if we just had a def line
            if i > 1 then
              local prev_line = lines[i - 1]
              if prev_line:match("^%s+def%s+") then
                is_class_attr = false
              end
            end

            if is_class_attr then
              -- Extract type from value if it looks like a typed constant
              local inferred_type = nil
              if attr_value:match("^%d+$") then
                inferred_type = "int"
              elseif attr_value:match("^%d+%.%d+$") then
                inferred_type = "float"
              elseif attr_value:match('^["\']') then
                inferred_type = "str"
              elseif attr_value:match("^%[") then
                inferred_type = "list"
              elseif attr_value:match("^{") then
                inferred_type = "dict"
              end

              -- Check for inline type comment
              local type_comment = attr_value:match("#%s*type:%s*(.+)%s*$")

              table.insert(symbols, {
                name = attr_name,
                kind = 5, -- Field/Property
                parent_class = current_class,
                var_type = type_comment or inferred_type,
                is_class_attribute = true,
              })
            end
          end
        end

        -- Match method inside class (indented def) - supports multi-line signatures
        local indent, method_name, params, end_idx = parse_function_def(lines, i, "%s+")
        if indent and #indent > 0 and method_name then
          -- Check line after signature for type comment
          local type_comment = nil
          local docstring_start = end_idx + 1
          if end_idx + 1 <= #lines then
            local next_line = lines[end_idx + 1]
            type_comment = next_line:match("^%s*#%s*type:%s*(.+)%s*$")
            if type_comment then
              docstring_start = end_idx + 2
            end
          end

          local docstring = extract_docstring(lines, docstring_start)

          -- Determine if classmethod/staticmethod (check previous line for decorator)
          local is_classmethod = i > 1 and lines[i - 1]:match("^%s*@classmethod")
          local is_staticmethod = i > 1 and lines[i - 1]:match("^%s*@staticmethod")

          -- Strip self/cls for display
          local display_params = strip_self_param(params)
          local signature = method_name .. "(" .. display_params .. ")"
          if type_comment then
            signature = signature .. "  # type: " .. type_comment
          end

          table.insert(symbols, {
            name = method_name,
            kind = 2, -- Method
            parent_class = current_class,
            signature = signature,
            parameters = display_params,
            type_comment = type_comment,
            docstring = docstring,
            is_classmethod = is_classmethod,
            is_staticmethod = is_staticmethod,
          })
        end
      end
    end

    -- Match top-level function definitions with parameters - supports multi-line signatures
    local _, func_name, params, end_idx = parse_function_def(lines, i, "")
    if func_name then
      -- Check line after signature for type comment: `# type: (int, str) -> bool`
      local type_comment = nil
      local docstring_start = end_idx + 1
      if end_idx + 1 <= #lines then
        local next_line = lines[end_idx + 1]
        type_comment = next_line:match("^%s*#%s*type:%s*(.+)%s*$")
        if type_comment then
          docstring_start = end_idx + 2
        end
      end

      local docstring = extract_docstring(lines, docstring_start)

      -- Build signature
      local signature = func_name .. "(" .. params .. ")"
      if type_comment then
        signature = signature .. "  # type: " .. type_comment
      end

      table.insert(symbols, {
        name = func_name,
        kind = 3, -- Function
        signature = signature,
        parameters = params,
        type_comment = type_comment,
        docstring = docstring,
      })
    end

    -- Match top-level variable assignments with optional type comment
    local var_name = line:match("^([%w_]+)%s*=")
    if var_name and not var_name:match("^_") then
      -- Check for type comment: `var = value  # type: Type`
      local type_comment = line:match("#%s*type:%s*(.+)%s*$")

      table.insert(symbols, {
        name = var_name,
        kind = 6, -- Variable
        var_type = type_comment and type_comment:gsub("^%s*", ""):gsub("%s*$", ""),
      })
    end
  end

  return symbols
end


-- Extract the module prefix from cursor context
local function get_module_prefix(line, col)
  local before = line:sub(1, col)
  -- Match dotted path ending at cursor
  local prefix = before:match("([%w_][%w_.]*%.?)$") or ""
  return prefix
end

-- Resolve inherited members for a class
-- Returns a table of inherited members with source information
local function resolve_inherited_members(class_name, current_module_path, modules)
  local inherited = {}
  local visited = {} -- Prevent infinite loops in case of circular inheritance

  local function find_class_in_module(class_name_to_find, module_path, modules)
    for _, mod in ipairs(modules) do
      if mod.path == module_path then
        local symbols = get_symbols(mod.file)
        for _, sym in ipairs(symbols) do
          if sym.kind == 7 and sym.name == class_name_to_find then
            return sym, symbols, mod
          end
        end
      end
    end
    return nil, nil, nil
  end

  local function collect_members(parent_class_ref, parent_module_path)
    -- Parse parent class reference (could be "ClassName" or "module.ClassName")
    local parent_module, parent_class
    if parent_class_ref:match("%.") then
      -- Cross-module reference like "other_module.ParentClass"
      parent_module, parent_class = parent_class_ref:match("^(.+)%.([^.]+)$")
    else
      -- Same-module reference
      parent_module = parent_module_path
      parent_class = parent_class_ref
    end

    -- Check if we've already visited this class
    local visit_key = parent_module .. "." .. parent_class
    if visited[visit_key] then
      return
    end
    visited[visit_key] = true

    -- Find the parent class definition
    local parent_sym, parent_symbols, parent_mod = find_class_in_module(parent_class, parent_module, modules)
    if not parent_sym then
      return
    end

    -- Collect members from this parent
    for _, member in ipairs(parent_symbols) do
      if member.parent_class == parent_class then
        -- Clone the member and mark it as inherited
        local inherited_member = {}
        for k, v in pairs(member) do
          inherited_member[k] = v
        end
        inherited_member.inherited_from = parent_module .. "." .. parent_class
        inherited_member.is_inherited = true
        table.insert(inherited, inherited_member)
      end
    end

    -- Recursively process grandparents
    if parent_sym.parents then
      for _, grandparent in ipairs(parent_sym.parents) do
        collect_members(grandparent, parent_module)
      end
    end
  end

  -- Find the current class and start collecting from its parents
  local class_sym, class_symbols, class_mod = find_class_in_module(class_name, current_module_path, modules)
  if class_sym and class_sym.parents then
    for _, parent in ipairs(class_sym.parents) do
      collect_members(parent, current_module_path)
    end
  end

  return inherited
end

---Return whether this source is available in the current context or not.
---@return boolean
function source:is_available()
  if vim.bo.filetype ~= "python" then
    return false
  end

  local bufname = vim.api.nvim_buf_get_name(0)
  for _, base in ipairs(base_paths) do
    if bufname:find(base, 1, true) then
      return true
    end
  end
  return false
end

---Return the keyword pattern for triggering completion.
---@return string
function source:get_keyword_pattern()
  return [[\k\+]]
end

---Return trigger characters for triggering completion.
function source:get_trigger_characters()
  return { "." }
end

---Invoke completion.
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
  local line = params.context.cursor_before_line
  local col = #line
  local prefix = get_module_prefix(line, col)

  local modules = scan_modules()
  local items = {}

  -- Check if prefix matches a complete module path (for symbol completion)
  local prefix_no_dot = prefix:gsub("%.$", "")
  for _, mod in ipairs(modules) do
    if mod.path == prefix_no_dot and prefix:match("%.$") then
      -- Complete with symbols from this module
      local symbols = get_symbols(mod.file)
      for _, sym in ipairs(symbols) do
        -- Skip methods - they're accessed via ClassName.method
        if not sym.parent_class then
          -- Build detail line
          local detail = sym.signature or (sym.var_type and (sym.name .. ": " .. sym.var_type)) or
              (mod.path .. "." .. sym.name)

          -- Build documentation with docstring if available
          local doc_parts = {}
          if sym.docstring then
            table.insert(doc_parts, sym.docstring)
            table.insert(doc_parts, "")
          end
          table.insert(doc_parts, "From: " .. mod.path)

          table.insert(items, {
            label = sym.name,
            kind = sym.kind,
            detail = detail,
            documentation = {
              kind = "markdown",
              value = table.concat(doc_parts, "\n"),
            },
          })
        end
      end
      callback(items)
      return
    end

    -- Check if prefix matches module.ClassName. (for method completion)
    if prefix:match("%.$") then
      local symbols = get_symbols(mod.file)
      for _, sym in ipairs(symbols) do
        if sym.kind == 7 then -- Class
          local class_path = mod.path .. "." .. sym.name
          if class_path == prefix_no_dot then
            -- Complete with methods and attributes of this class
            for _, member_sym in ipairs(symbols) do
              if member_sym.parent_class == sym.name then
                local doc_parts = {}

                -- Handle class attributes
                if member_sym.is_class_attribute then
                  if member_sym.var_type then
                    table.insert(doc_parts, "Type: " .. member_sym.var_type)
                    table.insert(doc_parts, "")
                  end
                  table.insert(doc_parts, "Class attribute")
                  table.insert(doc_parts, "From: " .. class_path)

                  local detail = member_sym.name
                  if member_sym.var_type then
                    detail = detail .. ": " .. member_sym.var_type
                  end

                  table.insert(items, {
                    label = member_sym.name,
                    kind = member_sym.kind,
                    detail = detail,
                    documentation = {
                      kind = "markdown",
                      value = table.concat(doc_parts, "\n"),
                    },
                  })
                  -- Handle methods
                else
                  if member_sym.docstring then
                    table.insert(doc_parts, member_sym.docstring)
                    table.insert(doc_parts, "")
                  end
                  if member_sym.is_classmethod then
                    table.insert(doc_parts, "@classmethod")
                  elseif member_sym.is_staticmethod then
                    table.insert(doc_parts, "@staticmethod")
                  end
                  table.insert(doc_parts, "From: " .. class_path)

                  table.insert(items, {
                    label = member_sym.name,
                    kind = member_sym.kind,
                    detail = member_sym.signature,
                    documentation = {
                      kind = "markdown",
                      value = table.concat(doc_parts, "\n"),
                    },
                  })
                end
              end
            end

            -- Add inherited members
            local inherited_members = resolve_inherited_members(sym.name, mod.path, modules)
            for _, inherited_sym in ipairs(inherited_members) do
              local doc_parts = {}

              -- Handle inherited class attributes
              if inherited_sym.is_class_attribute then
                if inherited_sym.var_type then
                  table.insert(doc_parts, "Type: " .. inherited_sym.var_type)
                  table.insert(doc_parts, "")
                end
                table.insert(doc_parts, "Class attribute (inherited)")
                table.insert(doc_parts, "From: " .. inherited_sym.inherited_from)

                local detail = inherited_sym.name
                if inherited_sym.var_type then
                  detail = detail .. ": " .. inherited_sym.var_type
                end

                table.insert(items, {
                  label = inherited_sym.name,
                  kind = inherited_sym.kind,
                  detail = detail .. " (inherited)",
                  documentation = {
                    kind = "markdown",
                    value = table.concat(doc_parts, "\n"),
                  },
                })
                -- Handle inherited methods
              else
                if inherited_sym.docstring then
                  table.insert(doc_parts, inherited_sym.docstring)
                  table.insert(doc_parts, "")
                end
                if inherited_sym.is_classmethod then
                  table.insert(doc_parts, "@classmethod")
                elseif inherited_sym.is_staticmethod then
                  table.insert(doc_parts, "@staticmethod")
                end
                table.insert(doc_parts, "Inherited from: " .. inherited_sym.inherited_from)

                table.insert(items, {
                  label = inherited_sym.name,
                  kind = inherited_sym.kind,
                  detail = inherited_sym.signature .. " (inherited)",
                  documentation = {
                    kind = "markdown",
                    value = table.concat(doc_parts, "\n"),
                  },
                })
              end
            end

            if #items > 0 then
              callback(items)
              return
            end
          end
        end
      end
    end
  end

  -- Otherwise, complete module paths
  for _, mod in ipairs(modules) do
    -- Filter to modules that start with the prefix
    if prefix == "" or mod.path:find("^" .. vim.pesc(prefix_no_dot)) then
      table.insert(items, {
        label = mod.path,
        kind = 9, -- Module
        detail = "Ignition module",
        documentation = mod.file,
      })
    end
  end

  callback(items)
end

---Resolve completion item (optional).
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:resolve(completion_item, callback)
  callback(completion_item)
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
  callback(completion_item)
end

---Register your source to nvim-cmp.
require("cmp").register_source("ignition", source)
