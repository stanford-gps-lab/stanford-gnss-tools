function testPlotSkyPlot()

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);
satellites = sgt.Satellite.fromYuma('current.alm');
time = 0;

%% Test 1 - Basic test of plotting a skyplot
try
   equatorialUser.plotSkyPlot(satellites, time);
catch
    testResults(1) = 1;
end

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing sgt.User.plotSkyPlot.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end

close all;