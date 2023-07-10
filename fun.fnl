(local os (require :os))
(local util (require :util))

;; Wrapper around fennel --compile
(lambda compile-file [file ?opts]
  (let [outpath (or (and ?opts (. ?opts "--outpath") (next ?opts)) (string.gsub file ".fnl" ".lua"))]
    (os.execute (.. "fennel --compile " file " > " outpath))
    (print (.. "Compiler outputted: " outpath))))

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

(local command-table {:init init
                      :compile compile-file})

(lambda process-command [command args]
  (let [handler (. command-table command)]
    (if handler
      (let [options {}]
        (each [_ opt (ipairs (util.subseq args 2))]
          (tset options opt true))
        (handler (. args 1) options))
      (print "Unknown command."))))

(lambda do-main []
  (local bs (require :bootstrapper.bootstrap))
  (bs.lib)

  (local opts (util.take-args))
  (local cmd (. opts 1))
  (table.remove opts 1)
  (process-command cmd opts))

(do-main)
