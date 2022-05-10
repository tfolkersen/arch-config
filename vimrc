set tabstop=4
set shiftwidth=4
syntax on
color elise_clear
set nofoldenable
set expandtab

map <F1> :prev<CR><C-g>
map <F2> :n<CR><C-g>

"nnoremap <F1> gT
"nnoremap <F2> gt


nnoremap tn :tabnew<CR>
nnoremap te :tabnew<CR>:E<CR>

nnoremap <F11> :set noexpandtab<CR>
nnoremap <F12> :set expandtab<CR>



"function InsertStuff()
"let var1 = input("pl suffix:")
"let var2 = input("variable name:")

"let lineNo = line('.') - 1
"call append(lineNo, '        svfloat64_t pl' . var1 . ' = PACKLOAD_B(npn);')
"call append(lineNo + 1, '        svfloat64_t ' . var2 . ' = pl' . var1 . ';')
"endfunction

"nnoremap <F2> :call InsertStuff()<CR>
"nnoremap <F1> i//<ESC>





nnoremap <F5> :qall<CR>

nnoremap <Esc>[1;5C gt
"nnoremap <Esc>[1;3B <C-w>j
nnoremap <Esc>[1;5D gT
"nnoremap <Esc>[1;3A <C-w>k

nnoremap <Esc>[1;3C <C-w>l
nnoremap <Esc>[1;3B <C-w>j
nnoremap <Esc>[1;3D <C-w>h
nnoremap <Esc>[1;3A <C-w>k





nnoremap <Esc>[1;6C :tabm+<CR>
nnoremap <Esc>[1;6D :tabm-<CR>

