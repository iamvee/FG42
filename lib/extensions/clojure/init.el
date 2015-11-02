;;;###autoload
(defun extensions/clojure-initialize ()
  ; Clojure development initialization
  (ability clojure-editor ('flycheck)
           (setq tmp-directory "~/.tmp")
           (setq cider-repl-history-file tmp-directory)

           ;; nice pretty printing
           (setq cider-repl-use-pretty-printing t)

           ;; nicer font lock in REPL
           (setq cider-repl-use-clojure-font-lock t)

           ;; result prefix for the REPL
           (setq cider-repl-result-prefix ";; => ")

           ;; never ending REPL history
           (setq cider-repl-wrap-history t)

           ;; looong history
           (setq cider-repl-history-size 3000)

           ;; eldoc for clojure
           (add-hook 'cider-mode-hook #'eldoc-mode)

           ;; error buffer not popping up
           (setq cider-show-error-buffer nil)
           (require 'hl-sexp)

           ;; Paredit
           (require 'paredit)
           (add-hook 'clojure-mode-hook #'paredit-mode)
           (add-hook 'cider-repl-mode-hook #'paredit-mode)
           ;(define-key clojure-mode-map (kbd "M-<right>") 'paredit-forward-slurp-sexp)
           ;(define-key clojure-mode-map (kbd "M-<left>") 'paredit-backward-slurp-sexp)
           ;(define-key clojure-mode-map (kbd "C-<right>") 'right-word)
           ;(define-key clojure-mode-map (kbd "C-<left>") 'left-word)

           (add-hook 'clojure-mode-hook #'hl-sexp-mode))

  (ability clojure-completion ('code-completion)
           ;; company mode for completion
           (add-hook 'cider-repl-mode-hook #'company-mode)
           (add-hook 'cider-mode-hook #'company-mode))

  (ability clojure-refactore ()

           (add-hook 'clojure-mode-hook
                     (lambda ()
                       (clj-refactor-mode 1)
                       ;; insert keybinding setup here
                       (cljr-add-keybindings-with-prefix "C-c RET")))

           (add-hook 'clojure-mode-hook #'yas-minor-mode)

           ;; no auto sort
           (setq cljr-auto-sort-ns nil)

           ;; do not prefer prefixes when using clean-ns
           (setq cljr-favor-prefix-notation nil))

  (ability clojure-check ('flycheck)
           (eval-after-load 'flycheck '(flycheck-clojure-setup))
           (add-hook 'after-init-hook #'global-flycheck-mode)))

(provide 'extensions/clojure/init)
