(ns john-titor.commands.echo
  (:require
   [john-titor.commands.protocols :as proto :refer [defcommand]]))

(defn- echo [msg]
  (str msg "/" msg))

(deftype EchoCommand []
  proto/CommandRouter
  (init [_ server]
    (defcommand server "echo" #(echo %))))
