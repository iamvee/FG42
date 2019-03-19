;;; john_title --- Enables RPC for john titor client
;;; Commentary:
;;; Code:
(require 'john_titor)

(defun john-titor-connect ()
  "Connect to john titor via RPC."
  (interactive)
  (john_titor/connect))


(defun john-titor-disconnect ()
  "Disconnect from the john titor client."
  (interactive)
  (john_titor/disconnect))

;;;###autoload
(defun extensions/john-titor-initialize ()
  "Initialize the john_titor extention."
  (require 'john_titor)

  (when (nilp epc-connection)
      (john-titor-connect)))


(provide 'extensions/john_titor/init)
;;; init.el ends here
