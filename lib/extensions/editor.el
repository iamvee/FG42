(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/editor/init)

;; Dependencies ----------------------------------
(depends-on 'multiple-cursors)
(depends-on 'expand-region)
(depends-on 'seq)
(depends-on 'ov)
(depends-on 'cheatsheet)
(depends-on 'all-the-icons)
(depends-on 'markdown-mode)
(depends-on 'json-mode)
;; Fast move in the buffer
(depends-on 'avy)

;; Moving between windows
(depends-on 'ace-window)

;; Don't worry unless you're evil this mode won't start
(depends-on 'evil)

;; Resize splitted windows
(depends-on 'windresize)

(depends-on 'eyebrowse)

;; Themes
(depends-on 'spacemacs-theme)
(depends-on 'doom-themes)
;; TODO: Move this to an ability
(depends-on 'solaire-mode)

(with-ability nlinum
              (depends-on 'nlinum))

(with-ability spaceline
              (depends-on 'spaceline))

(with-ability doom-modeline
              (depends-on 'doom-modeline))

(with-ability guru
              (depends-on 'guru-mode))

(with-ability tramp
              (depends-on 'tramp))

(with-ability ivy
              (depends-on 'ivy)
              (depends-on 'counsel))

(with-ability ido
              (depends-on 'ido)
              (depends-on 'ido-completing-read+)
              (depends-on 'smex)
              (depends-on 'ido-vertical-mode)
              (depends-on 'flx-ido))

(with-ability helm
              (depends-on 'helm)
	      (depends-on 'helm-ag)
              (depends-on 'helm-themes)
              (depends-on 'helm-flx)
              (depends-on 'helm-make)
              (depends-on 'helm-mode-manager)
              (depends-on 'helm-projectile)
              (depends-on 'helm-swoop)
              (depends-on 'helm-themes))

(with-ability swiper
              (depends-on 'swiper))

(with-ability flycheck
              (depends-on 'flycheck))

(with-ability emoji
              (depends-on 'emojify))

(with-ability tabbar
              (depends-on 'tabbar))

(if (eq system-type 'darwin)
    (depends-on 'exec-path-from-shell))

;; Extension -------------------------------------
(extension editor
	   :version "2.31"
	   :on-initialize extensions/editor-initialize)

(provide 'extensions/editor)
