% function testPlotSkyPlot()
clear; close all; clc

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);
satellites = sgt.Satellite.fromYuma('current.alm');
time = 0;

tempSats = satellites;


%% Test 1 - Basic test of plotting a skyplot
% try
    tempSats.plotOrbit(time)
    
   equatorialUser.plotSkyPlot(tempSats, time);
   
   derp = tempSats.getPosition(time, 'ecef');
   herp = [derp(1:end).LLH];
   herp = herp(1:2,:)
% catch
%     testResults(1) = 1;
% end

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