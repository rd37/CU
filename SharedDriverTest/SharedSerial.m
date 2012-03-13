classdef SharedSerial < handle
    %SHAREDSERIAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        serial_driver;
        ACTSVO=' SVO 1 1 ';
        DEACTSVO=' SVO 1 0 ';
        REFSVO=' FRF '
        MVSVO=' MOV 1 ';
        SVOPOS=' POS? ';%need to scanf after
        state=0;
    end
    
    methods
        function SER=SharedSerial(comport,baudrate)
            SER.serial_driver=serial(comport,'BaudRate',baudrate,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none');
            fopen(SER.serial_driver);
        end
        function initialize(SER,address)
            addstr=num2str(address);
            fprintf(SER.serial_driver,[addstr ' ' SER.ACTSVO]);
            fprintf(SER.serial_driver,[addstr ' ' SER.REFSVO]);
        end
        function send_command(SER,cmd,address)
            if SER.state == 0
                SER.state=address;
                addstr=num2str(address);
                fprintf(SER.serial_driver,[addstr ' ' cmd]);
            else
                disp('Error sending command, for another address to get result');
            end
        end
        function ret=get_result(SER,address)
            if SER.state == address
                res=fscanf( SER.serial_driver );
                [~,y]=strtok(res,'=');
                [f,~]=strtok(y,'=');
                SER.state=0;
                ret=str2double(f); 
            else
                disp('Error getting result, waiting for another address to get result');
                ret='null';
            end
            
        end
    end
    
end

