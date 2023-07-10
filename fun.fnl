(local os (require :os))
(local bs (require :bootstrapper.bootstrap))
(local util (require :util))

(bs.lib)

(fn compile-file [file ?opts]
  (let [outpath (or (and ?opts (. ?opts "--outpath") (next ?opts)) (string.gsub file ".fnl" ".lua"))]
    (os.execute (.. "fennel --compile " file " > " outpath))
    (print (.. "Compiler outputted: " outpath))))

;; Initialize a new fennel project
(fn init [path ?opts]
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

(local command-table {:init init :compile compile-file})

(fn subseq [t start]
  (local result [])
  (for [i start (length t)]
    (table.insert result (. t i)))
  result)

(fn process-command [command args]
  (let [handler (. command-table command)]
    (if handler
      (let [options {}]
        (each [_ opt (ipairs (subseq args 2))]
          (tset options opt true))
        (handler (. args 1) options))
      (print "Unknown command."))))

(fn take-args []
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

