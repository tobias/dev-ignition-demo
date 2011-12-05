(ns tweetwatch.init
  (:use tweetwatch.core)
  (:require [immutant.daemons :as daemon]
            [immutant.messaging :as messaging]))

(daemon/start "tweetstreamer"
              #(filter-tweets "bieber,gaga,ladygaga"
                              (partial publish-tweet "/queue/tweets")))

