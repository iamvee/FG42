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
      #(u/on-value (github/notification-command %)))))

(comment
  (u/on-value (github/notification-command [])
              #(println %)))
