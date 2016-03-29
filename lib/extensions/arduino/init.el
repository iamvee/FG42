;;; Code:

;; Functions -------------------------------------------------

;;;###autoload
(defun create-makefile ()
  "Create the arduino make file in the same directory as the ino file if doesn't exits."
  (let ((makefile (concat (file-name-directory buffer-file-name) "Makefile"))
        (makefile-src (concat fg42-home "/lib/extensions/arduino/Makefile")))
    (if (not (file-exists-p makefile))
        (progn (message "Creating arduino make file")
               (copy-file makefile-src makefile)))))

;;;###autoload
(defun compile-arduino ()
  "Compile the current arduino project."
  (interactive)
  (recompile))

;;;###autoload
(defun compile-arduino ()
  "Compile the current arduino project."
  (interactive)
  (recompile))

;;;###autoload
(defun compile-and-upload-arduino ()
  "Compile and upload the current arduino project."
  (compile-arduino)
  (let (compile-command "make upload")
    (recompile)))

;;;###autoload
(defun extensions/arduino-initialize ()
  "Arduino development plugin initialization."
  (message "Initializing 'arduino' extension.")

  (ability arduino-editor ('flycheck)
           "Gives FG42 the ability to edit arduino related contents."
           (add-hook 'arduino-mode-hook 'create-makefile)
           (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))

           (global-set-key (kbd "C-c c") 'compile-arduino)
           (global-set-key (kbd "C-c u") 'compile-and-upload-arduino)
           (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)))


(provide 'extensions/arduino/init)
