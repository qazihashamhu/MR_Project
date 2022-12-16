function validStates = helperSampleSelectedAreaOnMap(sv, area, numPoints)
%helperSampleSelectedAreaOnMap return unoccupied states randomly sampled
% from the rectangular area defined by area. numPoints define the number of 
% states that needs to be sampled and returned. state validator sv is used
% to validate whether the states are valid or not.  

% Copyright 2021 The MathWorks Inc. 

    filledStateIdx = 0;
    validStates = zeros(numPoints,3);
    thetaSampledRegion = [pi/4 3*(pi/4)];
    loopCount = 0;
    maxLoopCount = 30;
    while filledStateIdx <= numPoints
        statesSampled = sampleUniformInMap(area, thetaSampledRegion, numPoints);
        validStateIndex = isStateValid(sv, statesSampled);
        numValidStates = nnz(validStateIndex);
        validStates(filledStateIdx+1:filledStateIdx+numValidStates,:) = ...
            statesSampled(validStateIndex,:);
        filledStateIdx = filledStateIdx + numValidStates;
        loopCount = loopCount + 1;
        % Avoid inifinite loop when the sampled region is choosen such that
        % all the points will be inside an obstacle.
        if loopCount > maxLoopCount
            break;
        end
    end
    validStates = validStates(1:numPoints,:);
end

function sampledStates = sampleUniformInMap(area, thetaSampledRegion, numPoints)
%sampleUniformInMap return numPoint states that are uniformly sampled from
% the defined area
    x = area(1);
    y = area(2);
    w = area(3);
    h = area(4);
    thetaRange = thetaSampledRegion(2) - thetaSampledRegion(1);
    
    xPoints = rand(numPoints,1)*w + x;
    yPoints = rand(numPoints,1)*h + y;
    thetaPoints = rand(numPoints,1)*thetaRange + thetaSampledRegion(1);
    sampledStates = [xPoints, yPoints, thetaPoints];
end
