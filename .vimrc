syntax on
set fileformat=unix
set number
set nocompatible
set autoindent
set cindent
set ts=4
set shiftwidth=4
set showmatch "显示匹配的括号
set fenc=utf-8
set cursorline
set cursorcolumn
set expandtab
set hlsearch
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" plugins put here
Bundle 'taglist.vim'
Bundle 'ctrlpvim/ctrlp.vim'

" taglist begin
let Tlist_Ctags_Cmd="/usr/local/Cellar/ctags/5.8_1/bin/ctags" 
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                   "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
map <F2> :TlistToggle<CR>              "热键设置，我设置成Leader+t来呼出和关闭Taglist
" taglist end

" MerdTree
Plugin 'scrooloose/nerdtree'
" NERDTree config
map <F3> :NERDTreeToggle<CR>
" 如果打开的文件除了NERDTree没有其他文件时，自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"autocmd vimenter * NERDTree

" ctrlp
set wildignore+=*/tmp/*,*/bin/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
  \ }

Plugin 'fatih/vim-go'
set autowrite
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
"nnoremap <leader>a :cclose<CR>
let g:go_fmt_command = "goimports"

Plugin 'Valloric/YouCompleteMe'
Plugin 'tagbar'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
set completeopt=longest,menu
" 设置跳转到方法/函数定义的快捷键
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 触发补全快捷键
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" '<c-p>' ''<c-n>''
let g:ycm_auto_trigger = 1
" 最小自动触发补全的字符大小设置为 3
let g:ycm_min_num_of_chars_for_completion = 3
" YCM的previw窗口比较恼人，还是关闭比较好
set completeopt-=preview
let g:ycm_python_binary_path = '/usr/local/bin/python'

"按F5运行python"
map <F5> :w<CR> :call RunPython()<CR>

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go', 
    \ 'kinds'     : [     
        \ 'p:package',
        \ 'i:imports:1',  
        \ 'c:constants',  
        \ 'v:variables',  
        \ 't:types',      
        \ 'n:interfaces', 
        \ 'w:fields',     
        \ 'e:embedded',   
        \ 'm:methods',    
        \ 'r:constructor',
        \ 'f:functions'   
    \ ],                  
    \ 'sro' : '.',
    \ 'kind2scope' : {    
        \ 't' : 'ctype',  
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

call vundle#end()
filetype plugin indent on
                                                                        
function RunPython()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  setlocal makeprg=python\ -u
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg = mp
  let &errorformat = ef
endfunction
                                                                        
"colorscheme molokai
let g:molokai_original = 1
