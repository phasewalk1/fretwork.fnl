(local module {})

(local os (require :os))

;; Wrapper around fennel --compile
(lambda compile-file [file ?opts]
  (let [outpath (or (and ?opts (. ?opts "--outpath") (next ?opts)) (string.gsub file ".fnl" ".lua"))]
    (os.execute (.. "fennel --compile " file " > " outpath))
    (print (.. "Compiler outputted: " outpath))))

(tset module :compile-file compile-file)
module
