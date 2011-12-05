package org.projectodd.devignition.beans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class TweetClassifier {
    
    private static final Map<String,String> CLASSIFICATIONS = classifications();
    
    public String[] classify(String text) {
        ArrayList<String> matches = new ArrayList<String>();
        for(Map.Entry<String,String> each : CLASSIFICATIONS.entrySet()) {
            if (text != null && text.toLowerCase().contains( each.getKey() )) {
                matches.add( each.getValue() );
            }
        }
        return matches.toArray( new String[0] );
    }

    private static Map<String,String> classifications() {
        Map<String,String> map = new HashMap<String,String>();
        map.put( "gaga", "gaga" );
        map.put( "bieber", "bieber" );
        map.put( "justin", "double-bieber" );
        map.put( "selena", "this-is-getting-absurd" );
        return map;
    }
}
