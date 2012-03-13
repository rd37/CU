rs=RS232('Com5',115200);
mm=Merc863(rs,15);
ip=input('init complete?','s');
mm.move(-10,0);
fclose(rs.connection);
clear;
clc;