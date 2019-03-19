(ns john-titor.commands.github
  (:require
   [john-titor.github :as github]
   [john-titor.utils :as u]
   [john-titor.commands.protocols :as proto :refer [defcommand]]))

(deftype GithubCommandRouter []
  proto/CommandRouter
  (init [_ server]
    (defcommand server
      "github-notifications"
      (fn [& args]
        (u/wait-for (github/notification-command args))))))

(comment
  (u/wait-for (github/notification-command [])))
