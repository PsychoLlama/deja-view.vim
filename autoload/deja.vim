func! deja#save_view() abort
  call deja#write_view(expand('%:p'))
endfunc

func! deja#restore_view() abort
  let l:view = deja#read_view(expand('%:p'))

  " If the remembered line number is out of bounds, it's probably wrong.
  if l:view isnot# v:null && l:view.lnum <= line('$')
    call winrestview(l:view)
  endif
endfunc

func! deja#write_view(file_path) abort
  if empty(a:file_path)
    return
  endif

  let l:driver = deja#driver#load(a:file_path)
  call l:driver.write(a:file_path, winsaveview())
endfunc

func! deja#read_view(file_path) abort
  let l:driver = deja#driver#load(a:file_path)
  return l:driver.read(a:file_path)
endfunc
