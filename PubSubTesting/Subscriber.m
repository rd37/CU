classdef Subscriber
    %SUBSCRIBER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID;
    end
    
    methods
        function Sub=Subscriber(id) 
            Sub.ID=id;
        end
        
        function publish_event_occured(evt_sub,evt_pub,evt_data)
            disp(['Pub ' evt_pub.ID ' : Sub ' evt_sub.ID]);
            disp(evt_pub.ID);disp(evt_sub.ID);
            disp(['Event:' evt_data.eventName]);
            if strcmp(evt_data.eventName,'PublishEventExceeded');
                disp(['Exceeded Data is ' ]);disp(evt_data.curr_pos);
            end
        end
    end
    
end

