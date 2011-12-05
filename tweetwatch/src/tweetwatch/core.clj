(ns tweetwatch.core
  (:require [twitter.oauth :as oauth]
            [twitter.api.streaming :as stream]
            [twitter.callbacks.handlers :as handler]
            [immutant.messaging :as messaging])
  (:import
   (twitter.callbacks.protocols AsyncStreamingCallback)))

(def consumer-key "your-consumer-key")
(def consumer-secret "your-consumer-secret")
(def access-token "your-access-token")
(def access-token-secret "your-access-token-secret")
(def credentials (oauth/make-oauth-creds
                  consumer-key consumer-secret access-token access-token-secret))

(defn make-callbacks [handler]
  (AsyncStreamingCallback.
               handler
               #(println "ERROR:" (handler/response-return-everything %))
               #(println "EXCEPTION:" %1 %2 (.printStackTrace %2))))

(defn filter-tweets [filter-string handler]
  (stream/statuses-filter
   :params {:track filter-string}
   :oauth-creds credentials
   :callbacks (make-callbacks handler)))

(defn publish-tweet
  "Publishes a tweet to the given destination"
  [destination _ stream]
  (messaging/publish destination (.toString stream) :encoding :text))









