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
                     'javascript
                     'ruby
                     'clojure
                     ;;'php
                     ;;'python
                     ;;'arduino
		     )


;; Example of things you can do in your ~/.fg42.el config file:
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
