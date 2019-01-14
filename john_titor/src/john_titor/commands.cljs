(ns john-titor.commands
  (:require
   [john-titor.commands.protocols :as impl]
   [john-titor.commands.echo :as echo]))

(defn router
  [server]
  (impl/init (echo/->EchoCommand) server))
