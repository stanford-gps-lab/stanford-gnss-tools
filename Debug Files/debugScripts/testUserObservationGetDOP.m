function testUserObservationGetDOP()
disp('Testing sgt.UserObservation.getDOP...')

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
polarUserObservation = sgt.UserObservation(polarUser, satellitePosition);

%% Test 1 - get GDOP
try
    test1 = equatorialUserObservation.GDOP;
catch
    testResults(1) = 1;
end

%% Test 2 - get PDOP
try
    test2 = equatorialUserObservation.PDOP;
catch
    testResults(2) = 1;
end

%% Test 3 - get TDOP
try
    test3 = equatorialUserObservation.TDOP;
catch
    testResults(3) = 1;
end

%% Test 4 - get HDOP
try
    test4 = equatorialUserObservation.HDOP;
catch
    testResults(4) = 1;
end

%% Test 5 - get VDOP
try
    test5 = equatorialUserObservation.VDOP;
catch
    testResults(5) = 1;
end

%% Test 6 - multiple observations
try
    test6 = [equatorialUserObservation2.HDOP]';
    
catch
    testResults(6) = 1;
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






