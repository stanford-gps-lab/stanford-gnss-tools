% function testUserObservationGetDOP()
clear; close all; clc;

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);
time = 0;
time2 = 0:10:1000;

satellite = sgt.Satellite.fromYuma('current.alm');
satellitePosition = satellite.getPosition(time, 'ECEF');
satellitePosition2 = satellite.getPosition(time2, 'ECEF');

equatorialUserObservation = sgt.UserObservation(equatorialUser, satellitePosition);
equatorialUserObservation2 = sgt.UserObservation(equatorialUser, satellitePosition2);

%% Test 1 - single output basic
try
    test1 = equatorialUserObservation.getDOP;
    
    if length(test1) ~= 4
        testResults(1) = 1;
    end
catch
    testResults(1) = 1;
end

%% Test 2 - 5 output basic
try
    [test2a, test2b, test2c, test2d, test2e] = equatorialUserObservation.getDOP;
    
catch
    testResults(2) = 1;
end

%% Test 3 - Multiple user observations
try
    test3 = equatorialUserObservation2.getDOP;
catch
    testResults(3) = 1;
end

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing UserObservation.getDOP.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end






