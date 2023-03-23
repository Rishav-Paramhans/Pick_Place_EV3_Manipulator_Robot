function homing(midMotor,baseMotor,griperMotor,M_Tsensor,B_Tsensor)
%% run mid motor
M_TsensorVal = readTouch(M_Tsensor); % reading touchsensor value
M_EncVal = readRotation(midMotor); % reading the encoder value
start(midMotor); % powering up midmotor
 while (true) % moving the motor until it touchsensor value is 1
     M_TsensorVal = readTouch(M_Tsensor); % read the touchsensor value
   if(M_TsensorVal == 0) % moving the motor if touch sensor value is '0'
     midMotor.Speed = -35;
    else
    midMotor.Speed=0;  % stopping the motor if touch sensor value is '1'
    resetRotation(midMotor); % resetting encoder value to 0
    break;
   end
end

%% run base motor
start(baseMotor);% powering up basemotor
B_TsensorVal = readTouch(B_Tsensor); % reading touchsensor value
B_EncVal = readRotation(baseMotor); % reading the encoder value
while(true) % moving the motor until it touchsensor value is 1
    B_TsensorVal = readTouch(B_Tsensor); % read the touchsensor value
 if( B_TsensorVal == 0)  % moving the motor if touch sensor value is '0'
     baseMotor.Speed = 30;
    else
    baseMotor.Speed = 0 ;  % stopping the motor if touch sensor value is '1'
    resetRotation(baseMotor); % resetting encoder value to 0
    break;
 end
end
%% Initiating Griper Motor 
% initiating griper motor with a positive speed ,so in main program we can
% start with a negative value,and doesnt need to change every time.
start(griperMotor); % powering up griper motor
griperMotor.Speed = 35;
pause(0.5);
griperMotor.Speed = 0;

end