(require 'extensions/clojure/core)

;;;###autoload
(defun extensions/clojure-initialize ()
  ; Clojure development initialization
  (ability clojure-editor ('flycheck)
           (add-hook 'clojure-mode-hook 'clojure-mode-init)

           (setq tmp-directory "~/.tmp"))

  (ability clojure-completion ('code-completion)
           ;; company mode for completion
           (add-hook 'cider-repl-mode-hook #'company-mode)
           (add-hook 'cider-mode-hook #'company-mode))

  (ability clojure-refactore ()

           (add-hook 'clojure-mode-hook 'cljr-init))

  (ability clojure-check ('flycheck)
           (require 'flycheck-clojure)
           (eval-after-load 'flycheck '(add-to-list 'flycheck-checkers 'clojure-cider-eastwood))
           (eval-after-load 'flycheck '(flycheck-clojure-setup))
           (add-hook 'after-init-hook #'global-flycheck-mode)
           ;; Set up linting of clojure code with eastwood

           ;; Make sure to add [acyclic/squiggly-clojure "0.1.2-SNAPSHOT"]
           ;; to your :user :dependencies in .lein/profiles.clj

           (add-hook 'cider-mode-hook
                     '(lambda ()
                        (message "Make sure to add [acyclic/squiggly-clojure \"0.1.2-SNAPSHOT\"] to your :user :dependencies in .lein/profiles.clj")))))

(provide 'extensions/clojure/init)
