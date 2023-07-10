(lambda mkdir [path]
  (os.execute (.. "mkdir " path)))

(fn in-list [lst val]
  (var found? false)
  (for [i 1 (length lst)]
    (if (= (. lst i) val)
      (set found true)))
  found?)

{:in-list in-list :mkdir mkdir}
