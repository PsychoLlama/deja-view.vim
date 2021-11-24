func! deja#save_view() abort
  call deja#write_view(expand('%:p'))
endfunc

func! deja#restore_view() abort
  let l:view = deja#read_view(expand('%:p'))

  " If the remembered line number is out of bounds, it's probably wrong.
  if l:view is# v:null || l:view.lnum > line('$')
    return
  endif

  " Vim automatically remembers your last cursor position (but not your view,
  " which is why the plugin exists). The line/column memory is more accurate
  " than we can achieve through autocommands. Use it as a sanity check.
  let l:last_line = line("'\"")
  let l:last_col = col("'\"")

  " Running `:edit` on the same buffer reloads it, but since there's no event
  " for deja-view to detect and save the view, we lose information and
  " incorrectly load the old one instead.
  "
  " Since the cursor position doesn't change by :edit, we can simply ignore
  " the event.
  if l:last_line > 1 && l:last_col > 1
    if l:last_line != l:view.lnum && l:last_col != l:view.col
      return
    endif
  endif

  call winrestview(l:view)
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
