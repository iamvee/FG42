;;; lxdrive-mode --- A minor mode for fast cursor movement
;;; Commentary:
;;; Code:
(require 'expand-region)

(setq original-global-map global-map)
(boundp 'lxdrive-minor-mode)

(defun turn-off-lxdrive ()
  "Toggle lxdrive mode"
  (interactive)
  (lxdrive-minor-mode nil)
  (setq lxdrive-minor-mode nil)
  (use-global-map original-global-map))

(defun turn-on-lxdrive ()
  "Toggle lxdrive mode"
  (interactive)
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
    (define-key map (kbd "`") 'cua-set-mark)
    (define-key map (kbd "=") 'er/expand-region)
    (define-key map (kbd "]") 'forward-page)
    (define-key map (kbd "[") 'backward-page)
    (define-key map (kbd "e")   'move-end-of-line)
    (define-key map (kbd "a")   'move-beginning-of-line)
    (define-key map (kbd "<f2>")   'go-to-line)
    (define-key map (kbd "C-TAB")   'other-window)

    ;; Actions
    (define-key map (kbd "b")   'ivy-switch-buffer)
    (define-key map (kbd "RET")   'newline)
    (define-key map (kbd "d") 'delete-char)
    (define-key map (kbd "<backspace>") 'delete-backward-char)
    (define-key map (kbd "y")   'cua-paste)
    (define-key map (kbd "C-w")   'kill-region)
    (define-key map (kbd "M-w")   'kill-ring-save)

    (define-key map (kbd "h")   'kill-and-join-forward)
    (define-key map (kbd "f") 'turn-off-and-ido-find-file)
    (define-key map (kbd "g") 'keyboard-quit)
    (define-key map (kbd "s")   'turn-off-and-swiper)
    (define-key map (kbd "z")   'undo)

    (define-key map (kbd "M-x")   'turn-off-and-smex)
    (define-key map (kbd "C-x C-s") 'save-buffer)
    (define-key map (kbd "ESC ESC") 'turn-off-lxdrive)
    (define-key map (kbd "SPC") 'turn-off-lxdrive)
    (define-key map (kbd "M-SPC") 'turn-off-lxdrive)

    map)
  "Keymap for lxdrive-minor-mode.")

(define-minor-mode lxdrive-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :lighter " lx")


;; (defun my-minibuffer-setup-hook ()
;;   (lxdrive-minor-mode 0))

;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


;;(lxdrive-minor-mode 1)
(global-set-key (kbd "ESC ESC") 'turn-on-lxdrive)
(global-set-key (kbd "M-SPC") 'turn-on-lxdrive)
(spaceline-toggle-lxdrive-on)
(provide 'extensions/editor/lxdrive-mode)
;;; lxdrive-mode  ends here
