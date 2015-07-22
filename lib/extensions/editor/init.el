;; Functions -------------------------------------------------

(defun fg42-reload ()
  "Reload the entire FG42."
  (interactive)
  (load-file (concat (getenv "FG42_HOME") "/fg42-config.el")))

;;;###autoload
(defun extensions/editor-initialize ()
  "Base plugin initialization."
  (message "Initializing 'editor' extension.")

  (require 'extensions/editor/utils)

  ;; Remove splash screen
  (setq inhibit-splash-screen t)

  ;; scratch should be scratch
  (setq initial-scratch-message nil)


  ;; Tramp configuration -------------------------------------
  (setq tramp-default-method "ssh")

  ;; replace strings
  (global-set-key (kbd "C-c M-s") 'replace-string)

  ;; Basic Key bindings
  (global-set-key (kbd "\C-c m") 'menu-bar-mode)

  ;; Don't allow tab as indent
  (setq-default indent-tabs-mode nil)

  (ability indent-guides ()
           "Show guides for indentations in code."

           (indent-guide-global-mode)

           (ability recursive-indent-guides ()
                    "Show recursive indents guides."
                    (setq indent-guide-recursive t))

           (ability delayed-indent-guides ()
                    "Show indent guides with a delay."
                    (setq indent-guide-delay 0.3)))


  ;; Default indent width
  (setq tab-width 2)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; Enhancements ---------------------------------------------

  ;; Global configurations
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq x-select-enable-clipboard t)
  (column-number-mode t)

  ;; linum mode
  (global-linum-mode)
  (setq linum-format " %3d ")

  (menu-bar-mode -1)
  (show-paren-mode t)
  (cua-selection-mode t)



  ;; expand-region -------------------------------------------
  (global-set-key (kbd "C-=") 'er/expand-region)

  ;; Multiple cursor -----------------------------------------
  ;; multiple cursor configurations
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-SPC ") 'mc/mark-all-like-this)

  ;; Reload FG42
  (define-key global-map (kbd "<f5>") 'fg42-reload)

  ;; Key Chord ------------------------------------------------
  ;; (require 'key-chord)
  ;; (key-chord-mode 1)

  ;; (key-chord-define-global "hj"     'undo)
  ;; (key-chord-define-global "kl"     'right-word)
  ;; (key-chord-define-global "sd"     'left-word)
  ;; (key-chord-define-global "m,"     'forward-paragraph)
  ;; (key-chord-define-global "p["     'backward-paragraph)

  ;; HideShow -------------------------------------------------------
  (global-set-key (kbd "C-\-") 'hs-toggle-hiding)
  (hs-minor-mode)

  ;; IDO configurations ---------------------------------------------
  (with-ability ido
                (require 'flx-ido)
                (require 'ido-vertical-mode)

                (ido-mode t)
                (ido-everywhere t)
                (ido-ubiquitous-mode 1)

                (smex-initialize)
                (global-set-key (kbd "M-x") 'smex)

                (flx-ido-mode 1)
                (setq ido-use-faces nil)
		(setq ido-use-filename-at-point 'guess)

                (setq ido-enable-flex-matching t)
                (ido-vertical-mode 1))


  ;; Helm -----------------------------------------------------
  (with-ability helm

                (global-set-key (kbd "C-c h") 'helm-command-prefix)
                (global-unset-key (kbd "C-x c"))

                (define-key helm-map (kbd "<tab>")
                  'helm-execute-persistent-action)
                (define-key helm-map (kbd "C-i")
                  'helm-execute-persistent-action)
                (define-key helm-map (kbd "C-z")
                  'helm-select-action)

                (when (executable-find "curl")
                  (setq helm-google-suggest-use-curl-p t))

                (setq helm-split-window-in-side-p t
                      helm-move-to-line-cycle-in-source t
                      helm-ff-search-library-in-sexp t
                      helm-scroll-amount 8
                      helm-ff-file-name-history-use-recentf t)

                (helm-mode 1))

  ;; Swiper ---------------------------------------------------
  (ability swiper ()
           "Replace default isearch with swiper"
           (ivy-mode 1)

           (setq ivy-use-virtual-buffers t)
           (global-set-key "\C-s" 'swiper)
           (global-set-key "\C-r" 'swiper)
           (global-set-key (kbd "C-c C-r") 'ivy-resume)
           (global-set-key [f6] 'ivy-resume)
           (with-ability ido
                         (global-set-key (kbd "C-x b") 'ido-switch-buffer)))

  ;; Session Management ---------------------------------------
  (desktop-save-mode 1)

  ;; Backup files ---------------------------------------------
  ;; Put them in one nice place if possible
  (if (file-directory-p "~/.backup")
      (setq backup-directory-alist '(("." . "~/.backup")))
    (make-directory "~/.backup"))

  (setq backup-by-copying t    ; Don't delink hardlinks
	delete-old-versions t  ; Clean up the backups
	version-control t      ; Use version numbers on backups,
	kept-new-versions 3    ; keep some new versions
	kept-old-versions 2)   ; and some old ones, too

  ;; get rid of yes-or-no questions - y or n is enough
  (defalias 'yes-or-no-p 'y-or-n-p)

  (setup-utils)

  (setq my-path (file-name-directory load-file-name))
  ;; Load about submenu
  (require 'extensions/editor/version)
  (require 'extensions/editor/about)
  (require 'extensions/editor/custom)
  (require 'extensions/editor/session-management))

(provide 'extensions/editor/init)
