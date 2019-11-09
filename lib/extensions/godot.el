;;; GodotExtension --- Godot Game engine development in FG42.
;;; Commentary:
;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/godot/init)

;; Dependencies ----------------------------------
;; (depends-on 'gdscript-mode)


(defun godot-doc ()
  "TBD"
  "TBD")

;; Extension -------------------------------------
(extension godot
     :version "2.32"
     :on-initialize extensions/godot-initialize
     :docs "lib/extensions/godot/readme.org")

(provide 'extensions/godot)
;;; irc.el ends here
