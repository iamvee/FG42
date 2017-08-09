;;; lxdrive-mode --- A minor mode for fast cursor movement
;;; Commentary:
;;; Code:

(setq original-global-map global-map)

(defun turn-off-lxdrive ()
  "Toggle lxdrive mode"
  (interactive)
  (message "Turning lxdrive OFF")
  (lxdrive-minor-mode nil)
  (use-global-map original-global-map))

(defun turn-on-lxdrive ()
  "Toggle lxdrive mode"
  (interactive)
  (message "Turning lxdrive ON")
  (lxdrive-minor-mode t)
  (use-global-map lxdrive-mode-map))

(defun turn-off-and-ido-find-file ()
  (interactive)
  (turn-off-lxdrive)
  (ido-find-file))

(defun turn-off-and-smex ()
  (interactive)
  (turn-off-lxdrive)
  (smex))

(defun turn-off-and-swiper ()
  (interactive)
  (turn-off-lxdrive)
  (swiper))

(defvar lxdrive-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Movement
    (define-key map (kbd "l") 'forward-char)
    (define-key map (kbd "j") 'backward-char)
    (define-key map (kbd "i") 'previous-line)
    (define-key map (kbd "k") 'next-line)
    (define-key map (kbd "u") 'backward-word)
    (define-key map (kbd "o") 'forward-word)
    (define-key map (kbd "n") 'backward-paragraph)
    (define-key map (kbd "m") 'forward-paragraph)
    (define-key map (kbd "TAB") 'indent-for-tab-command)
    (define-key map (kbd "SPC") 'cua-set-mark)
    (define-key map (kbd "e")   'move-end-of-line)
    (define-key map (kbd "a")   'move-beginning-of-line)
    (define-key map (kbd "RET")   'newline)

    ;; Actions
    (define-key map (kbd "d") 'delete-char)
    (define-key map (kbd "<backspace>") 'delete-backward-char)
    (define-key map (kbd "y")   'cua-paste)
    (define-key map (kbd "C-w")   'kill-region)
    (define-key map (kbd "M-w")   'kill-ring-save)

    (define-key map (kbd "C-k") 'kill-and-join-forward)
    (define-key map (kbd "f f") 'turn-off-and-ido-find-file)
    (define-key map (kbd "s")   'turn-off-and-swiper)
    (define-key map (kbd "z")   'undo)

    (define-key map (kbd "M-x")   'turn-off-and-smex)
    (define-key map (kbd "C-x C-s") 'save-buffer)
    (define-key map (kbd "ESC ESC") 'turn-off-lxdrive)
    (define-key map (kbd "q")     'turn-off-lxdrive)
    map)
  "Keymap for lxdrive-minor-mode.")

(define-minor-mode lxdrive-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " lx")


;; (defun my-minibuffer-setup-hook ()
;;   (lxdrive-minor-mode 0))

;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


;;(lxdrive-minor-mode 1)
(global-set-key (kbd "ESC ESC") 'turn-on-lxdrive)
(provide 'extensions/editor/lxdrive-mode)
;;; lxdrive-mode  ends here
