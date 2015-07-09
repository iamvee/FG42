(require 'fpkg)
(require 'fg42/extension)

;; Dependencies ----------------------------------
(depends-on 'color-theme)

(defun extensions/editor-theme-initialize ()
  "Initialize 'editor-theme' extension."
  (message "Initializing 'editor-theme' extension.")
  (load-default-theme))

;; Extension -------------------------------------
(extension editor-theme
	   :version "2.31"
	   :on-initialize extensions/editor-theme-initialize)

(provide 'extensions/editor-theme)
