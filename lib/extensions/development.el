(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/development/init)

;; Dependencies ----------------------------------
(depends-on 'flycheck)
(depends-on 'company)
(depends-on 'projectile)
(depends-on 'flyspell)
(depends-on 'diff-hl)
(depends-on 'magit)
(depends-on 'indent-guide)
(depends-on 'yasnippet)

;; Extension -------------------------------------
(extension development
	   :version "2.67"
	   :on-initialize extension/development-initialize)

(provide 'extensions/development)