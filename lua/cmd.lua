local cmd = vim.api.nvim_create_user_command

local uv = vim.loop

-- Function to remove files matching the pattern
local function remove_matching_files(directory, pattern)
  -- Open the directory
  local dir = uv.fs_opendir(directory, nil, 100)
  if not dir then
    print("Failed to open directory: " .. directory)
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
    vim.print(dir)

    if vim.fn.getcwd() ~= dir then
      vim.cmd("cd " .. dir)
    end
    vim.cmd.make({ args = { t.args } })
  end
end, { nargs = "*" })
cmd("TrimSpace", [[:%s/\s\+$//ge]], { nargs = 0 })
