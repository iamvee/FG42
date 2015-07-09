(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/development/init)

;; Dependencies ----------------------------------
(depends-on 'flycheck)
(depends-on 'company)
(depends-on 'company-statistics)
(depends-on 'projectile)
(depends-on 'flyspell)
(depends-on 'diff-hl)
(depends-on 'magit)
(depends-on 'indent-guide)
(depends-on 'yasnippet)
;; TODO: Add flycheck-color-modebar
;; TODO  Add flycheck-tip

;; Extension -------------------------------------
(extension development
	   :version "2.31"
	   :on-initialize extension/development-initialize)

(provide 'extensions/development)
