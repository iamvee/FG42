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

(with-ability ivy
              (depends-on 'ivy))

(with-ability ido
              (depends-on 'ido)
              (depends-on 'ido-ubiquitous)
              (depends-on 'smex)
              (depends-on 'ido-vertical-mode)
              (depends-on 'flx-ido))

(with-ability helm
              (depends-on 'helm))

(with-ability swiper
              (depends-on 'swiper))

;; Extension -------------------------------------
(extension editor
	   :version "2.31"
	   :on-initialize extensions/editor-initialize)

(provide 'extensions/editor)
