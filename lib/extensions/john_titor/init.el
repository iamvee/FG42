;;; john_title --- Enables RPC for john titor client
;;; Commentary:
;;; Code:
(defvar epc-connection nil
  "The EPC connection to the john titor client.")

(defun john_titor/connect ()
  "Connect to john titor via RPC."
  (interactive)
  (setq epc-connection
        (epc:start-epc "node" '("~/.fg42/john_titor/target/main.js"))))

(defun john_titor/disconnect ()
  "Disconnect from the john titor client."
  (interactive)
  (epc:stop-epc epc-connection))


;;;###autoload
(defun extensions/john_titor-initialize ()
  "Initialize the john_titor extention."
  (require 'epc)

  (if (nilp epc-connection)
      (john_titor/connect)))

(provide 'extensions/john_titor/init)
;;; init.el ends here
