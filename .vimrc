" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'elmcast/elm-vim', { 'for': ['vim'] }
  let g:elm_setup_keybindings = 0
  nnoremap \m :w<CR><Plug>(elm-make)
  nnoremap \e <Plug>(elm-error-detail)
  nnoremap \f <Plug>(elm-format)
  nnoremap \d <Plug>(elm-oracle)
  nnoremap \t <Plug>(elm-test)
Plug 'vim-airline/vim-airline'
  " Show linter status in airline bar
  let g:airline#extensions#ale#enabled = 1
  " keep sign gutter open at all times
  let g:ale_sign_column_always = 1
  let g:ale_linters = {'haskell': ['stack-build']}
Plug 'vim-airline/vim-airline-themes'
Plug 'mileszs/ack.vim'
  nnoremap \a :Ack!<space>
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
Plug 'scrooloose/nerdtree'
  let g:NERDTreeShowHidden=1
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise', { 'for': ['ruby','sh'] }
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
  let g:dispatch_quickfix_height=20
  let g:dispatch_tmux_height=30
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-gtfo'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'travisjeffery/vim-auto-mkdir'
Plug 'christoomey/vim-tmux-navigator'
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>

Plug 'sheerun/vim-polyglot'
  " elm-vim takes care of that
  let g:polyglot_disabled = ['elm']
  " Disable weird Haskell indentation
  let g:haskell_indent_disable = 1
Plug 'yggdroot/indentline'
  let g:indentLine_color_term = 239
  let g:indentLine_char = '.'
  map <leader>i :IndentLinesToggle<CR>
Plug 'talek/obvious-resize'
  " Arrow keys resize window
  let g:obvious_resize_default=5
  nnoremap <silent> <LEFT> :<C-U>ObviousResizeLeft<CR>
  nnoremap <silent> <RIGHT> :<C-U>ObviousResizeRight<CR>
  nnoremap <silent> <DOWN> :<C-U>ObviousResizeDown<CR>
  nnoremap <silent> <UP> :<C-U>ObviousResizeUp<CR>
Plug 'andrewradev/splitjoin.vim'
Plug 'alfredodeza/jacinto.vim'
Plug 'vim-scripts/greplace.vim'
Plug 'dewyze/vim-ruby-block-helpers'
Plug 'thoughtbot/vim-rspec'
  let g:rspec_command = "Dispatch bin/rspec {spec}"
Plug 'altercation/vim-colors-solarized'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
call plug#end()

" Load all plugins now
" Plugins need to be added to runtimepath berfore helptags can be generated
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored
silent! helptags ALL

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set splitright
set splitbelow
set undolevels=1000
set encoding=utf-8
if has("vms")
  set nobackup " do not keep a backup file, use versions instead
else
  set backup " keep a backup file (restore to previous version) set undofile		" keep an undo file (undo changes after closing)
endif
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set mousehide
set winminheight=0
set number
set noswapfile
set nobackup
set expandtab
set shiftwidth=2
set softtabstop=2
set textwidth=80
set list

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
set wildignore+=**/coverage/*,**/spec/reports/*,**/tmp/*,**/node_modules/*,**/build/*

set guifont=Inconsolata_for_Powerline:h18
set background=dark
let g:airline_theme = "sol"
let g:airline_powerline_fonts = 1
colorscheme peachpuff

set ignorecase "searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter

set iskeyword+=- "add dash to keywords (for e, b, *)

let g:mapleader=','

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

",n toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

map <leader>rt :TagbarToggle<CR>

" Shift-Y should copy to end of line, like Shift-D deletes to end of line
noremap Y y$
" gp selects last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" don't lose register when pasting over
vnoremap p pgvy
" FZF Bindings
nnoremap B :Buffers<CR>
nnoremap <Leader>r :Tags<CR>
nnoremap <Leader>t :Files<CR>
nnoremap <Leader>a :Ag<CR>
" Line numbers
nnoremap <C-n> :call ToggleNumbers()<CR>

"For these files, strip out trailing white space at the end of lines.
autocmd FileType cucumber,ruby,yaml,eruby,coffee,elm autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

autocmd FileType elm,haskell setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType haskell call HaskellSupport()
autocmd FileType ruby,javascript,c setlocal expandtab shiftwidth=2 softtabstop=2
autocmd Filetype javascript,c,ruby call CStyleSyntaxHelpers()
autocmd Filetype ruby,erb,haml call LoadRubyMaps()
autocmd Filetype c,elixir call UnderscoreSupport()

function! HaskellSupport()
  nnoremap <Leader>ht :GhcModType<cr>
  nnoremap <Leader>htc :GhcModTypeClear<cr>
  " May only work with custom fork of w0rp/ale
  " See https://monicalent.com/blog/2017/11/19/haskell-in-vim/
  nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
endfunction

function! UnderscoreSupport()
  nmap <Leader>c ct_
  nmap <Leader>C c/[A-Z]<CR>
  nmap <Leader>d df_
  nmap <Leader>D d/[A-Z]<CR>
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
  map <Leader>s :call RunNearestSpec()<CR>
  map <Leader>fs :let g:rspec_command.=' --fail-fast' \| call RunNearestSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
  map <Leader>l :call RunLastSpec()<CR>
  map <Leader>fl :let g:rspec_command.=' --fail-fast' \| call RunLastSpec() \| let g:rspec_command=join(split(g:rspec_command)[0:-2])<CR>
endfunction

function! LoadRubyMaps()
  " ,b remote pry
  nnoremap <Leader>b Orequire 'pry'; binding.remote_pry<ESC>
  " ,: update Ruby hash syntax
  vnoremap <silent> <Leader>: :ChangeHashSyntax<CR>
  " ,j ,k jump to next/previous method
  nmap <Leader>j ]m
  nmap <Leader>k [m
  " ,m memoize a Ruby method
  nmap <Leader>m [mwy$oreturn @0 if defined?(@0)jI@0 = l
  call RspecDispatch()
  call UnderscoreSupport()
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

" function! DeMorganize()
"   let words = split(getline('.'))
"   echo map(words, function('DeMorganizeWord'))
" endfunction

" function! DeMorganizeWord(index, word)
"   if a:index == 0
"     return "if"
"   elseif a:word == "&&"
"     return "||"
"   elseif a:word == "||"
"     return "&&"
"   elseif a:word =~ "!\\(\\S\\+\\)"
"     return substitute(a:word, "!\(\S\)+", "\\1")
"   else
"     return "!" . a:word
"   endif
" endfunction
