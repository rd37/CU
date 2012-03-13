


classdef testooclass < handle
    %TESTOOCLASS Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Value=0;
        Status='Wait';
        TestObject1;
        TestObject2;
    end
    events
       ValueExceeded; 
    end
    methods
        function TOO=testooclass(initvalue)
           TOO.Value=initvalue; 
           ooclass.addPublisher(TOO);
        end
        function add(TOO,amt)
            TOO.Value = TOO.Value + amt;
            notify(TOO,'ValueExceeded');
        end
        function setTestObject1(TOO,TO)
           TOO.TestObject1=TO; 
        end
        function setTestObject2(TOO,TO)
           TOO.TestObject2=TO; 
        end
        function retVal=getValue(TOO)
           retVal=TOO.Value;
        end
    end
    
end

