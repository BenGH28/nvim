" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/ben/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/ben/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/ben/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/ben/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ben/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  edge = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/edge"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["neo-runner.nvim"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/neo-runner.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ben/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ben/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
