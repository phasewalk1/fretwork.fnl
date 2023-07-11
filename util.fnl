(fn take-args []
  (local argv [])
  (if (> (length arg) 0)
    (do
      (each [i v (ipairs arg)]
        (table.insert argv v))))
  argv)

(lambda keys [tbl]
  (local keys [])
  (each [k v (pairs tbl)]
    (table.insert keys k))
  keys)

(lambda mkdir [path]
  (os.execute (.. "mkdir " path)))

(lambda subseq [t start]
  (local result [])
  (for [i start (length t)]
    (table.insert result (. t i)))
  result)

(lambda in-list [lst val]
  (var found? false)
  (for [i 1 (length lst)]
    (if (= (. lst i) val)
      (set found true)))
  found?)

{:in-list in-list :mkdir mkdir
 :take-args take-args :subseq subseq
 :keys keys}
