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
           (global-company-mode t)
           (define-key company-active-map "\t" 'company-yasnippet-or-completion))

  (ability yas ()
           (yas-global-mode 1))

  (ability project-management ()
           (projectile-global-mode)
           (setq projectile-enable-caching t))



)
(provide 'extensions/development/init)
