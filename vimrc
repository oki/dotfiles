" :let $VIMRUNTIME = "/Applications/Vim.app/Contents/Resources/vim"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
if has("vms")
  set backup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  "syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

if has("gui_running")
	cmap :q bdelete
endif

autocmd BufEnter *.tt set ft=tt2
autocmd BufEnter *.test set ft=c
imap [H <Home>
imap [F <End>
nmap <silent> <unique> <F3> <Plug>SelectBuf
nnoremap <silent> <F8> :Tlist<CR>
let Tlist_Ctags_Cmd="exctags"

set showmatch
set nohls
set laststatus=2
set wildmenu
set shell=bash
set lazyredraw
set background=dark
set formatoptions=tcqn21
set pastetoggle=<F12>

syntax on
autocmd FileType spec set tw=70

let g:man_vertical_split = 0

set fileencodings=utf-8,latin2
let tidy_compiler_040800=1

let perl_extended_vars=1

"""""
" no beep
"set visualbell
autocmd FileType perl compiler perl
imap  
cmap  

" statusbar
"set statusline=%<\ %f%h%m%r\ l:%l\ c:%c\ %=\ %L\ %P
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%1*%F%*\ %y\ %2*%r%m%*\ %=%l/%L\ (%p%%)
"
hi statusline cterm=reverse ctermbg=white ctermfg=blue

" wciecia
set background=dark

"set sw=3
"set ts=3

se expandtab
se shiftwidth=2
se softtabstop=2
se tabstop=2

" mapki
map @# :! perl -wc %<CR>
"map @@ :! sudo -u root /usr/local/sbin/apachectl graceful<CR>


" linie, gora dol
map 11 10jzz_
map 22 10kzz_

autocmd BufEnter *.cgi,*.pl,*.pm,*.t,*.xtt,*.test call PerlType()
autocmd TabEnter *.cgi,*.pl,*.pm,*.t,*.xtt,*.test call PerlType()

autocmd BufEnter *.html,*.htm,*.js call Html()
autocmd TabEnter *.html,*.htm,*.js call Html()

autocmd BufEnter *.rb call RubyType()
"autocmd TabEnter *.rb call RubyType()

"autocmd FileType ruby call FileType_Rails()


"autocmd BufEnter *.html,*.htm,*.js emenu SnippetMagic.html

"autocmd BufEnter *.rb emenu SnippetMagic.rails
"autocmd TabEnter *.rb emenu SnippetMagic.rails

"autocmd BufEnter *.rhtml emenu SnippetMagic.rails
"autocmd TabEnter *.rhtml emenu SnippetMagic.rails

function Html()
    set noai
    set indentkeys = " "
endfunction

"set keywordprg='/home/oki/bin/perlhelp.sh'
set dictionary=/home/oki/.vim/perlfun
"set complete=i,k,d,t
"set complete+=i,k~/.vim/perlinclude,k,d,t
"
function RubyType()
    map @@ :! ruby %<CR>
endfunction

function FileType_Rails()
    "map @@ :! test -d app && (echo "execute rails runner" && rails runner %) \|\| (echo "execute ruby" && ruby -v && time ruby %)<CR>
    map @@ :! test -d app && (echo "execute rails runner" && rails runner %)<CR>
endfunction

function PerlType()
    map @@ :! perl -MData::Dumper %<CR>
    set filetype=perl
    "emenu SnippetMagic.perl
    if getline(1) =~ "^#!"
        ":silent !chmod 700 %
        ":silent !~/.vim/perlnow.pl %
    endif
endfunction

" przewijanie w trybie insert
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

:map <F2> V$%zfzaza

set showtabline=2 

"set t_ku=OA
"set t_kd=OB
"set t_kr=OD
"set t_kl=OC

"set syntax=plain

":emenu SnippetMagic.ruby

"sp nowy_plik, przemieszczanie sie pomiedzy splitami, Ctrl+hjkl
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l

" prev/next tab
nmap <C-N> :tabprevious<CR>
nmap <C-M> :tabnext<CR>


" tab navigation like firefox 
nmap <C-S-tab> :tabprevious<CR>
"nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
"map <C-tab> :tabnext<CR>
imap <C-S-tab> <ESC>:tabprevious<CR>i
imap <C-tab> <ESC>:tabnext<CR>i
nmap <C-t> :tabnew<CR>:open .<CR>
imap <C-t> <ESC>:tabnew<CR> 
map <ESC><C-w> :tabclose<CR>

set tabline=%!MyTabLine()

" hi tabline        term=reverse ctermbg=white ctermfg=blue guibg=0
"hi TabLineSel   ctermbg=White   ctermfg=Black guibg=0 guifg=0
hi TabLineFill  ctermbg=Blue    ctermfg=Blue guibg=DarkGreen guifg=Green
hi TabLine      ctermbg=Blue    ctermfg=White guibg=DarkGreen guifg=Green

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))

        " select the highlighting
        if i + 1 == tabpagenr()
            "let s .= '%#TabLineSel#'
            let s .= '%#TabLineSel#'
        else
            "let s .= '%#TabLine#'
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        "let s .= '%' . (i + 1) . 'T'
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    "let s .= '%#TabLineFill#%T%m'
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        "let s .= '%=%#TabLine#%999Xclose'
        let s .= '%=%#TabLine#%999X'
    endif

    return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])
    " ([^\/]+)$
    "let name = substitute(name, '\(\w\+\)$', '', '')
    "let name = substitute(name, '.\{-0,\}\/\([^\/]\+\)$', '#&#', '')
    let name = substitute(name, '.*\/', '', '')
    "echo name
    if len(name) == 0
        let name = "[Empty tab]"
    endif

    let label = ""
    if getbufvar(buflist[0], "&modified")
        let label .= '+'
    endif

    let label .= name

    return label
endfunction

function! s:findit(pat,repl)
  let res = s:matchcursor(a:pat)
  if res != ""
    return s:sub(res,a:pat,a:repl)
  else
    return ""
  endif
endfunction

:nmap <buffer> fg call Gpu()

:se hlsearch

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
set wildmenu
"set foldminlines=1
"set foldcolumn=3
"set foldmethod=indent
set showmatch
set showcmd " ???

set backup
set backupdir=~/.vim_backups
fun! NewInitBex()
    let &bex = '-' . strftime("%Y%m%d-%H%M")
endfun
autocmd BufWritePre * call NewInitBex() 

set modeline
set modelines=100

"set nu
au BufRead,BufNewFile COMMIT_EDITMSG setf git

set termencoding=utf8
set fileencodings=utf8

runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
    call pathogen#runtime_prepend_subdirectories(expand('~/.vimbundles'))
end

" PLUGIN fuzzyfinder 
map <leader>f :FufFile **/<CR>
map <leader>b :FufBuffer <CR>

let g:fuf_enumeratingLimit = 20
let g:fuf_file_exclude = '\v\.DS_Store|^\.git/$|\.swp|\.svn'

"colorscheme vividchalk 

cabbr js !js /Users/oki/.local/bin/js/runjslint.js "`cat %`" \| /Users/oki/.local/bin/js/format_lint_output.py





