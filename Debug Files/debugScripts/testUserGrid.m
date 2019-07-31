function testUserGrid()

testResults = [];
%% Define parameters here
userPosition = [37.427127, -122.173243, 17];
polygonFile = 'usrconus.dat';

%% Test 1 - Define a UserGrid with a single user
try
    test1 = sgt.UserGrid(userPosition);
catch
    testResults(1) = 1;
end

%% Test 2 - Define a UserGrid with multiple users

%% Test 3 - Input a GridName

%% Test 4 - Input a polygon file
try
    test4 = sgt.UserGrid(userPosition, 'PolygonFile', polygonFile);
    
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





