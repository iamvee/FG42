(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/development/init)

;; Dependencies ----------------------------------
(depends-on 'flycheck)
(depends-on 'company)
(depends-on 'company-statistics)
(depends-on 'projectile)
(depends-on 'diff-hl)
(depends-on 'magit)
(depends-on 'indent-guide)
(depends-on 'yasnippet)
(depends-on 'direx)
(depends-on 'popwin)
(depends-on 'ag)
(depends-on 'hl-sexp)
(depends-on 'smart-mode-line)

(with-ability spell
              (depends-on 'flyspell))
;; TODO: Add flycheck-color-modebar
;; TODO  Add flycheck-tip

;; Extension -------------------------------------
(extension development
	   :version "2.31"
	   :on-initialize extension/development-initialize)

(provide 'extensions/development)
