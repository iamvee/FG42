(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/javascript/init)

;; Dependencies ----------------------------------
(depends-on 'coffee-mode)
(depends-on 'js2-mode)
(depends-on 'rjsx-mode)
(depends-on 'js2-refactor)
(depends-on 'smart-forward)
(depends-on 'ac-js2)

;;(depends-on 'tern)
(with-ability indium
              (depends-on 'indium))


(depends-on 'company-web)
(depends-on 'jquery-doc)

;; Extension -------------------------------------
(extension javascript
	   :version "2.31"
	   :on-initialize extensions/javascript-initialize)

(provide 'extensions/javascript)
