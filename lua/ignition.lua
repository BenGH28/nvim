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
  vim.notify(response)
end

vim.api.nvim_create_user_command("FlameScan", flame_scan, { desc = "Trigger scan of ignition files" })
