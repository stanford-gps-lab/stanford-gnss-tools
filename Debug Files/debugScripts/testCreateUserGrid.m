function testCreateUserGrid()

testResults = [];
%% Define parameters here
polygonFile = 'usrconus.dat';
gridBoundary = [-90, 90, 0, 360];
gridBoundary2 = [-45, 45, 90, 270];
gridStep = 10;
latStep = 10;
lonStep = 10;
numUsers = 100;
llhFile = 'myLLHFile.userLocation';

%% Test 1 - Create user grid with polygonfile and gridstep
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
    test3 = sgt.UserGrid.createUserGrid('NumUsers', numUsers, 'GridBoundary', gridBoundary);
    
catch
    testResults(3) = 1;
end

%% Test 4 - Create user grid with NumUsers and PolygonFile
try
    test4 = sgt.UserGrid.createUserGrid('NumUsers', numUsers, 'PolygonFile', polygonFile);
    
catch
    testResults(4) = 1;
end

%% Test 5 - Create user grid with GridStep
try
    test5 = sgt.UserGrid.createUserGrid('GridStep', gridStep);
    
catch
    testResults(5) = 1;
end

%% Test 6 - Create user grid with GridStep and GridBoundary
try
    test6 = sgt.UserGrid.createUserGrid('GridStep', gridStep, 'GridBoundary', gridBoundary2);
    
catch
    testResults(6) = 1;
end

%% Test 7 - Create user grid from LLHFile
try
    test7 = sgt.UserGrid.createUserGrid('LLHFile', llhFile);
    
catch
    testResults(7) = 1;
end

%% Test 8 - Create user grid from LLHFile and include a PolygonFile
try
    test8 = sgt.UserGrid.createUserGrid('LLHFile', llhFile, 'PolygonFile', polygonFile);
    
catch
   testResults(8) = 1; 
end

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