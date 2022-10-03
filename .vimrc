let g:mapleader=','

source ~/dotfiles/plugs.vim

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

set guifont=Fira_Code:h18
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
nnoremap <leader>a :Ag<CR>

nnoremap <C-n> :call ToggleNumbers()<CR>

nnoremap s :Git<CR>

nmap <leader>c ct_
nmap <leader>C c/[A-Z]<CR>
nmap <leader>d df_
nmap <leader>D d/[A-Z]<CR>

nmap gd <Plug>(ale_go_to_definition)
nmap td <Plug>(ale_go_to_definition_in_tab)
nmap sd <Plug>(ale_go_to_definition_in_split)
nmap vd <Plug>(ale_go_to_definition_in_vsplit)

nmap gI <Plug>(ale_go_to_implementation)
nmap tI <Plug>(ale_go_to_implementation_in_tab)
nmap sI <Plug>(ale_go_to_implementation_in_split)
nmap vI <Plug>(ale_go_to_implementation_in_vsplit)

nmap gT <Plug>(ale_go_to_type_definition)
nmap tT <Plug>(ale_go_to_type_definition_in_tab)
nmap sT <Plug>(ale_go_to_type_definition_in_split)
" There's a bug in ALE's plug mapping for this one
nmap vT :ALEGoToTypeDefinition -vsplit<CR>

nmap grp :ALEFindReferences -relative<CR>
nmap grq :ALEFindReferences -quickfix<CR>
nmap gR :ALERepeatSelection<CR>
nmap gh <Plug>(ale_hover)
nmap ai <Plug>(ale_import)

imap <C-n> <Plug>(ale_complete)

"For these files, strip out trailing white space at the end of lines.
autocmd FileType cucumber,ruby,yaml,eruby,coffee,elm autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

autocmd FileType elm,haskell,cs setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType haskell call HaskellSupport()
autocmd FileType ruby,javascript,c setlocal expandtab shiftwidth=2 softtabstop=2
autocmd Filetype javascript,c,ruby call CStyleSyntaxHelpers()
autocmd Filetype ruby,erb,haml call LoadRubyMaps()
autocmd Filetype elixir call ElixirSupport()
autocmd Filetype typescript setlocal noexpandtab tabstop=2

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

if has('nvim')
  " Keep block cursor in insert mode
  set guicursor=
endif
