classdef Merc863Event < event.EventData
    %MERC863EVENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        targetPosition=0;
        currentPosition=0;
        Evt;
    end
    
    methods
        function evt=Merc863Event(EVT)
           evt.Evt=EVT;
        end
    end
    
end

