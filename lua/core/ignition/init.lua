local telescope = require("telescope.builtin")

local DATA_PATH = "C:\\Program Files\\Inductive Automation\\Ignition\\data"

local show = function(lines)
  local win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.85)
  local bufnr = vim.api.nvim_create_buf(true, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = win_width,
    height = math.floor(#lines + 3),
    border = "rounded",
    style = "minimal",
  })

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value("ft", "python", { buf = bufnr })
  vim.api.nvim_set_option_value("number", true, { win = win_id })
  vim.api.nvim_set_option_value("relativenumber", true, { win = win_id })
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
  vim.api.nvim_set_option_value("shiftwidth", 2, { buf = bufnr })
  vim.api.nvim_set_option_value("tabstop", 2, { buf = bufnr })

  vim.keymap.set("n", "qq", function()
    vim.api.nvim_buf_delete(bufnr, {})
  end, { buffer = bufnr, desc = "close script window" })
end

local decode = function(str)
  str = str:gsub("\\t", "\t")
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
  local subbed = table.concat(splits, ":"):sub(3, -2):gsub('"$', ""):gsub("%s+$", "")
  show(vim.split(subbed, "\\n"))
end

local script_qfx = function()
  vim.cmd([[ :vim /"\(code\|script\)":/g % ]])
  vim.cmd(":copen")
end

local set_keys = function()
  vim.keymap.set("n", "<leader>ss", show_script, { buffer = true, desc = "show script" })
  vim.keymap.set("n", "<leader>sq", script_qfx, { buffer = true, desc = "script quick fix" })
end

local del_keys = function()
  vim.keymap.del("n", "<leader>ss", { buffer = true })
  vim.keymap.del("n", "<leader>sq", { buffer = true })
end


-- ============================================================================
-- CROSS-MODULE NAVIGATION
-- ============================================================================

