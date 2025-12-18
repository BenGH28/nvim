local show = function(lines)
  local default_size = 0.85
  local win_height = math.floor(#lines + 3)
  local win_width = math.floor(vim.api.nvim_win_get_width(0) * default_size)

  local config = {
    relative = "cursor",
    row = 1,
    col = 0,
    width = win_width,
    height = win_height,
    border = "rounded",
    style = "minimal",
  }


  local bufnr = vim.api.nvim_create_buf(true, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, config)
  vim.api.nvim_set_current_win(win_id)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  vim.api.nvim_set_option_value("ft", "python", { buf = bufnr })
  vim.api.nvim_set_option_value("number", true, { buf = bufnr })
  vim.api.nvim_set_option_value("relativenumber", true, { buf = bufnr })
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })

  vim.keymap.set("n", "qq", function()
    vim.api.nvim_buf_delete(bufnr, {})
  end, { buffer = true, desc = "close script window" })
end

local decode = function(str)
  str = str:gsub("\\t", "\t")

  -- Replace \" with "
  str = str:gsub('\\"', '"')

  return str:gsub("\\u(%x%x%x%x)", function(hex)
    return vim.fn.nr2char(tonumber(hex, 16))
  end)
end

local show_script = function()
  local line = vim.api.nvim_get_current_line()
  local decoded = decode(line)
  local splits = vim.split(decoded, ":")

  table.remove(splits, 1)
  local subbed = table.concat(splits, ":")
  subbed = subbed:sub(3, -2):gsub('"$', ""):gsub("%s+$", "")

  local lines = vim.split(subbed, "\\n")
  show(lines)
end

local script_qfx = function()
  vim.cmd [[ :vim /"\(code\|script\)":/g % ]]
  vim.cmd(":copen")
end

local set_keys = function()
  vim.keymap.set("n", "<leader>ss", show_script, { buffer = true, desc = "show script" })
  vim.keymap.set("n", "<leader>sq", script_qfx, { buffer = true, desc = "script quick fix" })
end

local del_keys = function()
  vim.keymap.del("n", "<leader>ss")
  vim.keymap.del("n", "<leader>sq")
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "view.json", "props.json", "tags.json", "tag-groups.json" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    set_keys()
    vim.api.nvim_buf_create_user_command(0, "FlameOn", set_keys, {})
    vim.api.nvim_buf_create_user_command(0, "FlameOff", del_keys, {})
  end
})

local data_path = function() return "C:\\Program Files\\Inductive Automation\\Ignition\\data" end

local flame_find = function()
  local telescope = require("telescope.builtin")
  local path = data_path() .. "\\projects"
  local opts = {
    cwd = path,
    find_command = { "rg", "--files", "--color", "never", "-g", "*.py", "-g", "*.json" }
  }
  telescope.find_files(opts)
end

vim.api.nvim_create_user_command("FlameFind", flame_find, { desc = "Find files in ignition directory" })

vim.keymap.set("n", "<leader>fi", flame_find, { desc = "find ignition files" })


local flame_scan = function()
  local url = "http://localhost:8088/data/api/v1/scan/projects"
  local secret_path = data_path() .. "\\secrets.json"
  local contents = vim.fn.readfile(secret_path)

  local json_str = table.concat(contents, '\n')
  local results = vim.json.decode(json_str)
  local header = "X-Ignition-API-Token: " .. results.ignition
  local response = vim.fn.system {
    "curl",
    "-XPOST",
    "-s",
    "-H",
    header,
    url,
  }
  vim.notify(response, vim.log.levels.INFO, { title = "Ignition" })
end

vim.api.nvim_create_user_command("FlameScan", flame_scan, { desc = "Trigger scan of ignition files" })
vim.keymap.set("n", "<leader>is", flame_scan, { desc = "scan ignition" })

-- ============================================================================
-- CROSS-MODULE NAVIGATION
-- ============================================================================

