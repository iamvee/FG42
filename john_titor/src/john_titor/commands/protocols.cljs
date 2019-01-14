(ns john-titor.commands.protocols)

(defn defcommand [server command-name f]
  (.defineMethod server command-name f))

(defprotocol CommandRouter
  (init [_ server]
    "Define all the commands using the given `server`."))
