syntax on
filetype on
set scrolloff=5
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2   " Indents will have a width of 4 set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set ic
set hls
set number
set autoindent
set ruler
set makeprg=d8\ --print-code\ %\ $*
autocmd BufNewFile *.js 0r ~/.vim/templates/js/requireWithDefine.tpl
autocmd BufRead, BufNewFile *.jade setlocal spell spelllang=en_us
"autocmd BufReadPost * lcd %:h Is not working as expected - need recursively search from root path

set laststatus=2                             " always show statusbar  
set statusline=  
set statusline+=%-10.3n\                     " buffer number  
set statusline+=%f\                          " filename   
set statusline+=%h%m%r%w                     " status flags  
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
set statusline+=%=                           " right align remainder  
set statusline+=0x%-8B                       " character value  
set statusline+=%-14(%l,%c%V%)               " line, character  
set statusline+=%<%P                         " file position  

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

if match($TERM, "screen")!=- 1
  set term=xterm
endif

" Netrw CONFIGURATION START
let g:netrw_liststyle= 4 
" Netrw CONFIGURATION END

"  JSHint CONFIGURATION START
if !&diff
  set runtimepath+=~/.vim/bundle/jshint2.vim/.
endif
let jshint2_read = 1
let jshint2_save = 1
let jshint2_close = 0
let jshint2_height = 10
" JSHint CONFIGURATION END

" Mappings START
map <F4> :execute "grep -nr --include=\"*.coffee\" -w ".expand("<cword>")." ./" <Bar> cw<CR>
map <F10> :mksession! ~/mysession.vim<CR>
map <F12> :source ~/mysession.vim<CR>
map <C-n> :tabf ./
map <M-Left> :tabprevious<CR>
map <M-Right> :tabnext<CR>
map <C-c> :bd<CR>
map <C-h> :set list!<CR>
map <F3> :call ExecGrepWithQuickFixOutput("*.js", expand("<cword>"))<CR>
map <F4> :call ExecGrepWithQuickFixOutput("*.styl", expand("cword"))<CR>
map <C-d> :call CdToCurrentOpened()<CR>
map <C-t> :shell<CR>
map <C-q> :cw<CR>
" Mappings END

" Functions START
function! GlobalReplace(toReplace, replacement, fileList)
  find ./ -name "*.js" | xargs sed -i 's/Backbone.history.navigate/app.router.navigate/g'
endfunction

function! SendToDo(windowType) " windowType stands for vertical split or new tab or smthing else
  sp
  imap
endfunction

function! ToggleSendMappings()
  map <C-s>
endfunction

function! DisassembleJS()
  " TODO!
  let command = "d8 --trace-opt-verbose " . expand("%:p")
  let output = system(command)
  vnew 
  echo command
  call setline(0, command)
  put =output
endfunction

function! ExecGrepWithQuickFixOutput(filesMask, word)
  :execute "grep -nr --include=\"".a:filesMask."\" -w ".a:word." ./ | :cw<CR>"
endfunction

function! CloseAllBuffers()
  let b_all = range(1, bufnr('$'))
  let listed = filter(b_all, 'buflisted(v:val)')
  for i in listed
    echo i
    execute "bd ".i
   endfor
endfunction

function! CdToCurrentOpened()
  let currentFileName = expand('%:p')
  if isdirectory(currentFileName) 
    let currentDir = currentFileName
  else
    let currentDir = substitute(currentFileName, '\/[^\/]*$', "", "")
  endif
  execute "cd " . currentDir 
endfunction

function! SaveSessionAndShutDown()
  mksession! ~/mysession.vim
  !bash -c -i off
endfunction
" Functions END

set suffixesadd+=.coffee
set path+=/home/alukyanov/project/geenio-frontend/app,/home/alukjanov/project/geenio.deploy/www/front/source/js
set noswapfile
