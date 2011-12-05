require 'torquebox-messaging'
require 'json'

class TweetProcessor < TorqueBox::Messaging::MessageProcessor
  include TorqueBox::Injectors

  def initialize(opts)
    @topic = TorqueBox::Messaging::Topic.new( opts['topic'] )
    @classifier = inject( Java::org.projectodd.devignition.beans.TweetClassifier )
  end

  def on_message(msg)
    tweet = JSON.parse( msg, :symbolize_names => true )
    data = {
      :message => cleanup_encoding( tweet[:text] ),
      :classifications => @classifier.classify( tweet[:text] ).to_a.join( " " ),
      :type => :tweet,
      :sender => cleanup_encoding( tweet[:user][:screen_name] ),
    }
    @topic.publish( data.to_json :encoding => :text )
  end

  def cleanup_encoding(str)
    # this is a hack to workaround a UTF-8 bug in Chrome
    str.encode!('ASCII', :invalid => :replace, :undef => :replace)
  end

end
