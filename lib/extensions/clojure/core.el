(defun setup-keys ()
  (define-key clojure-mode-map (kbd "M-<right>") 'paredit-forward-slurp-sexp)
  (define-key clojure-mode-map (kbd "M-<left>") 'paredit-backward-slurp-sexp)

  (define-key clojure-mode-map (kbd "C-<right>") 'right-word)
  (define-key clojure-mode-map (kbd "C-<left>") 'left-word)
  (global-set-key (kbd "C-<right>") 'right-word)
  (global-set-key (kbd "C-<left>") 'left-word))

;; Add requires to blank devcards files
(defun cljr--find-source-ns-of-devcard-ns (test-ns test-file)
  (let* ((ns-chunks (split-string test-ns "[.]" t))
         (test-name (car (last ns-chunks)))
         (src-dir-name (s-replace "devcards/" "src/" (file-name-directory test-file)))
         (replace-underscore (-partial 's-replace "_" "-"))
         (src-ns (car (--filter (or (s-prefix-p it test-name)
                                    (s-suffix-p it test-name))
                                (-map (lambda (file-name)
                                        (funcall replace-underscore
                                                 (file-name-sans-extension file-name)))
                                      (directory-files src-dir-name))))))
    (when src-ns
      (mapconcat 'identity (append (butlast ns-chunks) (list src-ns)) "."))))

(defun clj--find-devcards-component-name ()
  (or
   (ignore-errors
     (with-current-buffer
         (find-file-noselect (clj--src-file-name-from-cards (buffer-file-name)))
       (save-excursion
         (goto-char (point-max))
         (search-backward "defcomponent ")
         (clojure-forward-logical-sexp)
         (skip-syntax-forward " ")
         (let ((beg (point))
               (end (progn (re-search-forward "\\w+")
                           (point))))
           (buffer-substring-no-properties beg end)))))
   ""))

(defun cljr--add-card-declarations ()
  (save-excursion
    (let* ((ns (clojure-find-ns))
           (source-ns (cljr--find-source-ns-of-devcard-ns ns (buffer-file-name))))
      (cljr--insert-in-ns ":require")
      (when source-ns
        (insert "[" source-ns " :refer [" (clj--find-devcards-component-name) "]]"))
      (cljr--insert-in-ns ":require")
      (insert "[devcards.core :refer-macros [defcard]]"))
    (indent-region (point-min) (point-max))))

(defun live-delete-and-extract-sexp ()
  "Delete the sexp and return it."
  (interactive)
  (let* ((begin (point)))
    (forward-sexp)
    (let* ((result (buffer-substring-no-properties begin (point))))
      (delete-region begin (point))
      result)))

(defun live-cycle-clj-coll ()
  "convert the coll at (point) from (x) -> {x} -> [x] -> (x) recur"
  (interactive)
  (let* ((original-point (point)))
    (while (and (> (point) 1)
                (not (equal "(" (buffer-substring-no-properties (point) (+ 1 (point)))))
                (not (equal "{" (buffer-substring-no-properties (point) (+ 1 (point)))))
                (not (equal "[" (buffer-substring-no-properties (point) (+ 1 (point))))))
      (backward-char))
    (cond
     ((equal "(" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "{" (substring (live-delete-and-extract-sexp) 1 -1) "}"))
     ((equal "{" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "[" (substring (live-delete-and-extract-sexp) 1 -1) "]"))
     ((equal "[" (buffer-substring-no-properties (point) (+ 1 (point))))
      (insert "(" (substring (live-delete-and-extract-sexp) 1 -1) ")"))
     ((equal 1 (point))
      (message "beginning of file reached, this was probably a mistake.")))
    (goto-char original-point)))


(defun my-toggle-expect-focused ()
  (interactive)
  (save-excursion
    (search-backward "(expect" (cljr--point-after 'cljr--goto-toplevel))
    (forward-word)
    (if (looking-at "-focused")
        (paredit-forward-kill-word)
      (insert "-focused"))))

(defun my-remove-all-focused ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "(expect-focused" nil t)
      (delete-char -8))))

(defun clj-duplicate-top-level-form ()
  (interactive)
  (save-excursion
    (cljr--goto-toplevel)
    (insert (cljr--extract-sexp) "\n")
    (cljr--just-one-blank-line)))

(defun clj-hippie-expand-no-case-fold ()
  (interactive)
  (let ((old-syntax (char-to-string (char-syntax ?/))))
    (modify-syntax-entry ?/ " ")
    (hippie-expand-no-case-fold)
    (modify-syntax-entry ?/ old-syntax)))

(defun nrepl-warn-when-not-connected ()
  (interactive)
  (message "Oops! You're not connected to an nREPL server. Please run M-x cider or M-x cider-jack-in to connect."))


;;;###autoload
(defun cljr-init ()
  (interactive)
  (require 'clj-refactor)

  (clj-refactor-mode 1)

  (setq cljr-magic-require-namespaces
        '(("io"   . "clojure.java.io")
          ("set"  . "clojure.set")
          ("str"  . "clojure.string")
          ("walk" . "clojure.walk")
          ("zip"  . "clojure.zip")
          ("time" . "clj-time.core")
          ("log"  . "clojure.tools.logging")
          ("json" . "cheshire.core")))

  ;; refer all from expectations
  (setq cljr-expectations-test-declaration "[expectations :refer :all]")

  ;; insert keybinding setup here
  (cljr-add-keybindings-with-prefix "C-c v")
  (setq cljr-favor-prefix-notation nil)
  (setq cljr-favor-private-functions nil)

  ;; Don't warn me about the dangers of clj-refactor, fire the missiles!
  (setq cljr-warn-on-eval nil)

  (add-hook 'clojure-mode-hook #'yas-minor-mode)

  ;; no auto sort
  (setq cljr-auto-sort-ns nil)

  ;; do not prefer prefixes when using clean-ns
  (setq cljr-favor-prefix-notation nil)

  (cljr-add-keybindings-with-modifier "C-s-")

  (define-key clj-refactor-map (kbd "C-x C-r") 'cljr-rename-file)
  (define-key clojure-mode-map [remap paredit-forward] 'clojure-forward-logical-sexp)
  (define-key clojure-mode-map [remap paredit-backward] 'clojure-backward-logical-sexp)
  (define-key clojure-mode-map (kbd "C->") 'cljr-thread)
  (define-key clojure-mode-map (kbd "C-<") 'cljr-unwind)

  (define-key clj-refactor-map
    (cljr--key-pairs-with-modifier "C-s-" "xf") 'my-toggle-expect-focused)
  (define-key clj-refactor-map
    (cljr--key-pairs-with-modifier "C-s-" "xr") 'my-remove-all-focused)

  (defadvice cljr--add-ns-if-blank-clj-file (around add-devcards activate)
    (ignore-errors
      (when (and cljr-add-ns-to-blank-clj-files
                 (cljr--clojure-ish-filename-p (buffer-file-name))
                 (= (point-min) (point-max)))
        ad-do-it
        (when (clj--is-card? (buffer-file-name))
          (cljr--add-card-declarations)))))

  (defadvice cljr-find-usages (before setup-grep activate)
    (window-configuration-to-register ?$)))

;;;###autoload
(defun clojure-mode-init ()
  (interactive)

  (require 'cider)
  (require 'hl-sexp)
  (require 'paredit)

  ;; indent [quiescent.dom :as d] specially
  (define-clojure-indent
    (d/a 1)
    (d/button 1)
    (d/div 1)
    (d/form 1)
    (d/h1 1)
    (d/h2 1)
    (d/h3 1)
    (d/h4 1)
    (d/h5 1)
    (d/hr 1)
    (d/img 1)
    (d/label 1)
    (d/li 1)
    (d/option 1)
    (d/p 1)
    (d/pre 1)
    (d/select 1)
    (d/small 1)
    (d/span 1)
    (d/strong 1)
    (d/ul 1)
    (d/svg 1)

    ;; Hafslund specifics
    (e/prose 1)
    (e/value 1)
    (e/section 1)
    (e/section-prose 1)
    (e/page 1)
    (e/instructions 1)
    (l/padded 1)
    (l/bubble-grid 1)
    (l/slider 1)
    (l/bottom-fixed 1)
    (c/box 1)
    (c/group 1)
    (c/list 1))

  (defadvice clojure-test-run-tests (before save-first activate)
    (save-buffer))

  (defadvice nrepl-load-current-buffer (before save-first activate)
    (save-buffer))

  (setq cider-pprint-fn 'pprint)

  (setq cider-repl-history-file (concat tmp-directory "/cider-repl-history"))

  ;; nice pretty printing
  (setq cider-repl-use-pretty-printing t)

  ;; nicer font lock in REPL
  (setq cider-repl-use-clojure-font-lock t)

  ;; result prefix for the REPL
  (setq cider-repl-result-prefix ";; => ")

  ;; never ending REPL history
  (setq cider-repl-wrap-history t)

  ;; looong history
  (setq cider-repl-history-size 3000)


  ;; error buffer not popping up
  (setq cider-show-error-buffer nil)

  ;; Use figwheel for cljs repl
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

  ;; Indent and highlight more commands
  (put-clojure-indent 'match 'defun)

  ;; Hide nrepl buffers when switching buffers (switch to by prefixing with space)
  (setq nrepl-hide-special-buffers t)

  ;; Enable error buffer popping also in the REPL:
  (setq cider-repl-popup-stacktraces t)

  ;; Specify history file
  (setq cider-history-file (concat (getenv "HOME") "/.tmp/nrepl-history"))

  ;; auto-select the error buffer when it's displayed
  (setq cider-auto-select-error-buffer t)

  ;; Prevent the auto-display of the REPL buffer in a separate window after connection is established
  (setq cider-repl-pop-to-buffer-on-connect nil)

  ;; Pretty print results in repl
  (setq cider-repl-use-pretty-printing t)

  ;; Don't prompt for symbols
  (setq cider-prompt-for-symbol nil)

  ;; eldoc for clojure
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'hl-sexp-mode)
  (add-hook 'paredit-mode-hook 'setup-keys)

  (define-key clojure-mode-map (kbd "C-`") 'live-cycle-clj-coll)
  (define-key cider-repl-mode-map (kbd "<home>") nil)
  (define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
  (define-key cider-mode-map (kbd "C-,") 'complete-symbol)
  (define-key cider-mode-map (kbd "C-c C-q") 'nrepl-close)
  (define-key cider-mode-map (kbd "C-c C-Q") 'cider-quit)
  (define-key clojure-mode-map (kbd "M-s-d") 'clj-duplicate-top-level-form)

  (add-to-list 'cljr-project-clean-functions 'cleanup-buffer)

  (define-key clojure-mode-map (kbd "s-j") 'clj-jump-to-other-file)
  (define-key clojure-mode-map (kbd "C-.") 'clj-hippie-expand-no-case-fold)
  (define-key clojure-mode-map (kbd "C-M-x")   'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-x C-e") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-e") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-l") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-r") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-z") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-k") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-n") 'nrepl-warn-when-not-connected)
  (define-key clojure-mode-map (kbd "C-c C-q") 'nrepl-warn-when-not-connected)

  (define-key clojure-mode-map (kbd "M-<right>") 'paredit-forward-slurp-sexp)
  (define-key clojure-mode-map (kbd "M-<left>") 'paredit-backward-slurp-sexp)

  (define-key clojure-mode-map (kbd "C-<right>") 'right-word)
  (define-key clojure-mode-map (kbd "C-<left>") 'left-word)
  (global-set-key (kbd "C-<right>") 'right-word)
  (global-set-key (kbd "C-<left>") 'left-word)


  (message "Clojure mode hook ran and initialized clojure-editor ability."))

(provide 'extensions/clojure/core)
