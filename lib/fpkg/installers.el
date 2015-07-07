;;; Code:
(defun install-package-via-elpa (pkg)
  "Install a package via package.el."
  (package-install (fpkg-dependency-name pkg)))

(provide 'fpkg/installers)
