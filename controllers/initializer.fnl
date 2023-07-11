(local os (require :os))
(local util (require :util))

;; Initialize a new fennel project as a git repository
;; -- Options:
;; --   '--makefile': generate a Makefile template 
(lambda init [path ?opts]
  (if (not path)
    (print "Please provide a path.")
    (do
      (print "Initializing...")
      (print (.. "Creating a fun project at: " path))
      (util.mkdir path)
      (local srcpath (.. path "/src/"))
      (local buildpath (.. path "/build/"))
      (util.mkdir srcpath)
      (util.mkdir buildpath)
      (os.execute (.. "echo '(print :hello-world)' >> " srcpath "main.fnl"))
      (when (and ?opts (. ?opts "--makefile"))
        (os.execute (.. "touch " path "/Makefile")))
      (os.execute (.. "cd " path " && git init > /dev/null 2>&1")))))

init
