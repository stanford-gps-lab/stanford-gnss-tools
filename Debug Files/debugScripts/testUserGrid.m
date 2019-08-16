function testUserGrid()
fprintf('Testing sgt.UserGrid: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define parameters here
userPosition = [37.427127, -122.173243, 17];
userPosition2 = [37.427127, -122.173243, 17;...
    37.427127, 122.173243, 17];
polygonFile = 'usrconus.dat';

polygonFile = 'usrconus.dat';
gridBoundary = [-90, 90, 0, 360];
gridBoundary2 = [-45, 45, 90, 270];
gridStep = 10;
latStep = 10;
lonStep = 10;
numUsers = 100;
llhFile = 'myFile.userGrid';

fileName = 'myFile';
filePath = [pwd, '\testDirectory'];

%% Test 1 - Constructor - Define a UserGrid with a single user
try
    test1 = sgt.UserGrid(userPosition);
catch
    testResults(1) = 1;
end

%% Test 2 - Constructor - Define a UserGrid with multiple users
try
    test2 = sgt.UserGrid(userPosition2);
    
    if (test2.Users(end).ID ~= 2)
        testResults(2) = 1;
    end
catch
    testResults(2) = 1;
end

%% Test 3 - Constructor - Input a GridName
try
    test3 = sgt.UserGrid(userPosition, 'GridName', 'MyGrid');
    
    if (~strcmp(test3.GridName ,'MyGrid'))
        testResults(3) = 1;
    end
catch
    testResults(3) = 1;
end

%% Test 4 - Constructor - Input a polygon file
try
    test4 = sgt.UserGrid(userPosition, 'PolygonFile', polygonFile);
    
    
    if ~test4.Users.InBound
        testResults(4) = 1;
    end
catch
    testResults(4) = 1;
end

%% Test 5 - obj.createUserGrid - Create user grid with polygonfile and gridstep
try
    test5 = sgt.UserGrid.createUserGrid('PolygonFile', polygonFile, 'GridStep', [latStep, lonStep]);
    
    if test5.Users(end).ID ~= 32
        testResults(5) = 1;
    end
catch
    testResults(5) = 1;
end

%% Test 6 - obj.createUserGrid - Create user grid with NumUsers
try
    test6 = sgt.UserGrid.createUserGrid('NumUsers', numUsers);
catch
    testResults(6) = 1;
end

%% Test 7 - obj.createUserGrid - Create user grid with NumUsers and GridBoundary
try
    test7 = sgt.UserGrid.createUserGrid('NumUsers', numUsers, 'GridBoundary', gridBoundary);
catch
    testResults(7) = 1;
end

%% Test 8 - obj.createUserGrid - Create user grid with NumUsers and PolygonFile

try
    test8 = sgt.UserGrid.createUserGrid('NumUsers', numUsers, 'PolygonFile', polygonFile);
catch
    testResults(8) = 1;
end

%% Test 9 - obj.createUserGrid - Create user grid with GridStep
try
    test9 = sgt.UserGrid.createUserGrid('GridStep', gridStep);
catch
    testResults(9) = 1;
end

%% Test 10 - obj.createUserGrid - Create user grid with GridStep and GridBoundary
try
    test10 = sgt.UserGrid.createUserGrid('GridStep', gridStep, 'GridBoundary', gridBoundary2);
catch
    testResults(10) = 1;
end

%% Test 11 - obj.createUserGrid - Create user grid from LLHFile
try
    test11 = sgt.UserGrid.createUserGrid('LLHFile', llhFile);
catch
    testResults(11) = 1;
end

%% Test 12 - obj.createUserGrid - Create user grid from LLHFile and include a PolygonFile
try
    test12 = sgt.UserGrid.createUserGrid('LLHFile', llhFile, 'PolygonFile', polygonFile);
catch
    testResults(12) = 1;
end

%% Test 13 - obj.plot - plot 2D UserGrid
try
    userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
    userGrid.plot;
catch
    testResults(13) = 1;
end

%% Test 14 - obj.plot - plot 2D UserGrid with polygon
try
    userGrid2 = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);
    userGrid2.plot('Polygonfile', polygonFile);
catch
    testResults(14) = 1;
end

%% Test 15 - obj.plot - plot 3D UserGrid on globe
try
    userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
    userGrid.plot('Globe3D', true)
catch
    testResults(15) = 1;
end

%% Test 16 - obj.plot - plot 3D UserGrid on globe with polygon
try
    userGrid2 = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);
    userGrid2.plot('Globe3D', true, 'PolygonFile', polygonFile);
catch
    testResults(16) = 1;
end

%% Test 17 - obj.saveUserGrid - save a userGrid file
try
    userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
    userGrid.saveUserGrid(fileName);
catch
    testResults(17) = 1;
end

%% Test 18 - obj.saveUserGrid - save a userGrid file to a specified path
try
    userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);
    userGrid.saveUserGrid(fileName, 'Path', filePath);
catch
    testResults(18) = 1;
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

rmdir(filePath, 's')
close all;





