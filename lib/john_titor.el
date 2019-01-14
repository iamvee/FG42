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
            (epc:start-epc "node" '("../../../john_titor/target/main.js"))
          (epc:start-epc "node" '("../../../john_titor/app.js")))))

(defun john_titor/call-sync (command args)
  "Call the given COMMAND with the given ARGS via john titor epc."
  (epc:call-sync command args))


(defun john_titor/call (command args f)
  "Call the COMMAND with the given ARGS in async fashion and call F as callback."
  (deferred:$
    (epc:call-deferred epc-connection command args)
    (deferred:nextc it f)))

(defun john_titor/disconnect ()
  "Disconnect from the john titor client."
  (epc:stop-epc epc-connection))


(provide 'john_titor)
;;; john_titor.el ends here
