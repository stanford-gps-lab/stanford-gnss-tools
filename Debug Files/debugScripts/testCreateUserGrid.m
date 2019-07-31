function testCreateUserGrid()

testResults = [];
%% Define parameters here
polygonFile = 'usrconus.dat';
latStep = 10;
lonStep = 10;
numUsers = 100;

%% Test 1 - Create user grid with polygon and gridstep
try
    test1 = sgt.UserGrid.createUserGrid('PolygonFile', polygonFile, 'GridStep', [latStep, lonStep]);
    
    if test1.Users(end).ID ~= 32
        testResults(1) = 1;
    end
catch
    testResults(1) = 1;
end

%% Test 2 - Create user grid with NumUsers
try
    test2 = sgt.UserGrid.createUserGrid('NumUsers', numUsers);
    
catch
    testResults(2) = 1;
end

%% Test 3 - Create user grid with NumUsers and GridBoundary
try
    test3 = sgt.UserGrid.createUserGrid('NumUsers', numUsers, 'GridBoundary', [-90, 90, 0, 360]);
    
catch
    testResults(3) = 1;
end

%% Test 4 - Create user grid with NumUsers and Polygon

%% Test 5 - Create user grid with GridStep

%% Test 6 - Create user grid with GridStep and GridBoundary

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing createUserGrid.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end