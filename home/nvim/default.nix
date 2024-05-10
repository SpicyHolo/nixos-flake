{ config, pkgs, ... }:
{
    programs.neovim =
    let
	toLuaFile = file: "${builtins.readFile file}";

    in
    {
	enable = true;
	
	vimAlias = true;	
	
	extraPackages = with pkgs; [
	    ripgrep
	];
	plugins = with pkgs.vimPlugins; [
	
	{
		plugin = telescope-nvim;
		type = "lua";
		config = toLuaFile ./plugins/telescope.lua;
	}

	{
		plugin = catppuccin-nvim;
		type = "lua";
		config = toLuaFile ./plugins/catppuccin.lua;
    	}
	
	{
		plugin = (nvim-treesitter.withPlugins (p: [
			p.tree-sitter-nix
			p.tree-sitter-c
			p.tree-sitter-cpp

			p.tree-sitter-vim
			p.tree-sitter-bash
			p.tree-sitter-lua
			p.tree-sitter-python
			p.tree-sitter-json
		]));
		type = "lua";
		config = toLuaFile ./plugins/treesitter.lua;
	}

	# For LSP
	nvim-lspconfig
	mason-nvim
	mason-lspconfig-nvim
	nvim-cmp
	cmp-nvim-lsp
	cmp-buffer
	cmp-path
	cmp_luasnip
	luasnip
	friendly-snippets
	];
	extraLuaConfig = ''
		${builtins.readFile ./options.lua}
		${builtins.readFile ./remap.lua}
		${builtins.readFile ./lsp.lua}
	'';


    };
}
