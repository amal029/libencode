(module libencode
  (export lib:decode lib:encode)
  (import chicken scheme extras srfi-1)
  (include "util")
  (include "decoder")
  (include "encoder"))
