(require 'fg42/extension)

(defun extension/editor-initialize ()
  "Base plugin initialization."
  (message "inside init"))

(extension editor
	   :version "2.67"
	   :on-initialize extension/editor-initialize)

(provide 'extensions/editor)

