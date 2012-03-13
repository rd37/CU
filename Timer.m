classdef Timer < handle
    %TIMER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        delay=2;
        state='off';
        tmr;
        id=0;
    end
    events
        TimerPulsed;
    end
    methods
        function TMR=Timer(id2)
            TMR.id=id2;
        end
        function setDelay(TMR,del)
            TMR.delay=del;
        end
        function activateTimer(TMR)
           if strcmp(TMR.state,'off')
               TMR.tmr=timer('TimerFcn',@(x,y)TMR.callback(),'Period',TMR.delay,'ExecutionMode','fixeddelay');
               start(TMR.tmr);
               TMR.state='on';
           end
        end
        function deactivateTimer(TMR)
            if strcmp(TMR.state,'on')
               stop(TMR.tmr);
               delete(TMR.tmr);
               TMR.state='off';
            end
        end
        function callback(TMR)
            %notify all listeners of this Timer
            notify(TMR,'TimerPulsed');
        end
        
    end
    
end

