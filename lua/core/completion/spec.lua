local spec = {

	--the next-gen completion engine
	{ "hrsh7th/nvim-cmp" },

	-- complete based on the lsp
	{ "hrsh7th/cmp-nvim-lsp" },

	-- get completion data for a given path
	{ "hrsh7th/cmp-path" },

	-- get compeletion specific to the buffer
	{ "hrsh7th/cmp-buffer" },

	-- completion base on the nvim api
	{ "hrsh7th/cmp-nvim-lua" },

	-- cmdline completion
	{ "hrsh7th/cmp-cmdline" },

	-- tmux completion
	{ "andersevenrud/cmp-tmux" },

	-- snippet run
	{ "hrsh7th/cmp-vsnip" },

	-- sort python dunder methods below regular methods
	{ "lukas-reineke/cmp-under-comparator" },
}
return spec
