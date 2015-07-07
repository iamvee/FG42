(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/editor/init)

;; Dependencies ----------------------------------
(depends-on 'color-theme)
(depends-on 'ido)
(depends-on 'ido-vertical-mode)
(depends-on 'multiple-cursors)
(depends-on 'expand-region)
(depends-on 'flx-ido)
(depends-on 'dired+)

;; Extension -------------------------------------
(extension editor
	   :version "2.67"
	   :on-initialize extension/editor-initialize)

(provide 'extensions/editor)

