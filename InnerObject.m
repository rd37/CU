classdef InnerObject < handle
    %INNEROBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Number=0;
    end
    
    methods
        function INNER=InnerObject(num)
           INNER.Number=num; 
        end
        
        function setNumber(INNER,num)
            INNER.Number=num;
        end
    end
    
end

