classdef DriverTimer < handle
    %TIMER Summary of this class goes here
    %Detailed explanation goes here
    
    properties
        delay=2;
        state='off';
        tmr;
    end
    events
        TimerPulsed;
    end
    methods
        function TMR=DriverTimer(delay)
            disp('created timer');
            TMR.delay=delay;
        end
        function setDelay(TMR,delay)
            disp('set delay');
            TMR.delay=delay;
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
        function addTimerListener(publisher,subscriber,tmrEvent)
            disp('add timer listener');
            addlistener(publisher, tmrEvent, @(evtSource,evtData)timerEvent(subscriber,evtSource,evtData)); 
        end
        function callback(TMR)
            %disp('Timer went off');
            notify(TMR,'TimerPulsed');
            %disp('Timer nofify sent');
        end
        
    end
    
end


