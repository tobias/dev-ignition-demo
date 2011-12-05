TorqueBox.configure do

  environment do
    RACK_ENV 'production'
  end

  ruby :version => '1.9'
  
  queue '/queue/tweets' do
    processor TweetProcessor do
      concurrency 5
      config( :topic => '/topic/messages' )
    end
  end

  topic '/topic/messages'

  stomplet TweetStomplet do
    route '/stomplet/messages'
    config( :topic => '/topic/messages' )
  end

end
