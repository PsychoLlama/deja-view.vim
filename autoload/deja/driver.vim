let s:warned = v:false

func! deja#driver#load(buffer_path) abort
  let l:driver_name = s:get_driver_name(a:buffer_path)

  if l:driver_name is# 'disk'
    return deja#disk#get_driver()
  endif

  if l:driver_name is# 'none'
    return deja#null#get_driver()
  endif

  if l:driver_name isnot# 'memory'
    call s:warn_of_unknown_driver(l:driver_name)
  endif

  return deja#memory#get_driver()
endfunc

" TODO: Add pattern override based on buffer path.
" TODO: Make file type override configurable.
func! s:get_driver_name(buffer_path) abort
  if &filetype is# 'gitcommit' || a:buffer_path[0:4] is# 'term:'
    return 'none'
  endif

  let l:n = 'deja_save_mode'
  return get(b:, l:n, get(g:, l:n, 'disk'))
endfunc

func! s:warn_of_unknown_driver(driver_name) abort
  if s:warned
    return
  endif

  echohl Error
  echon 'Error (deja_view):'
  echohl Clear
  echon ' Unknown driver type "' . a:driver_name . '"'

  let s:warned = v:true
endfunc
