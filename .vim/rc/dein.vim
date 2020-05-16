function ClearDeinCache()
  execute ':call dein#clear_state()'
  execute ':call dein#recache_runtimepath()'
endfunction
