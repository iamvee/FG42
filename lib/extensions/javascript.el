(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/javascript/init)

;; Dependencies ----------------------------------
(depends-on 'coffee-mode)
(depends-on 'js2-mode)
(depends-on 'js2-refactor)
(depends-on 'tern)
(depends-on 'company-tern)
;; Extension -------------------------------------
(extension javascript
	   :version "2.31"
	   :on-initialize extensions/javascript-initialize)

(provide 'extensions/javascript)
