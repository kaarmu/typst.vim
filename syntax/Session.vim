let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/typst.vim/syntax
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +54 typst.vim
badd +0 ~/Documents/Overleaf/thesis_draft/templates/ieee/main.typ
argglobal
%argdel
$argadd typst.vim
edit typst.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 97 + 98) / 196)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 97 + 98) / 196)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 196)
argglobal
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=10
setlocal fml=1
setlocal fdn=3
setlocal fen
let s:l = 110 - ((19 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 110
normal! 030|
wincmd w
argglobal
enew | setl bt=help
help :syn-region@en
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=10
setlocal fml=1
setlocal fdn=3
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 3884 - ((5 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3884
normal! 029|
wincmd w
argglobal
if bufexists(fnamemodify("~/Documents/Overleaf/thesis_draft/templates/ieee/main.typ", ":p")) | buffer ~/Documents/Overleaf/thesis_draft/templates/ieee/main.typ | else | edit ~/Documents/Overleaf/thesis_draft/templates/ieee/main.typ | endif
if &buftype ==# 'terminal'
  silent file ~/Documents/Overleaf/thesis_draft/templates/ieee/main.typ
endif
balt typst.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=10
setlocal fml=1
setlocal fdn=3
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 10 - ((9 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 013|
wincmd w
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 97 + 98) / 196)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 97 + 98) / 196)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 196)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
