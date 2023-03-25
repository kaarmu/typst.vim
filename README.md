# typst.vim

*OBS* Work In Progress

File detection and syntax highlighting for [typst](https://typst.app).

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

