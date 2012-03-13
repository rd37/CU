classdef PubSubEventData < event.EventData
    %PUBSUBEVENTDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        curr_pos=0;
        eventName;
    end
   
    methods
        function eventData = PubSubEventData(value,name)
           eventData.curr_pos=value;
           eventData.eventName=name;
        end
    end
    
end

