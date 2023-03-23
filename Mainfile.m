%% create ev3 handle and motor handles
clear all
clc
ev3MeSy = legoev3('usb');% creating an object for robot or establishing connection
%% set all motor handles
griperMotor = motor(ev3MeSy,'A'); % creating motor objects
baseMotor = motor(ev3MeSy,'C');
midMotor = motor(ev3MeSy,'B');
M_Tsensor = touchSensor(ev3MeSy,3); % mid touchsensor
B_Tsensor = touchSensor(ev3MeSy,1); % base touch sensor
%% Main Program

disp("The Arm is going to a reference position")
homing(midMotor,baseMotor,griperMotor,M_Tsensor,B_Tsensor)% calling the homing function
disp("Picking the Object at C and Place at A")
        start(griperMotor)
        griperMotor.Speed = -35;% open the gripper
        pause(0.2);
        griperMotor.Speed = 0;
        position(-117.9,0,15,midMotor,baseMotor)% go to platform C,0 is actual z value for platform C,
                                                %we added some clearance according to the movement of the arm
        griperMotor.Speed = 35;% grab the ball
        pause(0.2);
        griperMotor.Speed = 0;
        position(-117.9,0,150,midMotor,baseMotor)% pick up the ball
        position(117.9,0,95,midMotor,baseMotor)% go to platform A,70 is actual z value for platform A,
                                                %we added some clearance according to the movement of the arm
        griperMotor.Speed = -35;% place the ball
        pause(0.2);
        griperMotor.Speed = 0;
        position(117.9,0,150,midMotor,baseMotor)% move away from ball
        griperMotor.Speed = 35;% close the gripper
        pause(0.2);
        griperMotor.Speed = 0;
        stop(griperMotor)% We noticed that the gripper is loosing 
             %its grip after multiple tasks,so we included start and stop 
             %for griper motor in every task so it starts fresh every time.
disp("Picking the Object at A and Place at B")
        start(griperMotor) % open the gripper
        griperMotor.Speed = -35;
        pause(0.2);
        griperMotor.Speed = 0;
        position(117.9,0,95,midMotor,baseMotor) % go to platform A
        griperMotor.Speed = 35; % grab the ball
        pause(0.2);
        griperMotor.Speed = 0;
        position(117.9,0,150,midMotor,baseMotor) % pick up the ball
        position(0,117.9,15,midMotor,baseMotor) % go to platform B
        griperMotor.Speed = -35; % place the ball
        pause(0.2);
        griperMotor.Speed = 0;
        position(0,117.9,150,midMotor,baseMotor) % move away from ball
        griperMotor.Speed = 35; % close the gripper
        pause(0.2);
        griperMotor.Speed = 0;
        stop(griperMotor) % We noticed that the gripper is loosing 
             %its grip after multiple tasks,so we included start and stop 
             %for griper motor in every task so it starts fresh every time.
disp("Picking the Object at B and Place at C")
        start(griperMotor)
        griperMotor.Speed = -35;
        pause(0.2);
        griperMotor.Speed = 0;
        position(0,117.9,15,midMotor,baseMotor)%platform B
        griperMotor.Speed = 35;
        pause(0.2);
        griperMotor.Speed = 0;
        position(0,117.9,150,midMotor,baseMotor)
        position(-117.9,0,15,midMotor,baseMotor)%platform c
        griperMotor.Speed = -35;
        pause(0.2);
        griperMotor.Speed = 0;
         position(-117.9,0,150,midMotor,baseMotor)
          griperMotor.Speed = 35;
        pause(0.2);
        griperMotor.Speed = 0;
        stop(griperMotor)
disp("The Arm is going to Home and the Motors are turned off")
        homing(midMotor,baseMotor,griperMotor,M_Tsensor,B_Tsensor)% calling homing function
        stop(midMotor); % Turning off all motors
        stop(baseMotor);
        stop(griperMotor);