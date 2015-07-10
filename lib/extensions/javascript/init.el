;; Functions -------------------------------------------------

;;;###autoload
(defun extensions/javascript-initialize ()
  "Javascript development plugin initialization."
  (message "Initializing 'javascript' extension.")

  (ability javascript-editor ('flycheck)
           "Gives FG42 the ability to edit javascript."

           (autoload 'js2-mode "js2-mode" "Javascript mode")

           (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
           (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
           (add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

           (add-hook 'js-mode-hook 'js2-minor-mode)

           (add-to-list 'company-backends 'company-tern)
           (setq js2-highlight-level 3)


           (add-hook 'web-mode-hook 'extensions/web-activate-modes)))



(provide 'extensions/web/init)