local file_exists = function(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "file"
end

-- Convert Ignition module path (e.g. "shared.finishing.asrs.flow.station") to
-- a list of filesystem path candidates to try in order.
local resolve_ignition_path = function(module_path)
  local parts = vim.split(module_path, "%.", { plain = false })
  local base_paths = {
    DATA_PATH .. "\\projects\\global\\ignition\\script-python",
    DATA_PATH .. "\\projects\\global\\ignition\\script-project",
  }

  local candidates = {}
  for _, base in ipairs(base_paths) do
    local joined = table.concat(parts, "\\")
    table.insert(candidates, base .. "\\" .. joined .. "\\code.py")
    table.insert(candidates, base .. "\\" .. joined .. ".py")

    if #parts > 1 then
      local parent = table.concat(vim.list_slice(parts, 1, #parts - 1), "\\")
      table.insert(candidates, { path = base .. "\\" .. parent .. "\\code.py", symbol = parts[#parts] })
    end
  end

  return candidates
end

local find_symbol_in_file = function(filepath, symbol)
  if not file_exists(filepath) then return nil end

  local patterns = {
    "^class " .. symbol,
    "^def " .. symbol,
    "^" .. symbol .. " =",
    "^    def " .. symbol,
  }

  for lnum, line in ipairs(vim.fn.readfile(filepath)) do
    for _, pattern in ipairs(patterns) do
      if line:match(pattern) then
        return { file = filepath, line = lnum }
      end
    end
  end
end

-- Parse a ripgrep result line that may contain a Windows path.
-- e.g. "C:\path\to\file.py:123:content" -> file, lnum, text
local parse_rg_result = function(line)
  local colon_positions = {}
  for i = 1, #line do
    if line:sub(i, i) == ":" then
      table.insert(colon_positions, i)
    end
  end

  if #colon_positions < 2 then return nil, nil, nil end

  for i = #colon_positions, 2, -1 do
    local lnum_str = line:sub(colon_positions[i - 1] + 1, colon_positions[i] - 1)
    local lnum = tonumber(lnum_str)
    if lnum then
      return line:sub(1, colon_positions[i - 1] - 1), lnum, line:sub(colon_positions[i] + 1)
    end
  end

  return nil, nil, nil
end

local search_ignition_symbol

local goto_ignition_module = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")
  local before = line:sub(1, col):reverse():match("^[%w_%.]*") or ""
  local after = line:sub(col + 1):match("^[%w_%.]*") or ""
  local full_path = (before:reverse() .. after):gsub("^%.", ""):gsub("%.$", "")

  if full_path == "" then full_path = vim.fn.expand("<cword>") end

  for _, candidate in ipairs(resolve_ignition_path(full_path)) do
    if type(candidate) == "string" then
      if file_exists(candidate) then
        vim.cmd("edit " .. vim.fn.fnameescape(candidate))
        vim.notify("Opened: " .. candidate, vim.log.levels.INFO)
        return
      end
    else
      local result = find_symbol_in_file(candidate.path, candidate.symbol)
      if result then
        vim.cmd("edit " .. vim.fn.fnameescape(result.file))
        vim.api.nvim_win_set_cursor(0, { result.line, 0 })
        vim.notify("Found " .. candidate.symbol .. " in " .. result.file, vim.log.levels.INFO)
        return
      end
    end
  end

  local word = vim.fn.expand("<cword>")
  vim.notify("Direct path not found, trying symbol search for: " .. word, vim.log.levels.WARN)
  search_ignition_symbol(word)
end

search_ignition_symbol = function(symbol)
  local search_path = DATA_PATH .. "\\projects"

  if not symbol then
    vim.ui.input({ prompt = "Search for symbol: " }, function(input)
      if input then search_ignition_symbol(input) end
    end)
    return
  end

  local patterns = {
    "^class " .. symbol,
    "^def " .. symbol .. "\\(",
    "^" .. symbol .. " =",
    "    def " .. symbol .. "\\(",
  }

  local results = vim.fn.systemlist({
    "rg", "--line-number", "--no-heading", "--color=never",
    "-e", "(" .. table.concat(patterns, "|") .. ")",
    "--glob", "*.py",
    search_path,
  })

  if #results == 0 then
    vim.notify("No definitions found for: " .. symbol, vim.log.levels.WARN)
    return
  end

  if #results == 1 then
    local file, lnum = parse_rg_result(results[1])
    if file and lnum then
      vim.cmd("edit " .. vim.fn.fnameescape(file))
      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      vim.notify("Found: " .. symbol, vim.log.levels.INFO)
    else
      vim.notify("Failed to parse result: " .. results[1], vim.log.levels.ERROR)
    end
    return
  end

  local qf_list = {}
  for _, result_line in ipairs(results) do
    local file, lnum, text = parse_rg_result(result_line)
    if file and lnum then
      table.insert(qf_list, { filename = file, lnum = lnum, text = text or "" })
    end
  end
  vim.fn.setqflist(qf_list)
  vim.cmd("copen")
  vim.notify("Found " .. #results .. " definitions for: " .. symbol, vim.log.levels.INFO)
end

local telescope_reference_search = function()
  telescope.live_grep({
    cwd = require("core.monorepo").get_cwd(),
    prompt_title = "Ignition Reference Search",
    glob_pattern = "*.py",
    additional_args = function() return { "--pcre2" } end,
  })
end

local browse_ignition_symbols = function()
  telescope.live_grep({
    cwd = require("core.monorepo").get_cwd(),
    prompt_title = "Ignition Symbols",
    default_text = "^\\s*(class|def)\\s",
    glob_pattern = "*.py",
  })
end

local ignition_find_files = function()
  telescope.find_files({
    cwd = require("core.monorepo").get_cwd(),
    find_command = { "rg", "--files", "--color", "never", "-g", "*.py", "-g", "*.json" },
  })
end

local scan_ignition = function()
  local secret_path = DATA_PATH .. "\\secrets.json"
  local json_str = table.concat(vim.fn.readfile(secret_path), "\n")
  local header = "X-Ignition-API-Token: " .. vim.json.decode(json_str).ignition
  local response = vim.fn.system({
    "curl", "-XPOST", "-s", "-H", header,
    "http://localhost:8088/data/api/v1/scan/projects",
  })
  vim.notify(response, vim.log.levels.INFO, { title = "Ignition" })
end

local designer_refresh = function()
  local ahk = [[
SetTitleMatchMode(3) ; exact match mode
DetectHiddenWindows(true)
designerTitle := "ASRS - Development - Ignition Designer"
if WinExist(designerTitle) {
	WinActivate(designerTitle)
	Sleep(100)
	x := 52
	y := 43
	click x, y
}
consoleTitle := "Script Console"
if WinExist(consoleTitle) {
	WinActivate(consoleTitle)
  Sleep(500)
	; click the reset button
	click 931, 76
	Sleep(100)
	; run whatever is in the multiline buffer
	Send "^{Enter}"
}
  ]]
  local tempname = vim.fn.tempname() .. ".ahk"
  vim.fn.writefile(vim.split(ahk, "\n"), tempname)
  vim.fn.jobstart({ "autohotkey", tempname }, {
    on_exit = function() vim.fn.delete(tempname) end,
  })
end


local M = {}
M.setup = function()
  require("core.monorepo").setup({ root = DATA_PATH .. "\\projects" })
  local keymaps = {
    { "<leader>ig",  goto_ignition_module,                                            "[ignition] go to module" },
    { "<leader>ifs", function() search_ignition_symbol(vim.fn.expand("<cword>")) end, "[ignition] find symbol" },
    { "<leader>it",  telescope_reference_search,                                      "[ignition] telescope symbol search" },
    { "<leader>ib",  browse_ignition_symbols,                                         "[ignition] browse symbols" },
    { "<leader>ir",  "<cmd>IgnitionReferences<cr>",                                   "[ignition] show references under cursor" },
    { "<leader>iff", ignition_find_files,                                             "find ignition files" },
    { "<leader>ifr", function()
      require("telescope").extensions.frecency.frecency({
        workspace = "IGN",
        path_display = function(_, path)
          return string.sub(path, string.len(DATA_PATH .. "\\projects"))
        end,
      })
    end, "find ignition files frecency" },
    { "<leader>is",  scan_ignition,    "scan ignition" },
    { "<leader>idr", designer_refresh, "designer refresh" },
  }

  for _, km in ipairs(keymaps) do
    vim.keymap.set("n", km[1], km[2], { desc = km[3] })
  end

  vim.api.nvim_create_user_command("IgnitionGoto", goto_ignition_module,
    { desc = "Go to Ignition module under cursor" })
  vim.api.nvim_create_user_command("IgnitionFind", function(opts)
    search_ignition_symbol(opts.args ~= "" and opts.args or vim.fn.expand("<cword>"))
  end, { nargs = "?", desc = "Find Ignition symbol definition" })
  vim.api.nvim_create_user_command("IgnitionSearch", telescope_reference_search,
    { desc = "Search Ignition symbols with Telescope" })
  vim.api.nvim_create_user_command("IgnitionReferences", function()
    telescope.grep_string({ cwd = DATA_PATH .. "\\projects", additional_args = { "-g", "*.py" } })
  end, { desc = "get references under cursor" })
  vim.api.nvim_create_user_command("IgnitionBrowse", browse_ignition_symbols,
    { desc = "Browse all Ignition symbols" })
  vim.api.nvim_create_user_command("IgnitionFiles", ignition_find_files,
    { desc = "Find files in ignition directory" })
  vim.api.nvim_create_user_command("IgnitionScan", scan_ignition,
    { desc = "Trigger scan of ignition files" })

  set_keys()
  vim.api.nvim_buf_create_user_command(0, "FlameOn", set_keys, {})
  vim.api.nvim_buf_create_user_command(0, "FlameOff", del_keys, {})
end

return M
