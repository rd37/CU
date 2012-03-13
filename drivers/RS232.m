classdef RS232 < handle
    properties
        connection;
        state=0;
    end
    
    methods
        function comm = RS232(port, baudrate)
            disp('Connecting..');
            try
                comm.connection = serial(port,'BaudRate',baudrate);
                fopen(comm.connection);
                disp('Connection Success!');
            catch ME1
                throw(ME1);
            end
        end
        
        function delete(comm)
            fclose(comm.connection);
            delete(comm.connection);
        end
        
        function send(comm, address, msg)
            if comm.state == 0
                fprintf(comm.connection, [num2str(address) ' ' msg]);
            end
        end
        
        function response = query(comm, address, msg, resultNum)
            if comm.state == 0
                comm.state=address;
                fprintf(comm.connection, [num2str(address) ' ' msg]);
                response=cell(1:resultNum);
                for i=1:resultNum,
                    response{i} = fscanf(comm.connection);
                end
                comm.state=0;
            end
            
        end
    end
end

