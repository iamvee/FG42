(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/editor/init)

;; Dependencies ----------------------------------
(depends-on 'multiple-cursors)
(depends-on 'expand-region)
(depends-on 'dired+)
(depends-on 'seq)
(depends-on 'ov)
(depends-on 'cheatsheet)
(depends-on 'all-the-icons)

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

(with-ability guru
              (depends-on 'guru-mode))

(with-ability tramp
              (depends-on 'tramp))

(with-ability ivy
              (depends-on 'ivy)
              (depends-on 'counsel))

(with-ability ido
              (depends-on 'ido)
              (depends-on 'ido-ubiquitous)
              (depends-on 'smex)
              (depends-on 'ido-vertical-mode)
              (depends-on 'flx-ido))

(with-ability helm
              (depends-on 'helm)
	      (depends-on 'helm-ag))

(with-ability swiper
              (depends-on 'swiper))

(with-ability flycheck
              (depends-on 'flycheck))


;; Extension -------------------------------------
(extension editor
	   :version "2.31"
	   :on-initialize extensions/editor-initialize)

(provide 'extensions/editor)
