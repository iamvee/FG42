(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/web/init)

;; Dependencies ----------------------------------
(depends-on 'emmet-mode)
(depends-on 'company-web)
(depends-on 'web-mode)
(depends-on 'sass-mode)
(depends-on 'scss-mode)
(depends-on 'less-css-mode)
(depends-on 'coffee-mode)
(depends-on 'handlebars-mode)
(depends-on 'js2-mode)
(depends-on 'js2-refactor)
(depends-on 'rainbow-mode)
;(depends-on 'slim-mode)
;(depends-on 'haml-mode)
(depends-on 'mustache-mode)

;; Extension -------------------------------------
(extension web
	   :version "2.67"
	   :on-initialize extensions/web-initialize)

(provide 'extensions/web)
