;;; john_titor --- Enables RPC for john titor client
;;; Commentary:
;;; Code:
(require 'epc)

(defvar epc-connection nil
  "The EPC connection to the john titor client.")

(defun john_titor/connect ()
  "Connect to john titor via RPC."
  (setq epc-connection
        (if debug-on-error
            (epc:start-epc "node" (list (concat
                                          (getenv "HOME")
                                          "/.fg42/john_titor/target/main.js")))
          (epc:start-epc "node" (list (concat
                                        (getenv "HOME")
                                        "/.fg42/john_titor/app.js"))))))

(defun john_titor/call-sync (command args)
  "Call the given COMMAND with the given ARGS via john titor epc."
  (epc:call-sync epc-connection command args))

(defun eval-string (str)
  "Evaluate the given STR."
  (message str)
  (eval (car (read-from-string (format "(progn %s)" str)))))

(defun john_titor/call (command args f)
  "Call the COMMAND with the given ARGS in async fashion and call F as callback."
  (deferred:$
    (epc:call-deferred epc-connection command args)
    (deferred:nextc it
      (lambda (x)
        (funcall f x)))
    (deferred:error it
      (lambda (err)
        (message "ERROR: %s" err)))))

(defun john_titor/disconnect ()
  "Disconnect from the john titor client."
  (epc:stop-epc epc-connection)
  (setq epc-connection nil))

(defun john_titor/restart ()
  "Restart the epc server."
  (john_titor/disconnect)
  (john_titor/connect))

(provide 'john_titor)
;;; john_titor.el ends here
