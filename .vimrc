syntax on
filetype on
set scrolloff=5
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2   " Indents will have a width of 4
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set ic
set hls
set number
set autoindent
set ruler

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Mappings START
map <F4> :execute "grep -nr --include=\"*.coffee\" -w ".expand("<cword>")." ./" <Bar> cw<CR>
map <F10> :mksession! ~/mysession.vim<CR>
map <F12> :source ~/mysession.vim<CR>
map <C-n> :tabf ./
map <M-Left> :tabprevious<CR>
map <M-Right> :tabnext<CR>
map <C-c> :bd<CR>
"TODO!!
map <F3> :call ExecGrepWithQuickFixOutput("*.js")<CR>
" Mappings END

" Functions START
function! ExecGrepWithQuickFixOutput(filesMask)
  "echo a:filesMask
  :execute "grep -nr --include=\"".a:filesMask."\" -w ".expand("<cword>")." ./ | :cw<CR>"
endfunction

function! OpenToDoFile()

endfunction

function! DetermineCwd()
  
endfunction
" Functions END

set suffixesadd+=.coffee
set path+=/home/alukyanov/project/geenio-frontend/app,/home/alukjanov/project/geenio.deploy/www/front/source/js
set noswapfile
