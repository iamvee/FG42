(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/development/init)

;; Dependencies ----------------------------------
(depends-on 'flycheck)
(depends-on 'company)
(depends-on 'company-statistics)
(depends-on 'projectile)
(depends-on 'indent-guide)
(depends-on 'yasnippet)
(depends-on 'hl-sexp)
(depends-on 'smart-mode-line)

(with-ability git
              (depends-on 'diff-hl)
              (depends-on 'magit))

(with-ability focus
              (depends-on 'focus))

(with-ability code-browser
              (depends-on 'neotree))

(with-ability pt
              (depends-on 'pt))

(with-ability spell
              (depends-on 'flyspell))

(with-ability file-browser
              (depends-on 'ranger))

(with-ability shell
              (depends-on 'eshell-prompt-extras)
              (depends-on 'shell-pop))

;; TODO: Add flycheck-color-modebar
;; TODO  Add flycheck-tip

;; Extension -------------------------------------
(extension development
	   :version "2.31"
	   :on-initialize extension/development-initialize)

(provide 'extensions/development)
