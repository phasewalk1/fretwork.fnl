(local module {})

(local os (require :os))
(local home :$HOME/.config/fun)
(local libroot :$HOME/.config/fun/)
(local lib (.. libroot "lib/"))

(lambda bootstrap-home []
  (os.execute (.. "mkdir -p " home))
  (os.execute (.. "cp -r lib/ " libroot)))

(bootstrap-home)
(set package.path (.. lib "/?.lua;" package.path))

(lambda bootstrap-lib []
  (set package.path (.. lib "/?.lua;" package.path)))

(tset module :lib bootstrap-lib)
module
