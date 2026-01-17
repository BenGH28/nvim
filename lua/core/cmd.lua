local cmd = vim.api.nvim_create_user_command

local uv = vim.loop

-- Function to remove files matching the pattern
local function remove_matching_files(directory, pattern)
  -- Open the directory
  local dir = uv.fs_opendir(directory, nil, 100)
  if not dir then
    vim.print("Failed to open directory: " .. directory)
    return
  end

  -- Read entries in the directory
  while true do
    local entries = uv.fs_readdir(dir)
    if not entries then break end
    for _, entry in ipairs(entries) do
      if entry.type == "file" and entry.name:match(pattern) then
        local filepath = directory .. "/" .. entry.name
        os.execute("rm -f " .. filepath)
      end
    end
  end

  -- Close the directory
  uv.fs_closedir(dir)
end

cmd("CleanShada", function()
  -- E138: All C:\Users\bhunt\AppData\Local\nvim-data\shada\main.shada.tmp.X
  -- Specify the directory and pattern
  local directory = vim.fn.stdpath("state") .. "/" .. "shada/" -- Typically where shada files are stored
  local pattern = "^main%.shada%.tmp%..+$"

  -- Remove matching files
  remove_matching_files(directory, pattern)
end, { nargs = 0 })

cmd("Make", function(t)
  local result = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()
  if result.code == 0 then
    local dir = vim.trim(result.stdout)
    if vim.fn.getcwd() ~= dir then
      vim.cmd("cd " .. dir)
    end
    if #t.args > 0 then
      vim.cmd.make({ args = { t.args }, bang = t.bang })
    else
      vim.cmd.make({ bang = t.bang })
    end
  end
end, { nargs = "*", bang = true })

cmd("TrimSpace", [[:%s/\s\+$//ge]], { nargs = 0 })



local explore = {
  left = "Lexplore",
  right = "Lexplore!",
  bottom = "Hexplore",
  top = "Hexplore!",
  tabbed = "Texplore",
  full = "Explore",
}

cmd("Configs", function(args)
  local direction = nil
  if #args.args > 0 then
    direction = args.args
  else
    direction = "bottom"
  end
  -- override defaults with user opts
  local configs = vim.fn.stdpath "config"
  vim.cmd(explore[direction] .. " " .. configs)
end, {
  nargs = '?',
  complete = function(a, b)
    return vim.tbl_keys(explore)
  end
})
