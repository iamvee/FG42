;; Uncomment this for debugging purposes
;;(setq debug-on-error t)
;; THEME
;; =====
;; Load the default theme
;; Other options are:
;; (theme themes/color-theme-spacemacs-light)
;; (theme themes/color-theme-spacemacs-dark)
(theme themes/color-theme-doom-one)
;; (theme themes/color-theme-doom-molokai)

;; ABILITIES
;; =========
;; Disable abilities which you don't want.
(disable 'rbenv 'helm 'spell 'linum 'smart-mode-line 'desktop-mode 'dired+ 'guru 'emoji 'elpy 'github)


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
                     'php
                     'python
                     'arduino)


;; What are you ?
(i-am-god)

;; i-am-god   => Emacs user.
;; i-am-human => A user of other boring editors.
;; i-am-evil  => An evil user. A vim user.


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

;; If you're using tools like rbenv or nodenv or other similar tools
;; to manage versions of your favorite language, then you need to
;; add their shims to your path. Follow the example below:
;;
;; (setenv "PATH" (concat "/home/USER/.rbenv/shims:"
;;                        "/home/USER/.nodenv/shims:"
;;                        "/home/USER/bin:" (getenv "PATH")))
;;
;; Ofcourse you need to change the USER to your username

;; If you have a separate bin directory as well you can add it
;; to the exec-path as follows:
;;
;; (add-to-list 'exec-path "/home/USER/bin")
;;
;; abilities like clojure which uses the lien tools need to find
;; specific tools (lein in this case) in your exec-path.
