classdef ooclass 
    %OOCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        function exceeded(TOO)
            if TOO.Value > 100
                TOO.Status='Too Much';
            else
                TOO.Status='Too Little';
            end
        end
        function addPublisher(Pub)
           addlistener(Pub, 'ValueExceeded',@(src,evnt)ooclass.exceeded(src)); 
        end
      
    end
    
end

