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
		plugin = harpoon;
		type = "lua";
		config = toLuaFile ./plugins/harpoon.lua;
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
      p.tree-sitter-go
		]));
		type = "lua";
		config = toLuaFile ./plugins/treesitter.lua;
	}

  # LSP
  nvim-lspconfig
  nvim-cmp 
  cmp-nvim-lsp
  cmp_luasnip
  luasnip
  
  # Eyecandy
  indentLine

	];


	extraLuaConfig = ''
		${builtins.readFile ./options.lua}
		${builtins.readFile ./remap.lua}
		${builtins.readFile ./lsp.lua}
	'';

    };
}
