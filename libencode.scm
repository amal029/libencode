(module libencode
  (decoder partition-indexed alist? encode)
  (import chicken scheme extras srfi-1)
  (use cock)
  (include "util")
  (include "decoder")
  (include "encoder"))
