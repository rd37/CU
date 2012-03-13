classdef Driver < handle
    %DRIVER Summary of this class goes here
    %   Detailed explanation goes here
    properties (Access=protected)
        address=0;
        connection;
        timer;
    end
    
    methods
        %driver constructor called by sub class
        function driver=Driver(address,connection)
            driver.address=address;
            driver.connection=connection;
        end
        
        function setTimer(driver, interval)
            %same in java if timer!=null 
            if ~isempty(driver.timer)
                disp('update timer');
                driver.timer.setDelay(interval);
            else
                disp('create new timer');
                driver.timer=DriverTimer(interval);
                addTimerListener(driver.timer,driver,'TimerPulsed');
            end
        end
        
        function activateTimer(driver)
            if ~isempty(driver.timer)
               disp('activate timer');
               activateTimer(driver.timer);
            end
        end
        
        function deactivateTimer(driver)
            if ~isempty(driver.timer)
                disp('deactivate timer');
               deactivateTimer(driver.timer);
            end
        end
        
        function addDriverListener(publisher,subscriber,drvEvent)
            disp('add driver listener');
            addlistener(publisher, drvEvent, @(evtSource,evtData)driverEventOccured(subscriber,evtSource,evtData)); 
        end
        
        function destroy(driver)
            disp('destroy this driver');
             if ~isempty(driver.timer)
                 deactivateTimer(driver.timer);
             end
             driver.connection.delete();
        end
    end
    
    methods (Abstract)
        move( obj, value, interval );
        findRef( obj );
        result=timerEvent(subscriber, publisher, evtData);
    end
    
end

