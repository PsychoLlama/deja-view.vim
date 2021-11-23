augroup deja_view
  autocmd!
  autocmd BufReadPost * call deja#restore_view()
  autocmd BufLeave * call deja#save_view()
  autocmd VimLeavePre * call deja#save_view()
augroup END
