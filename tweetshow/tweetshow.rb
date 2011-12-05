require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'torquebox-stomp'

class TweetShow < Sinatra::Base
  use TorqueBox::Stomp::StompJavascriptClientProvider
  
  set :views, lambda { File.join( File.dirname( __FILE__ ), "views" ) }

  helpers do
    def stomp_url
      "ws://#{request.host}:8675"
    end
  end  

  get '/' do
    haml :index
  end
end
