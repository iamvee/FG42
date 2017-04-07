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
(theme themes/color-theme-spacemacs-dark)

;; ABILITIES
;; =========
;; Disable abilities which you don't want.
(disable 'rbenv 'helm 'spell 'linum)

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

;; Example of things you can do in your ~/.fg42 config file:
;;
;; Setting your TODO file path:
;;   (setq fg42-todo-file "~/.TODO.org")
;; or you can open a remote TODO file
;;   (add-hook 'fg42-before-open-todo-hook 'disable-projectile)
;;   (setq fg42-todo-file "/ssh:user@host:/home/USER/.TODO.org")
;;
;; Set some environment variables for your fg42 to use
;;  (setenv "http_proxy" "localhost:8118")
;;  (setenv "https_proxy" "localhost:8118")
;;
;; Alwasy open a your TODO file as your first buffer
;;  (add-hook 'fg42-after-initialize-hook 'fg42-open-todo)
;;

(fg42-initialize)
