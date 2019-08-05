function testPlotSkyPlot()

testResults = [];
%% Define test parameters
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
equatorialUser = userGrid.Users(42);
polarUser = userGrid.Users(end);


%% Test 1 - Basic test of plotting a skyplot

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing Satellite.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end