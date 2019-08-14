function testUserGrid()
fprintf('Testing sgt.UserGrid: ')

testResults = [];
%% Define parameters here
userPosition = [37.427127, -122.173243, 17];
userPosition2 = [37.427127, -122.173243, 17;...
    37.427127, 122.173243, 17];
polygonFile = 'usrconus.dat';

%% Test 1 - Define a UserGrid with a single user
try
    test1 = sgt.UserGrid(userPosition);
    
catch
    testResults(1) = 1;
end

%% Test 2 - Define a UserGrid with multiple users
try
    test2 = sgt.UserGrid(userPosition2);
    
    if (test2.Users(end).ID ~= 2)
        testResults(2) = 1;
    end
catch
    testResults(2) = 1;
end

%% Test 3 - Input a GridName
try
    test3 = sgt.UserGrid(userPosition, 'GridName', 'MyGrid');
    
    if (~strcmp(test3.GridName ,'MyGrid'))
       testResults(3) = 1; 
    end    
catch
    testResults(3) = 1;
end

%% Test 4 - Input a polygon file
try
    test4 = sgt.UserGrid(userPosition, 'PolygonFile', polygonFile);
    
    
    if ~test4.Users.InBound
        testResults(4) = 1;
    end
    
catch
    testResults(4) = 1;
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





