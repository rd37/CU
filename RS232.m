classdef RS232 < handle
    %RS232 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SERIALOBJ;
        COMPORT='COM5';
        BaudRate=115200;
        DataBits=8;
        Parity='none';
        StopBits=1;
        FlowControl='none';
        
        ACTSVO='SVO 1 1 ';
        DEACTSVO='SVO 1 0 ';
        REFSVO='FRF'
        MVSVO='MOV 1 ';
        SVOPOS='POS?';%need to scanf after
        
        DesiredPosition=0;
        ActualPosition=0;
        PositionError=0.0001;
        State=0;
        ID=0;
        MoveTimer;
    end
    
    events
       MoveComplete; 
       MoveError;
    end
    
    methods
        function RS=RS232(id)
            RS.ID=id;
        end
        
        function initialize(RS)
            if RS.State==0
               disp('try to create new serial object');
               RS.SERIALOBJ=serial(RS.COMPORT,'BaudRate',RS.BaudRate,'DataBits',RS.DataBits,'Parity',RS.Parity,'StopBits',RS.StopBits,'FlowControl',RS.FlowControl);
               fopen(RS.SERIALOBJ);
               fprintf(RS.SERIALOBJ,RS.ACTSVO);
               fprintf(RS.SERIALOBJ,RS.REFSVO);
                             
               RS.MoveTimer=Timer(RS.ID);
               setDelay(RS.MoveTimer,0.01);
               %create timer with method to check if it is refed complete
               
               %register as subscriber to timer
               pubsub.addsubscriber(RS.MoveTimer,RS,'TimerPulsed');
                
               %if so go to state 1
               disp('RS232 Initialized : State:1');
               RS.State=1;
            end
        end
        
        function setdesiredpos(RS,pos)
            if RS.State==1
                RS.State=2;
                RS.DesiredPosition=pos;
                %activate timer till at position
                %create new timer
                %set this object as subscriber to timer
                %timer will periodically invoke method in RS232
                
                %now send move command to mirror
                posstr=num2str(pos);
                cmd=[RS.MVSVO posstr];
                fprintf(RS.SERIALOBJ,cmd);
                
                activateTimer(RS.MoveTimer);
           else
                notify(RS,'MoveError');
                %display('RS232 notify of MoveError');
           end
        end
        function eventoccured(RS,src,evnt)
           %disp('RS received event occured yehh it works check if move is complete');
           %disp(RS.ID);
           if RS.State == 2
               fprintf(RS.SERIALOBJ,RS.SVOPOS);
               res=fscanf(RS.SERIALOBJ);
               %disp(res);
               %need to do this twice second time to remove '='
               [f,y]=strtok(res,'=');
               [f,y]=strtok(y,'=');
               currpos=str2double(f);
               resadderr=RS.DesiredPosition+RS.PositionError;
               ressuberr=RS.DesiredPosition-RS.PositionError;
               if (resadderr>=currpos) && (ressuberr<=currpos)
                  %disp('in the zone shutdown timer and notify listeners');
                  deactivateTimer(RS.MoveTimer);
                  RS.State=1;
                  notify(RS,'MoveComplete');
               else
                   disp(currpos);
               end
           end
        end
        function destroyrs232(RS)
           deactivateTimer(RS.MoveTimer);
           clear RS.MoveTimer;
           fclose(RS.SERIALOBJ);
           RS.State=0;
           clear RS;
        end
    end
    
end

