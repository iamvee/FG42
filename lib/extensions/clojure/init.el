(require 'extensions/clojure/core)

;;;###autoload
(defun set-clojure-favorite-buffer ()
  "Set the favorite buffer to cider repl"
  (setq *favorite-buffer*  "\*cider-repl\s.*\*"))

;;;###autoload
(defun extensions/clojure-initialize ()
  ; Clojure development initialization
  (ability clojure-editor ('flycheck)
           (require 'clojure-mode)

           (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
           (add-to-list 'auto-mode-alist '("\\.cljc$" . clojurec-mode))
           (add-to-list 'auto-mode-alist '("\\.cljs$" . clojurescript-mode))

           (add-hook 'cider-mode-hook #'eldoc-mode)
           (add-hook 'cider-mode-hook #'set-clojure-favorite-buffer)
           (add-hook 'clojure-mode-hook #'paredit-mode)
           (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

           (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

           (add-hook 'clojure-mode-hook 'clojure-mode-init)
           (setq tmp-directory (concat (getenv "HOME") "/.tmp")))

  (with-ability parinfer ()
                (add-hook 'clojure-mode-hook #'parinfer-mode))


  (ability clojure-completion ('code-completion)
           ;; company mode for completion
           (add-hook 'cider-repl-mode-hook #'company-mode)
           (add-hook 'cider-mode-hook #'company-mode))

  (ability clojure-refactore ()
           (add-hook 'clojure-mode-hook 'cljr-init)))

  ;; (ability clojure-check ('flycheck)
  ;;          (require 'flycheck-clojure)
  ;;          (eval-after-load 'flycheck '(add-to-list 'flycheck-checkers 'clojure-cider-eastwood))
  ;;          (eval-after-load 'flycheck '(flycheck-clojure-setup))
  ;;          (add-hook 'after-init-hook #'global-flycheck-mode)
  ;;          ;; Set up linting of clojure code with eastwood

  ;;          ;; Make sure to add [acyclic/squiggly-clojure "0.1.2-SNAPSHOT"]
  ;;          ;; to your :user :dependencies in .lein/profiles.clj

  ;;          (add-hook 'cider-mode-hook
  ;;                    '(lambda ()
  ;;                       (message "Make sure to add [acyclic/squiggly-clojure \"0.1.2-SNAPSHOT\"] to your :user :dependencies in .lein/profiles.clj")))))

(provide 'extensions/clojure/init)
