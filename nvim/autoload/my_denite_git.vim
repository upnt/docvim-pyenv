function! my_denite_git#openings() abort
    nnoremap <silent> <Leader>gb
    \ :Denite gitbranch<CR>
    nnoremap <silent> <Leader>gc
    \ :Denite gitchanged<CR>
    nnoremap <silent> <Leader>gf
    \ :Denite gitfiles<CR>
    nnoremap <silent> <Leader>gl
    \ :Denite gitlog<CR>
    nnoremap <silent> <Leader>gs
    \ :Denite gitstatus<CR>
endfunction
