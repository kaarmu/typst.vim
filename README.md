# typst.vim

*OBS: Work In Progress*

(Neo)vim plugin for [Typst](https://typst.app).

I am applying the 80/20 rule in this project since I prefer to have
something now rather than waiting for everthing later.

## Features

![image](https://user-images.githubusercontent.com/19633647/230785889-0d449fc3-747b-4183-b00b-14c0ea8dd590.png)
*Editing [typst-palette](https://github.com/kaarmu/typst-palette) in Vim with the gruvbox colorscheme*

**Existing**
- Vim syntax highlighting.
- Compile the active document with `:make`.
- Basic concealing for italic and bold (more to come). You must `set conceallevel=2` for this to work.

**Possible features**
- Formatting using [this](https://github.com/astrale-sharp/typst-fmt/)?
- Even better highlighting for neovim using treesitter?

Do you miss anything from other packages, e.g. `vimtex`, create an issue
and I'll probably add it! Also feel free to make a PR!

## Installation

### packer.nvim

```lua
require('packer').startup(function(use)

    use {'kaarmu/typst.vim', ft = {'typst'}}

end)
```

- Restart neovim to reload config
- Call `:PackerSync`

### lazy.nvim
```lua
return {
  'kaarmu/typst.vim',
  ft = 'typst',
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

## Usage

`g:typst_cmd` - Specifies the location of the Typst executable. Defaults to `"typst"`.

`g:typst_pdf_viewer` - Specifies pdf viewer that `typst watch --open` will use.

`g:typst_auto_close_toc` - Specifies whether TOC will be automatically closed after using it.

`:TypstWatch` - Watches your document and recompiles on change; also opens the document with your default pdf viewer.

## Tips

If you are using `neovim` you can install [typst-lsp](https://github.com/nvarner/typst-lsp).
There exist a server configuration in `nvim-lspconfig` so it should be easy to set it up. The
config currently requires that you're working in a git repo. Once the neovim+LSP recognizes
the file the LSP will compile your document while you write (almost like a wysiwyg!). By default
it will compile on save but you can set it to compile-on-write as well.

