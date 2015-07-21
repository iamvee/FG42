;; Functions -------------------------------------------------
;;;###autoload
(defun javascript-callback ()
  (require 'jquery-doc)

  (js2-minor-mode t)
  ;; FIXME: don't hard code the indent size
  (setq js2-basic-offset 2)

  (setq js2-bounce-indent-p t)
  (tern-mode t)
  (jquery-doc-setup))

;;;###autoload
(defun extensions/javascript-initialize ()
  "Javascript development plugin initialization."
  (message "Initializing 'javascript' extension.")

  (ability javascript-editor ('flycheck)
           "Gives FG42 the ability to edit javascript."

           (autoload 'js2-mode "js2-mode" "Javascript mode")
           (autoload 'tern-mode "tern.el" nil t)


           (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
           ;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
           (add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

           (add-hook 'js2-mode-hook 'javascript-callback)

           (add-to-list 'company-backends 'company-tern)
           (setq js2-highlight-level 3))

  (ability coffee-editor ()
           "Gives FG42 ability to edit coffee script files."
           (custom-set-variables '(coffee-tab-width 2))))

(provide 'extensions/javascript/init)
