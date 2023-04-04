# typst.vim

*OBS* Work In Progress

File detection and syntax highlighting for [Typst](https://typst.app).

## Features

*(Existing)*
- Vim syntax highlighting.
- Compile the active document with `:make`.

*(Possible features)*
- Formatting using [this](https://github.com/astrale-sharp/typst-fmt/)?
- Even better highlighting for neovim using treesitter?

## Installation

### packer.nvim

```lua
require('packer').startup(function(use)

    use {'kaarmu/typst.vim', ft = {'typ'}}

end)
```

- Restart neovim to reload config
- Call `:PackerSync`

### lazy.nvim
```lua
return {
  'kaarmu/typst.vim',
  ft = 'typ',
  lazy=false,
}
```

### vim-plug

```vim
call plug#begin('~/.vim/plugged')
    Plug 'kaarmu/typst.vim'
call plug#end()
```

- Restart (neo)vim to reload config
- Call `:PlugInstall`

## Tips

If you are using `neovim` you can install [typst-lsp](https://github.com/nvarner/typst-lsp).
There exist a server configuration in `nvim-lspconfig` so it should be easy to set it up. The
config currently requires that you're working in a git repo. Once the neovim+LSP recognizes
the file the LSP will compile your document while you write (almost like a wysiwyg!).

