function testPlotOrbits()

testResults = [];
%% Define test parameters
satellites = sgt.Satellite.fromYuma('current.alm');

%% Test 1 - Test a basic orbit plot
% try
    satellites.plotOrbit
% catch
%     
% end


%% Test 2 - Test an orbit plot with a UserGrid varargin

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing sgt.Satellite.plotOrbits.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end