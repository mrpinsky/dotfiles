" vim-plug
call plug#begin()

Plug 'robertmeta/nofrils'
Plug 'vim-airline/vim-airline'
  " Show branch foo/bar/baz as f/b/baz
  let g:airline#extensions#branch#format = 2
  " Limit branch display to 10-characters
  let g:airline#extensions#branch#displayed_head_limit = 15
  " Show linter status in airline bar
  let g:airline#extensions#ale#enabled=1
  " keep sign gutter open at all times
  let g:ale_sign_column_always=1
  " Show all buffers when there's only one tab open
  let g:airline#extensions#tabline#enabled = 1
  " Don't show file encoding & format if it's this string, since that's what we expect
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
  let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
let g:ale_enabled=1

Plug 'mhinz/vim-grepper'
  let g:grepper = { 'tools': ['ag'] }
  nnoremap \a :Grepper<CR>

Plug '~/.fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive' 	" Git commands
Plug 'tpope/vim-rhubarb'        " Mostly for :Gbrowse
Plug 'tpope/vim-eunuch'         " For Unix stuff: :Move, :Rename, etc
Plug 'tpope/vim-commentary'     " :gc[c]
" Plug 'tpope/vim-bundler'        " Call bundler utils from Vim
Plug 'tpope/vim-sensible'       " 'Neutral ground' default settings
Plug 'tpope/vim-surround'       " Surrounding motions
Plug 'tpope/vim-endwise', { 'for': ['ruby','sh'] }      " Automatically add `end`s
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
