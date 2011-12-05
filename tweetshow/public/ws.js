
$( function() {
    client = Stomp.client( stomp_url )

    client.connect( null, null, function() {
        $(window).unload(function() { client.disconnect() })
        
        client.subscribe( '/stomplet/messages', function(message) {
            msg = $.parseJSON( message.body )
            if (msg.type == 'tweet') {
                var html = "<li class='" + msg.classifications +
                    "'><span class='sender'>" + msg.sender + 
                    ":</span> " + msg.message + "</li>"

                $("#tweets").prepend(html)
            } else {
                notice = msg
                $("#notice").fadeOut(400, function() {
                    $("#notice").html(notice.message)
                    $("#notice").fadeIn()
                })
            }

        } )
    } )

} )
