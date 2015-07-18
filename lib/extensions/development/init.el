;; Functions -------------------------------------------------

;; Quick fix for company-mode and yasnippet clashing
(defun company-yasnippet-or-completion ()
  (interactive)
  (if (yas/expansion-at-point)
      (progn (company-abort)
             (yas/expand))
    (company-complete-common)))

(defun yas/expansion-at-point ()
  "Tested with v0.6.1. Extracted from `yas/expand-1'"
  (first (yas/current-key)))

;;;###autoload
(defun extension/development-initialize ()
  "Development plugin initialization."
  (message "Initializing 'development' extension.")

  (ability code-completion ()
           "Use company mode to provides a complete auto completion framwork."
           (require 'company)
           (global-company-mode t)

           ;; Bigger popup window
           (setq company-tooltip-limit 20)

           ;; Align annotations to the right tooltip border
           (setq company-tooltip-align-annotations 't)

           ;; Decrease delay before autocompletion popup shows
           (setq company-idle-delay 0.1)
           (setq company-minimum-prefix-length 2)

           ;; Start autocompletion only after typing
           (setq company-begin-commands '(self-insert-command))

           ;; Force complete file names on "C-c /" key
           (global-set-key (kbd "C-c /") 'company-files)

           (add-hook 'after-init-hook 'company-statistics-mode)
           (define-key company-active-map "\t" 'company-yasnippet-or-completion))

  (ability yas ()
           "Snippet configuration."

           (let ((snippet_home (concat (file-name-directory
                                (locate-library "yasnippet")) "snippets"))
                 (my_snippet (concat fg42-home "/lib/snippets")))
             (setq yas-snippet-dirs (list my_snippet snippet_home)))

           (yas-global-mode 1))

  (ability project-management ()
           "Ability to manage projects and project navigation."
           (projectile-global-mode)
           (setq projectile-enable-caching t))

  (ability flycheck ()
           "Check syntax on the fly using flycheck."
           (add-hook 'prog-mode-hook 'global-flycheck-mode)
           (add-hook 'after-init-hook 'global-flycheck-mode))

  (ability spell ()
           "Check spell of any word using ispell."
           (require 'flyspell)
           (setq flyspell-issue-message-flg nil))

  (ability diff-highlight ()
           "Highlight the diffs based on VCS."
           (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
           (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))

  (ability auto-pair ()
           "Auto pair stuffs like brackets begin/ends etc."
           ;; TODO: use autopair mode if electric pair was not as good as autopair
           (electric-pair-mode))

  (ability code-browser ()
           "Adds the code browser to FG42."
           (autoload 'direx "direx" "Simple code browser.")
           (require 'popwin)
           (popwin-mode t)

           (push '(direx:direx-mode :position left :width 30 :dedicated t)
                 popwin:special-display-config)
           (global-set-key (kbd "C-c q") 'direx-project:jump-to-project-root-other-window))

  (ability fast-search ()
           "Provides fast search ability via silver search"
           (setq ag-reuse-window 't)
           (setq ag-highlight-search t))

  (ability smart-mode-line ()
           "Smarter modeline for FG42"
           (setq sml/no-confirm-load-theme t)
           (setq sml/theme 'respectful)
           (sml/setup))

  (ability indent-guide
           "Show indent guides."
           (indent-guide-global-mode)
           (set-face-foreground 'indent-guide-face "#bbb")))

(provide 'extensions/development/init)
