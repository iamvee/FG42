(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))

;; DEBUG
;; =====
;; Uncomment the below code to trigger stacktraces in case of any errors
;; (toggle-debug-on-error)

(require 'fg42)

;; THEME
;; =====
;; Load the default theme
;; Other options are:
;; (theme themes/color-theme-spacemacs-monokai)
;; (theme themes/color-theme-spacemacs-light)
;; (theme themes/color-theme-doom-one)
;; (theme themes/color-theme-doom-molokai)
(theme themes/color-theme-spacemacs-dark)

;; ABILITIES
;; =========
;; Disable abilities which you don't want.
(disable 'rbenv 'helm 'spell 'linum 'smart-mode-line)

;; EXTENSIONS
;; ==========
;; Uncomment extensions that you may need.
(activate-extensions 'editor
                     'development
                     'web
                     'editor-theme
                     ;'arduino
                     'javascript
                     ;'php
                     'clojure
                     ;'python
                     'ruby
		     )

;; USER CONFIGS
;; ============
;; Load user config file in ~/.fg42.el
(load-user-config "~/.fg42.el")
;; NOTE: It's important to use ~/.fg42.el instead of this file
;;       because updating fg42 will discard your changes in
;;       this file.
(fg42-initialize)
