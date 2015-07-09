;; Functions -------------------------------------------------

;;;###autoload
(defun insert-arrow ()
  (interactive)
  (delete-horizontal-space t)
  (insert " => "))

;;;###autoload
(defun setup-bundler ()
  "Setup bundler and its keybindings"
  (require 'bundler)
  (define-key ruby-mode-map (kbd "\C-c b i") 'bundle-install)
  (define-key ruby-mode-map (kbd "\C-c b u") 'bundle-update)
  (define-key ruby-mode-map (kbd "\C-c b e") 'bundle-exec)
  (define-key ruby-mode-map (kbd "\C-c b o") 'bundle-open)
  (define-key ruby-mode-map (kbd "\C-c b c") 'bundle-console))

;;;###autoload
(defun setup-inf-ruby ()
  "Setup inf-ruby and Robe"

  ;; Inf Ruby configuration
  (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)

  (global-set-key (kbd "C-c r r") 'inf-ruby)

  ;; TODO: We don't need this if pry setup is present in ~/.irbrc
  (setq irbparams " --inf-ruby-mode -r irb/completion")
  (setq irbpath (rbenv--expand-path "shims" "irb"))
  (setq irb (concat irbpath irbparams))
  (add-to-list 'inf-ruby-implementations (cons "ruby" irb))
  (inf-ruby-minor-mode t))


;;;###autoload
(defun ruby-code-completion ()
  "Configure Robe and inf-ruby for code completion."
  (with-ability ruby-code-completion
                (robe-mode t)
                (push 'company-robe company-backends))

  (with-ability ruby-code-completion
                (eval-after-load 'company
                  '(add-to-list 'company-backends 'company-inf-ruby))))


;;;###autoload
(defun setup-general-ruby-editor ()
  "Setup basic utilities to write Ruby code"
  (local-set-key [f1] 'yari)

  (eval-after-load 'rspec-mode
    '(rspec-install-snippets))

  (ruby-tools-mode t)
  (define-key ruby-mode-map (kbd "C-.") 'insert-arrow)
  (hs-minor-mode t)
  ;; Hack autocomplete so it treat :symbole and symbole the same way
  (modify-syntax-entry ?: "."))

(provide 'extensions/ruby/setup)
