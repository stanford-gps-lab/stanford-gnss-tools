function testUserObservation()
fprintf('Testing sgt.UserObservation: ')

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
time = 0;
time2 = 0:100:500;

satellite = sgt.Satellite.fromYuma('current.alm');
satellitePosition = satellite.getPosition(time, 'ECEF');
satellitePosition2 = satellite.getPosition(time2, 'ECEF');

equatorialUserObservation = sgt.UserObservation(equatorialUser, satellitePosition);
equatorialUserObservation2 = sgt.UserObservation(equatorialUser, satellitePosition2);

%% Test 1 - obj.getGeometryMatrix - single observation
try
    test1 = equatorialUserObservation.getGeometryMatrix;
catch
    testResults(1) = 1;
end

%% Test 2 - obj.getGeometryMatrix - multiple observations
try
    test2 = equatorialUserObservation2.getGeometryMatrix;
catch
    testResults(2) = 1;
end

%% Test 3 - obj.getGDOP - single observation
try
    test3 = equatorialUserObservation.getGDOP;
catch
    testResults(3) = 1;
end

%% Test 4 - obj.getGDOP - multiple observations
try
    test4 = equatorialUserObservation2.getGDOP;
catch
    testResults(4) = 1;
end

%% Test 5 - obj.getPDOP - single observation
try
    test5 = equatorialUserObservation.getPDOP;
catch
    testResults(5) = 1;
end

%% Test 6 - obj.getPDOP - multiple observations
try
    test6 = equatorialUserObservation2.getPDOP;
catch
    testResults(6) = 1;
end

%% Test 7 - obj.getTDOP - single observation
try
    test7 = equatorialUserObservation.getTDOP;
catch
    testResults(7) = 1;
end

%% Test 8 - obj.getTDOP - multiple observations
try
    test8 = equatorialUserObservation2.getTDOP;
catch
    testResults(8) = 1;
end

%% Test 9 - obj.getHDOP - single observation
try
    test9 = equatorialUserObservation.getHDOP;
catch
    testResults(9) = 1;
end

%% Test 10 - obj.getHDOP - multiple observations
try
    test10 = equatorialUserObservation2.getHDOP;
catch
    testResults(10) = 1;
end

%% Test 11 - obj.getVDOP - single observation
try
    test11 = equatorialUserObservation.getVDOP;
catch
    testResults(11) = 1;
end

%% Test 12 - obj.getVDOP - multiple observations
try
    test12 = equatorialUserObservation2.getVDOP;
catch
    testResults(12) = 1;
end

%% Test 13 - obj.plotSkyPlot -  single observation
try
   equatorialUserObservation.plotSkyPlot;
catch
    testResults(13) = 1;
end

%% Test 14 - obj.plotSkyPlot - multiple observations
try
   equatorialUserObservation2.plotSkyPlot;
catch
    testResults(14) = 1;
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