-- Convert Ignition module path to filesystem path
-- e.g., "shared.finishing.asrs.flow.station" -> "...\shared\finishing\asrs\flow\station\code.py"
local resolve_ignition_path = function(module_path)
  -- Remove any "shared." prefix if present
  local path = module_path

  -- Split by dots
  local parts = vim.split(path, "%.", { plain = false })

  -- Base paths to check
  local base_paths = {
    data_path() .. "\\projects\\global\\ignition\\script-python",
    data_path() .. "\\projects\\global\\ignition\\script-project",
  }

  local candidates = {}

  for _, base in ipairs(base_paths) do
    -- Try as a directory with code.py
    local dir_path = base .. "\\" .. table.concat(parts, "\\") .. "\\code.py"
    table.insert(candidates, dir_path)

    -- Try as a direct .py file
    local file_path = base .. "\\" .. table.concat(parts, "\\") .. ".py"
    table.insert(candidates, file_path)

    -- Try with the last part as a definition inside code.py
    if #parts > 1 then
      local parent_parts = vim.list_slice(parts, 1, #parts - 1)
      local parent_path = base .. "\\" .. table.concat(parent_parts, "\\") .. "\\code.py"
      table.insert(candidates, { path = parent_path, symbol = parts[#parts] })
    end
  end

  return candidates
end

-- Check if file exists
local file_exists = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

-- Search for a symbol definition in a file
local find_symbol_in_file = function(filepath, symbol)
  if not file_exists(filepath) then
    return nil
  end

  local lines = vim.fn.readfile(filepath)
  local patterns = {
    "^class " .. symbol,
    "^def " .. symbol,
    "^" .. symbol .. " =",
    "^    def " .. symbol, -- indented method
  }

  for lnum, line in ipairs(lines) do
    for _, pattern in ipairs(patterns) do
      if line:match(pattern) then
        return { file = filepath, line = lnum }
      end
    end
  end

  return nil
end

-- Parse ripgrep result line handling Windows paths
-- e.g., "C:\path\to\file.py:123:content" -> "C:\path\to\file.py", 123, "content"
local parse_rg_result = function(line)
  -- Find positions of colons
  local colon_positions = {}
  for i = 1, #line do
    if line:sub(i, i) == ":" then
      table.insert(colon_positions, i)
    end
  end

  -- Need at least 2 colons (one after filename, one after line number)
  if #colon_positions < 2 then
    return nil, nil, nil
  end

  -- Try to find which colon is after the line number
  -- Work backwards from the end
  for i = #colon_positions, 2, -1 do
    local potential_lnum_start = colon_positions[i - 1] + 1
    local potential_lnum_end = colon_positions[i] - 1
    local potential_lnum_str = line:sub(potential_lnum_start, potential_lnum_end)
    local lnum = tonumber(potential_lnum_str)

    if lnum then
      -- Found a valid line number
      local file = line:sub(1, colon_positions[i - 1] - 1)
      local text = line:sub(colon_positions[i] + 1)
      return file, lnum, text
    end
  end

  return nil, nil, nil
end

-- Go to Ignition module definition
local goto_ignition_module = function()
  -- Get word under cursor or visual selection
  local word = vim.fn.expand("<cword>")

  -- Try to get a fuller path if cursor is on a dotted path
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")

  -- Extract the full dotted path around cursor
  local before = line:sub(1, col):reverse()
  local after = line:sub(col + 1)

  local before_match = before:match("^[%w_%.]*") or ""
  local after_match = after:match("^[%w_%.]*") or ""

  local full_path = before_match:reverse() .. after_match
  full_path = full_path:gsub("^%.", ""):gsub("%.$", "")

  if full_path == "" then
    full_path = word
  end

  -- Try to resolve the path
  local candidates = resolve_ignition_path(full_path)

  -- Try each candidate
  for _, candidate in ipairs(candidates) do
    if type(candidate) == "string" then
      if file_exists(candidate) then
        vim.cmd("edit " .. vim.fn.fnameescape(candidate))
        vim.notify("Opened: " .. candidate, vim.log.levels.INFO)
        return
      end
    else
      -- Candidate with symbol
      local result = find_symbol_in_file(candidate.path, candidate.symbol)
      if result then
        vim.cmd("edit " .. vim.fn.fnameescape(result.file))
        vim.api.nvim_win_set_cursor(0, { result.line, 0 })
        vim.notify("Found " .. candidate.symbol .. " in " .. result.file, vim.log.levels.INFO)
        return
      end
    end
  end

  -- If nothing found, try a broader search
  vim.notify("Direct path not found, trying symbol search for: " .. word, vim.log.levels.WARN)
  search_ignition_symbol(word)
end

-- Search for symbol definitions across all Ignition files
search_ignition_symbol = function(symbol)
  local search_path = data_path() .. "\\projects"

  if not symbol then
    vim.ui.input({ prompt = "Search for symbol: " }, function(input)
      if input then
        search_ignition_symbol(input)
      end
    end)
    return
  end

  -- Build ripgrep patterns for common definition styles
  local patterns = {
    "^class " .. symbol,
    "^def " .. symbol .. "\\(",
    "^" .. symbol .. " =",
    "    def " .. symbol .. "\\(", -- indented methods
  }

  local rg_pattern = "(" .. table.concat(patterns, "|") .. ")"

  local results = vim.fn.systemlist({
    "rg",
    "--line-number",
    "--no-heading",
    "--color=never",
    "-e", rg_pattern,
    "--glob", "*.py",
    search_path
  })

  if #results == 0 then
    vim.notify("No definitions found for: " .. symbol, vim.log.levels.WARN)
    return
  end

  if #results == 1 then
    -- Single result, go directly
    local file, lnum = parse_rg_result(results[1])
    if file and lnum then
      vim.cmd("edit " .. vim.fn.fnameescape(file))
      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      vim.notify("Found: " .. symbol, vim.log.levels.INFO)
    else
      vim.notify("Failed to parse result: " .. results[1], vim.log.levels.ERROR)
    end
  else
    -- Multiple results, use quickfix
    local qf_list = {}
    for _, line in ipairs(results) do
      local file, lnum, text = parse_rg_result(line)
      if file and lnum then
        table.insert(qf_list, {
          filename = file,
          lnum = lnum,
          text = text or ""
        })
      end
    end
    vim.fn.setqflist(qf_list)
    vim.cmd("copen")
    vim.notify("Found " .. #results .. " definitions for: " .. symbol, vim.log.levels.INFO)
  end
end

-- Telescope picker for searching symbols
local telescope_symbol_search = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  vim.ui.input({ prompt = "Search symbol (class/function/variable): " }, function(input)
    if not input or input == "" then
      return
    end

    local search_path = data_path() .. "\\projects"
    local patterns = {
      "^class " .. input,
      "^def " .. input .. "\\(",
      "^" .. input .. " =",
      "    def " .. input .. "\\(",
    }

    local rg_pattern = "(" .. table.concat(patterns, "|") .. ")"

    pickers.new({}, {
      prompt_title = "Symbol: " .. input,
      finder = finders.new_oneshot_job({
        "rg",
        "--line-number",
        "--column",
        "--no-heading",
        "--color=never",
        "--absolute-path",
        "-e", rg_pattern,
        "--glob", "*.py",
        search_path
      }, {
        entry_maker = function(line)
          local file, lnum, text = parse_rg_result(line)
          if not file or not lnum then
            return nil
          end

          -- Extract column number from text if present (format is "col:content")
          local col = 1
          local display_text = text
          if text then
            local col_match = text:match("^(%d+):")
            if col_match then
              col = tonumber(col_match)
              display_text = text:sub(#col_match + 2)
            end
          end

          local filename_only = file:match("[^\\]+$")

          return {
            value = line,
            display = filename_only .. ":" .. lnum .. " " .. (display_text or ""),
            ordinal = line,
            filename = file,
            lnum = lnum,
            col = col,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = conf.grep_previewer({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection and selection.filename then
            vim.cmd("edit " .. vim.fn.fnameescape(selection.filename))
            vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
          end
        end)
        return true
      end,
    }):find()
  end)
end

-- Browse all classes and functions in Ignition
local browse_ignition_symbols = function()
  local telescope = require("telescope.builtin")
  local search_path = data_path() .. "\\projects"

  telescope.live_grep({
    cwd = search_path,
    prompt_title = "Ignition Symbols",
    default_text = "^(class|def) ",
    additional_args = function()
      return { "--glob", "*.py" }
    end
  })
end

-- Keybindings for navigation
vim.keymap.set("n", "<leader>ig", goto_ignition_module, { desc = "[ignition] go to module" })
vim.keymap.set("n", "<leader>if", function()
  search_ignition_symbol(vim.fn.expand("<cword>"))
end, { desc = "[ignition] find symbol" })
vim.keymap.set("n", "<leader>it", telescope_symbol_search, { desc = "[ignition] telescope symbol search" })
vim.keymap.set("n", "<leader>ib", browse_ignition_symbols, { desc = "[ignition] browse symbols" })

-- Commands
vim.api.nvim_create_user_command("IgnitionGoto", goto_ignition_module, { desc = "Go to Ignition module under cursor" })
vim.api.nvim_create_user_command("IgnitionFind", function(opts)
  if opts.args and opts.args ~= "" then
    search_ignition_symbol(opts.args)
  else
    search_ignition_symbol(vim.fn.expand("<cword>"))
  end
end, { nargs = "?", desc = "Find Ignition symbol definition" })
vim.api.nvim_create_user_command("IgnitionSearch", telescope_symbol_search,
  { desc = "Search Ignition symbols with Telescope" })
vim.api.nvim_create_user_command("IgnitionBrowse", browse_ignition_symbols, { desc = "Browse all Ignition symbols" })
