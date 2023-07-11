(local os (require :os))

(local util (require :util))
(local controllers (require :controllers.ctrl))
(local bs (require :bootstrapper.bootstrap))

(bs.lib)

(local command-table {:init controllers.init
                      :compile controllers.builder.compile-file})

(local command-keys (util.keys command-table))

(lambda usage []
  (print "Usage:")
  (print "  fun <command> [options]")
  (print "Commands:")
  (each [k _ (pairs command-table)]
    (print ( .. "  " k))))

(fn do-command [command ?args]
  (let [handler (. command-table command)]
    (if handler
      (let [options {}]
        (each [_ opt (ipairs (util.subseq args 2))]
          (tset options opt true))
        (handler (. args 1) options))
      (usage))))

(lambda do-main []
  (local opts (util.take-args))
  (local arg-cmd (. opts 1))
  (table.remove opts 1)
  (do-command arg-cmd opts))

(do-main)
