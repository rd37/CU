classdef Initialize < handle
    %INITIALIZE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TestClass1;
        TestClass2;
    end
    
    methods
        function INIT=Initialize()
            
        end
        function initialize(INIT)
            INIT.TestClass1=testooclass(1);
            %TO=TestObject(1,'ron',40);
            setTestObject1(INIT.TestClass1,TestObject(1,'ron',40));
            %INNER=InnerObject(5);
            setInnerObject1(INIT.TestClass1.TestObject1,InnerObject(5));
        end
        
        function illegalAccessOfInner(INIT)
            %setNumber(3);
            INIT.TestClass1.TestObject1.InnerObject1.setNumber(3);
        end
    end
    
end

