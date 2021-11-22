func! deja#null#write(buffer_path, view) abort
  " Do nothing.
endfunc

func! deja#null#read(buffer_path) abort
  return v:null
endfunc

func! deja#null#get_driver() abort
  let l:driver = {}
  let l:driver.read = function('deja#null#read')
  let l:driver.write = function('deja#null#write')

  return l:driver
endfunc
