(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/php/init)

;; Dependencies ----------------------------------
(depends-on 'web-mode)

;; Extension -------------------------------------
(extension php
	   :version "2.31"
	   :on-initialize extensions/php-initialize)

(provide 'extensions/php)
