classdef TestObject < handle
    %TESTOBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name='Im Test Ojbect ';
        ID=0;
        VALUE=0;
        InnerObject1;
        InnerObject2;
    end
    
    methods
        function TO=TestObject(id,name,value)
            TO.ID=id;
            TO.Name=name;
            TO.VALUE=value;
        end
        function setNewValue(TO,value)
            TO.VALUE=value;
        end
        function setInnerObject1(TO,INNER)
           TO.InnerObject1=INNER; 
        end
        function setInnerObject2(TO,INNER)
           TO.InnerObject2=INNER; 
        end
    end
    
end

