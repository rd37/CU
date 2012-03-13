classdef pubsub
    %PUBSUB Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function addsubscriber(TMR,RS,evnt)
            addlistener(TMR,evnt,@(src,evnt)eventoccured(RS,src,evnt) );
        end
    end
    
end

