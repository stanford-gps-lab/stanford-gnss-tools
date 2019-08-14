function testPlotOrbit()
fprintf('Testing sgt.Satellite.plotOrbit: ')

testResults = [];
%% Define test parameters
satellites = sgt.Satellite.fromYuma('current.alm');
polygonFile = 'usrconus.dat';
users = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);
time = 0;

%% Test 1 - Test a basic orbit plot
try
    satellites.plotOrbit
catch
    testResults(1) = 1;
end

%% Test 2 - Test an orbit plot with a UserGrid varargin
try
    satellites.plotOrbit(time, 'UserGrid', users)
catch
    testResults(2) = 1;
end

%% Test 3 - Plot an orbit plot with UserGrid and polygon
try
    satellites.plotOrbit(time, 'UserGrid', users, 'PolygonFile', polygonFile)
catch
    testResults(3) = 1;
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