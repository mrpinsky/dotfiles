let g:mapleader=','

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'robertmeta/nofrils'
Plug 'vim-airline/vim-airline'
  " Show linter status in airline bar
  let g:airline#extensions#ale#enabled=1
  " keep sign gutter open at all times
  let g:ale_sign_column_always=1
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
let g:ale_enabled=1

Plug 'mhinz/vim-grepper'
  let g:grepper = { 'tools': ['ag'] }
  nnoremap \a :Grepper<CR>

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive' 	" Git commands
Plug 'tpope/vim-rhubarb'        " Mostly for :Gbrowse
Plug 'tpope/vim-eunuch'         " For Unix stuff: :Move, :Rename, etc
Plug 'tpope/vim-commentary'     " :gc[c]
" Plug 'tpope/vim-bundler'        " Call bundler utils from Vim
Plug 'tpope/vim-sensible'       " 'Neutral ground' default settings
Plug 'tpope/vim-surround'       " Surrounding motions
Plug 'tpope/vim-endwise',       " Automatically add `end`s
     \ { 'for': ['ruby','sh'] }
Plug 'tpope/vim-jdaddy'         " Tim Pope handles JSON in vim!
Plug 'tpope/vim-repeat'         " Make `.` work better with plugin commands
Plug 'tpope/vim-abolish'        " Handle lexicographical variants: capitalization, pluralization, snake <-> camel
Plug 'tpope/vim-projectionist'  " Provides :E, :S, :V, :T, :A, :AS, :AV, and :AT
Plug 'tpope/vim-dispatch'       " Run a shell command in Tmux split, get results in quickfix
  let g:dispatch_quickfix_height=20
  let g:dispatch_tmux_height=30

Plug 'mhinz/vim-signify'        " Show diff status in gutter
  let g:signify_vcs_list=['git']
  let g:signify_realtime=1
  let g:signify_cursorhold_normal=0
  let g:signify_cursorhold_insert=0

Plug 'travisjeffery/vim-auto-mkdir'

" Navigate tmux and vim splits with the same commands
Plug 'christoomey/vim-tmux-navigator'
  let g:tmux_navigator_no_mappings=1
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>

" Low-overhead language support
Plug 'sheerun/vim-polyglot'
  " Disable weird Haskell indentation
  let g:haskell_indent_disable=1
  let g:polyglot_disabled = ['groovy']

Plug 'fatih/vim-go'

" Show indentation
Plug 'yggdroot/indentline'
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Use arrow keys to resize splits
Plug 'talek/obvious-resize'
  let g:obvious_resize_default=5
  nnoremap <silent> <LEFT> :<C-U>ObviousResizeLeft<CR>
  nnoremap <silent> <RIGHT> :<C-U>ObviousResizeRight<CR>
  nnoremap <silent> <UP> :<C-U>ObviousResizeUp<CR>
  nnoremap <silent> <DOWN> :<C-U>ObviousResizeDown<CR>

Plug 'andrewradev/splitjoin.vim'

Plug 'vim-scripts/greplace.vim'
Plug 'vim-scripts/HTML-AutoCloseTag'

" Uncomment if I need to run RSpec often at Square
Plug 'thoughtbot/vim-rspec'
  let g:rspec_command = "Dispatch bundle exec rspec {spec}"
  let g:rspec_runner = "os_x_iterm"

call plug#end()

" Load all plugins now
" Plugins need to be added to runtimepath berfore helptags can be generated
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored
silent! helptags ALL

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  autocmd BufReadPost * highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  autocmd BufReadPost * highlight SignifySignAdd    cterm=bold ctermbg=2    ctermfg=4
  autocmd BufReadPost * highlight SignifySignChange cterm=bold ctermbg=5    ctermfg=3
  " When editing a file, always jump to the last known cursor position.
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping. If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Use Vim settings, rather than Vi
" This must be first, because it changes other options as a side effect
set nocompatible
set splitright
set splitbelow
set mousehide
set winminheight=0
set number
set noswapfile
set expandtab
set shiftwidth=2
set softtabstop=2
set textwidth=80
set list

if expand('%:e') =~ "zsh-theme"
  set ft=zsh
