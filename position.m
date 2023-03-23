function position(X,Y,Z,midMotor,baseMotor) 
%% Parameters of Robot
L1 = 50; % link lengths of robot
L2 = 95;
L3 = 185;
L4 = 110;
% From here we implement inverse kinematics equations and calclualte Theta
% 1 and Theta 2
%% calculating Theta 1
if X==0 % to make sure matlab doesnt give some random value for infinity,we 
    Theta1 =90;  % defined the angle is 90 when denominator is 0
    elseif X<0 && Y<=0 
        Theta1=atand( Y / X)+180; % in order not to get negative values we used this expression
else
    Theta1 = atand( Y  / X ); % inverse kinematic equation obtained for theta 1
end
%% calculating Theta2 
if ( Z < ( 70 + L1 + ( L2 / sqrt(2) ) ) ) % the conditions are taken from the diagram 
    Theta2 = 45 - asind(((70 + L1 + (L2/sqrt(2)) - Z - L4))/L3); %case 2
    else
Theta2 = 45 + asind((L4 + Z - (L2/sqrt(2)) - L1 - 70)/L3); % case 1
end
Theta_req = 86.34 - Theta2; % the value 86.34 is explained in report with diagram
Desired_M_EncValue = Theta_req * 5; % converting angle into encoder value
Desired_B_EncValue = Theta1 * 3; % converting angle into encoder value

%% implementing P Controller for BaseMotor-Theta1 value
while (true)
    Current_B_EncValue = readRotation(baseMotor); % reading the encoder value
    Error = Desired_B_EncValue + Current_B_EncValue; % calculating the error
    Gain_Kp = 1; % gain value
    Controller_Val = Gain_Kp * Error;
    %% limiting the controller value btw 1 and -1
    if Controller_Val > 1 % for simplicity purpose and to make sure we dont give too high values for motor speed 
        Controller_Val = 1; % we limited the controller value between 1 and -1
    elseif Controller_Val < -1
        Controller_Val = -1;
    end
    if abs(Error) < 10 % since the error is never zero for a p controller we limited the absolute value of error 
            baseMotor.Speed = 0;
        break;
    else
        start(baseMotor);
        baseMotor.Speed = -30 * Controller_Val;
    end
end
%% implementing P Controller for MidMotor-Theta2 value
while (true)
    Current_M_EncValue = readRotation(midMotor);
    Error = Desired_M_EncValue - Current_M_EncValue;
    Gain_Kp = 1;
    Controller_Val = Gain_Kp * Error;
    %% limiting the controller value btw 1 and -1
    if Controller_Val > 1
        Controller_Val = 1;
    elseif Controller_Val < -1
        Controller_Val = -1;
    end
    if abs(Error) < 10
        midMotor.Speed = 0;
        break;
    else
        start(midMotor);
        midMotor.Speed = 30 * Controller_Val;
    end
end
end