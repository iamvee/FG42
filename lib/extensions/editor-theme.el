(require 'fpkg)
(require 'fg42/extension)

;; Dependencies ----------------------------------
(defun extensions/editor-theme-initialize ()
  "Initialize 'editor-theme' extension."
  (load-default-theme)
  (message "'editor-theme' extension has been initizlied."))

;; Extension -------------------------------------
(extension editor-theme
	   :version "2.31"
	   :on-initialize extensions/editor-theme-initialize)

(provide 'extensions/editor-theme)