endif

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
set wildignore+=**/coverage/*,**/spec/reports/*,**/tmp/*,**/node_modules/*,**/build/*

set guifont=Inconsolata_for_Powerline:h18
let g:airline_theme = "sol"
let g:airline_powerline_fonts = 1
colorscheme nofrils-dark

set ignorecase " searches are case insensitive
set smartcase  " ... unless they contain at least one captial letter

set iskeyword+=- " add dash to keywords (used in motions)

" gp selects last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" don't lose register when pasting over
vnoremap p gpvy

" FZF Bindings
nnoremap <leader>t :Files<CR>
nnoremap <leader>a :Rg<CR>

nnoremap <C-n> :call ToggleNumbers()<CR>

nnoremap s :Git<CR>

nmap <leader>c ct_
nmap <leader>C c/[A-Z]<CR>
nmap <leader>d df_
nmap <leader>D d/[A-Z]<CR>

"For these files, strip out trailing white space at the end of lines.
" autocmd FileType cucumber,ruby,yaml,eruby,coffee,elm autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

autocmd FileType elm,haskell,cs setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType haskell call HaskellSupport()
autocmd FileType ruby,javascript,c setlocal expandtab shiftwidth=2 softtabstop=2
autocmd Filetype javascript,c,ruby call CStyleSyntaxHelpers()
autocmd Filetype ruby,erb,haml call LoadRubyMaps()
autocmd Filetype elixir call ElixirSupport()

function! HaskellSupport()
  nnoremap <Leader>ht :GhcModType<cr>
  nnoremap <Leader>htc :GhcModTypeClear<cr>
  " May only work with custom fork of w0rp/ale
  " See https://monicalent.com/blog/2017/11/19/haskell-in-vim/
  " nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
endfunction

function! RspecDispatch()
  " " ,s spec line
  " nnoremap <Leader>s :Dispatch bin/rspec <C-r>=expand("%:p")<CR>:<C-r>=line(".")<CR> --format doc<CR>
  " " ,S spec file
  " nnoremap <Leader>S :Dispatch bin/rspec <C-r>=expand("%:p")<CR> --format doc<CR>
  " " ,L spec file only failures
  " nnoremap <Leader>L :Dispatch bin/rspec <C-r>=expand("%:p")<CR> --only-failures --fail-fast --format doc<CR>
  map <Leader>S :call RunCurrentSpecFile()<CR>
  map <Leader>fS :let g:rspec_command.=' --fail-fast' \| call RunCurrentSpecFile() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>nS :let g:rspec_command.=' --next-failure' \| call RunCurrentSpecFile() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>s :call RunNearestSpec()<CR>
  map <Leader>fs :let g:rspec_command.=' --fail-fast' \| call RunNearestSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>l :call RunLastSpec()<CR>
  map <Leader>fl :let g:rspec_command.=' --fail-fast' \| call RunLastSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>nl :let g:rspec_command.=' --next-failure' \| call RunLastSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
endfunction

function! ElixirSupport()
  nmap <Leader>P Orequire IEx<CR>IEx.pry()<ESC>
  call ExUnitDispatch()
endfunction

function! ExUnitDispatch()
  " ,s spec line
  nnoremap <Leader>s :Dispatch mix test <C-r>=expand("%:p")<CR>:<C-r>=line(".")<CR><CR>
  " ,S spec file
  nnoremap <Leader>S :Dispatch mix test <C-r>=expand("%:p")<CR><CR>
  " " ,L spec file only failures
  " nnoremap <Leader>L :Dispatch bin/rspec <C-r>=expand("%:p")<CR> --only-failures --fail-fast --format doc<CR>
endfunction

function! LoadRubyMaps()
  " " ,b remote pry
  " nnoremap <Leader>b Orequire 'pry'; binding.remote_pry<ESC>
  " " ,: update Ruby hash syntax
  " vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " " ,j ,k jump to next/previous method
  " nmap <Leader>jm ]m
  " nmap <Leader>km [m
  " " ,m memoize a Ruby method
  " nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
  call RspecDispatch()
endfunction

function! CStyleSyntaxHelpers()
  nnoremap gs :s/(\zs\s*\\|,\zs\s*\\|\ze)/\r/g<CR>=ip
endfunction

function! ToggleNumbers()
  if (!&number && !&relativenumber)
    set number
  elseif (!&relativenumber)
    set relativenumber
  else
    set norelativenumber
  endif
endfunction
