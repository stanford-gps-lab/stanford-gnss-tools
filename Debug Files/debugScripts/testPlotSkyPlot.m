function testPlotSkyPlot()
% clear; close all; clc;

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);
satellites = sgt.Satellite.fromYuma('current.alm');
% satellites = satellites([1:4]);
time = 0;
time2 = 0:100:10000;

%% Test 1 - Basic test of plotting a skyplot
try
   equatorialUser.plotSkyPlot(satellites, time);
catch
    testResults(1) = 1;
end

%% Test 2 - Test over multiple points in time
try
   polarUser.plotSkyPlot(satellites, time2);
catch
    testResults(2) = 1;
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