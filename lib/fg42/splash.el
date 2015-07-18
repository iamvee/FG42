;; Vars ------------------------------
(defvar fg42-logo-image (concat (getenv "FG42_HOME") "/assets/images/logo.png")
  "Default fg42 logo")

;; Functions -------------------------
(defun fg42-about-screen ()
  "Display fancy About screen."
  (interactive)
  (let ((frame (fancy-splash-frame)))
    (save-selected-window
      (select-frame frame)
      (switch-to-buffer "*FG42 About*")
      (setq buffer-undo-list t)
      (let ((inhibit-read-only t))
	(erase-buffer)
	(if pure-space-overflow
	    (insert pure-space-overflow-message))
	(fg42-splash-head)
	(dolist (text fancy-about-text)
	  (apply #'fancy-splash-insert text)
	  (insert "\n"))
	(set-buffer-modified-p nil)
	(goto-char (point-min))
	(force-mode-line-update))
      (use-local-map splash-screen-keymap)
      (setq-local browse-url-browser-function 'eww-browse-url)
      (setq tab-width 22)
      (setq buffer-read-only t)
      (goto-char (point-min))
      (forward-line 3))))


(defun fg42-splash-head ()
  "Insert the head part of the splash screen into the current buffer."
  (let* ((img (create-image fg42-logo-image))
	 (image-width (and img (car (image-size img))))
	 (window-width (window-width)))
    (when img
      (when (> window-width image-width)
	;; Center the image in the window.
	(insert (propertize " " 'display
			    `(space :align-to (+ center (-0.5 . ,img)))))

	;; Change the color of the XPM version of the splash image
	;; so that it is visible with a dark frame background.
	(when (and (memq 'xpm img)
		   (eq (frame-parameter nil 'background-mode) 'dark))
	  (setq img (append img '(:color-symbols (("#000000" . "gray30"))))))

	;; Insert the image with a help-echo and a link.
	(make-button (prog1 (point) (insert-image img)) (point)
		     'face 'default
		     'help-echo "mouse-2, RET: Browse http://www.gnu.org/"
		     'action (lambda (_button) (browse-url "http://www.gnu.org/"))
		     'follow-link t)
	(insert "\n\n")))))

(provide 'fg42/splash)
