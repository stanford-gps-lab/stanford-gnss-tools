function testUserObservation()
fprintf('Testing sgt.UserObservation: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
time = 0;
time2 = 0:300:86400;

satellite = sgt.Satellite.fromYuma('current.alm');
satellitePosition = satellite.getPosition(time, 'ECEF');
satellitePosition2 = satellite.getPosition(time2, 'ECEF');

equatorialUserObservation = sgt.UserObservation(equatorialUser, satellitePosition);
equatorialUserObservation2 = sgt.UserObservation(equatorialUser, satellitePosition2);

%% Test 1 - Constructor - single user at single point in time
try
    test1 = sgt.UserObservation(equatorialUser, satellitePosition);
catch
    testResults(1) = 1;
end

%% Test 2 - Constructor - single user at multiple points in time
try
    test2 = sgt.UserObservation(equatorialUser, satellitePosition2);
catch
    testResults(2) = 1;
end

%% Test 3 - obj.getGeometryMatrix - single observation
try
    test3 = equatorialUserObservation.getGeometryMatrix;
catch
    testResults(3) = 1;
end

%% Test 4 - obj.getGeometryMatrix - multiple observations
try
    test4 = equatorialUserObservation2.getGeometryMatrix;
catch
    testResults(4) = 1;
end

%% Test 5 - obj.getGDOP - single observation
try
    test5 = equatorialUserObservation.getGDOP;
catch
    testResults(5) = 1;
end

%% Test 6 - obj.getGDOP - multiple observations
try
    test6 = equatorialUserObservation2.getGDOP;
catch
    testResults(6) = 1;
end

%% Test 7 - obj.getPDOP - single observation
try
    test7 = equatorialUserObservation.getPDOP;
catch
    testResults(7) = 1;
end

%% Test 8 - obj.getPDOP - multiple observations
try
    test8 = equatorialUserObservation2.getPDOP;
catch
    testResults(8) = 1;
end

%% Test 9 - obj.getTDOP - single observation
try
    test9 = equatorialUserObservation.getTDOP;
catch
    testResults(9) = 1;
end

%% Test 10 - obj.getTDOP - multiple observations
try
    test10 = equatorialUserObservation2.getTDOP;
catch
    testResults(10) = 1;
end

%% Test 11 - obj.getHDOP - single observation
try
    test11 = equatorialUserObservation.getHDOP;
catch
    testResults(11) = 1;
end

%% Test 12 - obj.getHDOP - multiple observations
try
    test12 = equatorialUserObservation2.getHDOP;
catch
    testResults(12) = 1;
end

%% Test 13 - obj.getVDOP - single observation
try
    test13 = equatorialUserObservation.getVDOP;
catch
    testResults(13) = 1;
end

%% Test 14 - obj.getVDOP - multiple observations
try
    test14 = equatorialUserObservation2.getVDOP;
catch
    testResults(14) = 1;
end

%% Test 15 - obj.plotSkyPlot -  single observation
try
    equatorialUserObservation.plotSkyPlot;
catch
    testResults(15) = 1;
end

%% Test 16 - obj.plotSkyPlot - multiple observations
try
    equatorialUserObservation2.plotSkyPlot;
catch
    testResults(16) = 1;
end

%% Test 17 - obj.calcualteRiseTime(satellite) - Calculate rise time
try
    riseTime = equatorialUserObservation2.calculateRiseTime(equatorialUser, satellite);
catch
    testResults(17) = 1;
end

%% Display test results
if any(testResults)
    fprintf('---Failed---\n')
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
else
    fprintf('Passed\n')
end

close all;






