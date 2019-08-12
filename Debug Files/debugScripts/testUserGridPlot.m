function testUserGridPlot()
disp('Testing sgt.UserGrid.plot...')

testResults = [];
%% Define parameters here
polygonFile = 'usrconus.dat';
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
userGrid2 = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);

%% Test 1 - plot 2D UserGrid
try
    userGrid.plot;
    
catch
    testResults(1) = 1;
end

%% Test 2 - plot 2D UserGrid with polygon
try
    userGrid2.plot('Polygonfile', polygonFile);
    
catch
    testResults(2) = 1;
end

%% Test 3 - plot 3D UserGrid on globe
try
    userGrid.plot('Globe3D', true)
    
catch
    testResults(3) = 1;
end

%% Test 4 - plot 3D UserGrid on globe with polygon
try
    userGrid2.plot('Globe3D', true, 'PolygonFile', polygonFile);
    
catch
    testResults(4) = 1;
end

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing UserGrid.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end

close all;