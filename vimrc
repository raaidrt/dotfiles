set nocompatible
filetype off
set backspace=indent,eol,start
set mouse=a

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
call vundle#end()            " required

let g:airline_theme='deus'


set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set colorcolumn=80

set background=dark
map <silent> <C-n> :NERDTreeToggle<CR>
noremap <silent> <C-i> :tabnew<cr>
noremap <silent> <C-o> :tabclose<cr>
noremap <C-l> :tabnext<cr>
noremap <C-h> :tabprevious<cr>
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
colorscheme catppuccin_mocha

" Helpful information: cursor position in bottom right, line numbers on
" left
set ruler
set relativenumber

"Enable filetype detection and syntax hilighting
syntax on
filetype on
filetype indent on
filetype plugin on

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set wrap

" Indent as intelligently as vim knows how
set smartindent

" Show multicharacter commands as they are being typed
set showcmd

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  set previewheight=2
  1
endfunction
