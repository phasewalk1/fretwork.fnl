(local os (require :os))

(lambda mkdir [path]
  (os.execute (.. "mkdir " path)))

;; Initialize a new fennel project
(fn init [path ?opts]
  (if (not path)
    (print "Please provide a path.")
    (do
      (print "Initializing...")
      (print (.. "Creating a fun project at: " path))
      (mkdir path)
      (local srcpath (.. path "/src/"))
      (local buildpath (.. path "/build/"))
      (mkdir srcpath)
      (mkdir buildpath)
      (os.execute (.. "echo '(print :hello-world)' >> " srcpath "main.fnl"))
      (os.execute (.. "touch " path "/Makefile"))
      (os.execute (.. "cd " path " && git init > /dev/null 2>&1")))))

(local command-table {:init init})

(lambda subseq [t start]
  (local result [])
  (for [i start (length t)]
    (table.insert result (. t i)))
  result)

(lambda process-command [command args]
  (let [handler (. command-table command)]
    (if handler
      (handler (. args 1) (subseq args 2))
      (print "Unknown command."))))


(lambda take-args []
  (local argv [])
  (if (> (length arg) 0)
    (do
      (each [i v (ipairs arg)]
        (table.insert argv v))))
  argv)

(local argv (take-args))
(local cmd (. argv 1))
(table.remove argv 1)
(process-command cmd argv)

