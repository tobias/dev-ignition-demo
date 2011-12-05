require 'torquebox-stomp'
require 'json'

class TweetStomplet < TorqueBox::Stomp::JmsStomplet

  def configure(opts)
    super
    @topic = TorqueBox::Messaging::Topic.new( opts[:topic] )
    @subscriber_count = 0
  end

  def on_subscribe(subscriber)
    @subscriber_count += 1
    subscribe_to( subscriber, @topic )
    notify_count
  end

  def on_unsubscribe(subscriber)
    super
    @subscriber_count -= 1
    notify_count
  end

  def notify_count
    send_to( @topic,
             {
               :message => "#{@subscriber_count} clients connected",
               :sender => 'the_system',
               :type => :notice
             }.to_json )
  end


end
