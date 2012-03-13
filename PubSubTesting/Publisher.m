classdef Publisher < handle
    %PUBLISHER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x_prop;
        ID;
    end
    
    events
        PublishEventExceeded; 
        PublishEventChanged;
    end
    
    methods
        function PUB=Publisher(id)
            PUB.ID=id;
        end
        function set_x_prop(pub, value)
            pub.x_prop=value;
            if pub.x_prop>100
                notify(pub,'PublishEventExceeded',PubSubEventData(value,'PublishEventExceeded'));
            end
            notify(pub,'PublishEventChanged',PubSubEventData(value,'PublishEventChanged'));
        end
        
        function subscribe(pub, evt_name, sub_cb)
           addlistener(pub, evt_name, @(evt_src,evt_data)publish_event_occured(sub_cb,evt_src,evt_data)); 
        end
    end
    
end

