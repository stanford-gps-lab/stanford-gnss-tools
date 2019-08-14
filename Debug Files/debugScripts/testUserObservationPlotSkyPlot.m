function testUserObservationPlotSkyPlot()
fprintf('Testing sgt.UserObservation.plotSkyPlot: ')

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);
satellites = sgt.Satellite.fromYuma('current.alm');
time = 0;
time2 = 0:100:200;

satellitePosition = satellites.getPosition(time);
satellitePosition2 = satellites.getPosition(time2);

equatorialUserObservation = sgt.UserObservation(equatorialUser, satellitePosition);
polarUserObservation2 = sgt.UserObservation(polarUser, satellitePosition2);
%% Test 1 - Basic test of plotting a skyplot
try
   equatorialUserObservation.plotSkyPlot;
catch
    testResults(1) = 1;
end

%% Test 2 - Test over multiple points in time
try
   polarUserObservation2.plotSkyPlot;
catch
    testResults(2) = 1;
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