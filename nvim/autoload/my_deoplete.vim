function! my_deoplete#settings() abort
    let g:deoplete#enable_at_startup = 1
    call deoplete#custom#option({
    \ 'auto_complete_delay': 0,
    \ 'smart_case': v:true,
    \ })
endfunction
