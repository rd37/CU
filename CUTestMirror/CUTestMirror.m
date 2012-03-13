classdef CUTestMirror
    %CUTESTMIRROR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        driver;
        ID;
    end
    
    methods
        function CUT=CUTestMirror(id)
            CUT.ID=id;
            CUT.driver=RS232(id);
            initialize(CUT.driver);
            pubsub.addsubscriber(CUT.driver,CUT,'MoveComplete');
            pubsub.addsubscriber(CUT.driver,CUT,'MoveError');
        end
        function destroy(CUT)
           destroyrs232(CUT.driver); 
        end
        function setdesiredpos(CUT,pos)
           setdesiredpos(CUT.driver,pos); 
        end
        function eventoccured(CUT,src,evnt)
            
            if strcmp(evnt.EventName,'MoveComplete')
                disp('CUT received move complete event');
            else if strcmp(evnt.EventName,'MoveError')
                disp('CUT received move error');
                end
            end
        end
    end
    
end

