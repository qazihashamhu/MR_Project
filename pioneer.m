sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
sim.simxFinish(-1);
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);
[err,signal]=sim.simxReadStringStream(clientID,'measuredData',sim.simx_opmode_streaming);
if (clientID>-1)
    disp('Connected')
    % Handles
    [returnCode,left_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
    [returnCode,right_Motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',sim.simx_opmode_blocking); % Motors
    [returnCode,front_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor[5]',sim.simx_opmode_blocking);
    [returnCode,left_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor[0]',sim.simx_opmode_blocking);
    [returnCode,right_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor[8]',sim.simx_opmode_blocking); % proximity sensors
    [returnCode,laser_scan]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_fastHokuyo_ROS',sim.simx_opmode_blocking);

    % Other code
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,left_Motor,0.6,sim.simx_opmode_blocking);
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,right_Motor,0.6,sim.simx_opmode_blocking);
    [returnCode,detectionState,detectedPoint1,~,~]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionState,detectedPoint2,~,~]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_streaming);
    [returnCode,detectionState,detectedPoint3,~,~]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_streaming);
    
    [err,signal]=sim.simxReadStringStream(clientID,'measuredData',sim.simx_opmode_buffer);
    if (err==sim.simx_return_ok)
        % Data produced by the child script was retrieved! 
    end
    % Detect Obstacle
    for i=1:200
        [returnCode,detectionState,detectedPoint1,~,~]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_buffer);
        [returnCode,detectionState,detectedPoint2,~,~]=sim.simxReadProximitySensor(clientID,left_sensor,sim.simx_opmode_buffer);
        [returnCode,detectionState,detectedPoint3,~,~]=sim.simxReadProximitySensor(clientID,right_sensor,sim.simx_opmode_buffer);
        % Find absolute distance from front
        a =norm(detectedPoint1);

        pause(0.1)
    end
    
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,left_Motor,0,sim.simx_opmode_blocking);
    [returnCode]=sim.simxSetJointTargetVelocity(clientID,right_Motor,0,sim.simx_opmode_blocking);
    
    %code here
    % SLAM 
    
    sim.simxFinish(-1);



end
sim.delete(); % call the destructor!