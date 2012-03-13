classdef Merc863 < Driver
    
    properties
        posError=0.0001;
        framerate;
        refPosition;
        maxVelocity;
        velocity;
        name;
        orientation;
        
        %pin IO properties
        OUTPIN1;
        OUTPIN2;
        OUTPIN3;
        OUTPIN4;
        
        INPIN1;
        INPIN2;
        INPIN3;
        INPIN4;
    end
    
    events
       AXISREACHEDPOSITION;
       AXISCHANGED;
    end
    
    methods
        function controller=Merc863(connection,address)
            controller=controller@Driver(address,connection);
            controller.connection.send(controller.address, ' SVO 1 1');
            controller.checkError();
            controller.findRef();
        end
        
        function move(controller,pos,interval)
            if interval ~= 0
               controller.setTimer( interval ); 
            end
            controller.connection.send(controller.address, [' MOV 1 ' num2str(pos)]); 
            controller.checkError();
            activateTimer( controller );
        end
        
        function findRef( driver )
            driver.connection.send(driver.address, ' FRF');
            driver.checkError();
        end
        
        function currentPosition = getCurrentPosition(driver)
            result = driver.connection.query(driver.address, ' POS?', 1);
            currentPosition = Merc863.stripPrefix(result{1});
            driver.checkError();
        end
        
        function targetPosition = getTargetPosition(driver)
            result = driver.connection.query(driver.address, ' MOV?', 1);
            targetPosition = Merc863.stripPrefix(result{1});
            driver.checkError();
        end
        
        function setOutPin(iodriver,pinNum,pinValue)
            %disp([num2str(iodriver.address) ' DIO ' num2str(pinNum) num2str(pinValue) ]);
            iodriver.connection.send(iodriver.address, [' DIO ' num2str(pinNum) ' ' num2str(pinValue) ]);
            iodriver.checkError();
        end
        
        function pinValue=getInPin(driver,pinNum)
            result = driver.connection.query(driver.address, ' DIO?', 4);
            pinValue = Merc863.stripPrefix(result{pinNum});
        end
        
        function delete(driver)
             driver.connection.send([num2str(driver.address) ' SVO 1 0']);
             driver.checkError();
        end
        
        %called by timer periodically checks for all event types 
        %and notifies listeners
        function timerEvent(subscriber, publisher, evtData)
           %disp('1.first');
           currentPos=getCurrentPosition(subscriber);
           targetPos=getTargetPosition(subscriber);
           evt=Merc863Event('AXISCHANGED');
           evt.targetPosition=targetPos;
           evt.currentPosition=currentPos;
           notify(subscriber,'AXISCHANGED',evt);
           
           %disp('2.recieved timer event curr pos ');
           %disp(currentPos);disp(targetPos);
           
           
           if strcmp(num2str(currentPos),num2str(targetPos))
              %disp('3. target reached');
              deactivateTimer(subscriber.timer);
              evt3=Merc863Event('AXISREACHEDPOSITION');
              evt3.targetPosition=targetPos;
              evt3.currentPosition=currentPos;
              notify(subscriber,'AXISREACHEDPOSITION',evt3);
           else
               %disp('4. target not acheived');
           end
           
        end
    end
    
    methods (Access=private)
        function checkError(driver)
            error = driver.connection.query(driver.address, ' ERR?', 1);
            errorTok=error{1};
            [~, errorTok] = strtok(errorTok);
            [~, err] = strtok(errorTok);
            
            if err ~= '0'
                disp (err);
                %throw('ExceptThisBitch');
            end
        end
    
    end
    
    methods (Static)
        function output = stripPrefix(input)
            [~, postfix] = strtok(input, '=');
            output = postfix(2:end);
        end
    end
end

