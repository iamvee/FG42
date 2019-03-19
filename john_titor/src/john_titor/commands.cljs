(ns john-titor.commands
  (:require
   [john-titor.commands.protocols :as impl]
   [john-titor.commands.echo :as echo]
   [john-titor.commands.github :as github]))

(defn router
  [server]
  (impl/init (echo/->EchoCommand) server)
  (impl/init (github/->GithubCommandRouter) server))
