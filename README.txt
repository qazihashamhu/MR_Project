mycode.mlx : This file contains the MATLAB code of Bug2 algorithm. 
It is written with the idea that we are getting sensor data from the simulator. 
As the integration had not been achieved, this code could not be tested.

DynamicReplanningOnAnIndoorMapExample.mlx : This file contains an example from 
the navigation toolbox that uses an advance Hybrid A* algorithm to avoid dynamic obstacle 
in an Indoor map. The algorithm reroutes the path after getting the sensor data. 
Its a good example and can be applied in our case with some changes 
and integration with simulator.



MR Project Scene: Save this file in the "scene" folder. To open the file, 
go to CoppeliaSim Edu and,the  load scene from target folder; 
press run button to initiate the simulation once the code from MATLAB is sent to CoppeliaSim.



BuildMapfrom2DLidarScansUsingSLAM.mlx: this file contains the MATLAB code for implementing SLAM 
on a series of 2D lidar scans using scan matching algorithms and pose graph optimization (PGO). 
The goal was to estimate the trajectory of the robot and build a map of the environment. 
Make sure to install the Navigation toolbox and Lidar toolbox before hand.

LandmarkSLAMUsingAprilTagMarkersExample.mlx: This file combines the robot odometry data and 
observed fiducial markers called AprilTags to better estimate the robot trajectory and the 
landmark position in the environment. Save "cameraParams.mat" in the same folder. 
Make sure to install the Navigation Toolbox beforehand.

To run "simpleTest.m", save "remoteApiProto.m", "remoteApi.dll", "remApi.m", and 
"MR Project Scene2.ttt" in the same folder. This will help verify connection between 
Matlab and CoppeliaSim. Save "pioneer.m" in the same folder as well to run the connections 
made for the project.



BenchmarkingPathPlannersInWarehouseMapExample.mlx: this fle contains the MATLAB code for 
path planning algorithms and their benchmarking. To run this file, download  
“helperCalculateAverageMetricTable.m”, “helperPlotAveragedMetrics.m”, 
“helperSampleSelectedAreaOnMap.m”, “terminal_floor_editied.pgm”, “terminal_floor_editied.png” 
and place them all in one folder. As a result, when the file is run, the map will be 
loaded and the path planning and execution route will be displayed on it based on the 
starting position and end goal position. 




