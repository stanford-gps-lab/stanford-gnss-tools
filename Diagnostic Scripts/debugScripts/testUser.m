function testUser()
fprintf('Testing sgt.User: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define test parameters
userPosition = [37.427127, -122.173243, 17];
userPosition2 = repmat(userPosition, [2, 1]);
userPosition3 = [37.427127, -122.173243, 17;...
    37.427127, 122.173243, 17];
userPosition4 = [userPosition; userPosition3];

polygonFile = 'usrconus.dat';
myElevationMask = 15*pi/180;
myElevationMask2 = [15; 20].*pi/180;

%% Test 1 - Constructor -  basic
try
    test1 = sgt.User(userPosition);
    
    if sum(abs(test1.PositionECEF - sgt.tools.llh2ecef(userPosition)') < 10) == 3
        
    else
        testResults(1) = 1;
    end
catch
    testResults(1) = 1;
end

%% Test 2 - Constructor - vector of userPosition
try
    test2 = sgt.User(userPosition2);
    
catch
    testResults(2) = 1;
end

%% Test 3 - Constructor - test single user with single ID
try
    test3 = sgt.User(userPosition, 'ID', 1);
    
catch
    testResults(3) = 1;
end

%% Test 4 - Constructor - test multiple users with same number of IDs
try
    test4 = sgt.User(userPosition2, 'ID', [1 2]);
    
catch
    testResults(4) = 1;
end

%% Test 5 - Constructor - test single user with polygon
try
    test5 = sgt.User(userPosition, 'PolygonFile', polygonFile);
    
    if test5.InBound
        
    else
        testResults(5) = 1;
    end
catch
    testResults(5) = 1;
end

%% Test 6 - Constructor - test multiple users with polygon
try
    test6 = sgt.User(userPosition3, 'PolygonFile', polygonFile);
    
    if test6(1).InBound && ~test6(2).InBound
        
    else
        testResults(6) = 1;
    end
catch
    testResults(6) = 1;
end

%% Test 7 - Constructor - test single user with single elevation
try
    test7 = sgt.User(userPosition, 'ElevationMask', myElevationMask);
    
    if test7.ElevationMask == myElevationMask
        
    else
        testResults(7) = 1;
    end
catch
    testResults(7) = 1;
end

%% Test 8 - Constructor - test multiple users with single elevation
try
    test8 = sgt.User(userPosition2, 'ElevationMask', myElevationMask);
    
    if (test8(1).ElevationMask == myElevationMask) && (test8(2).ElevationMask == myElevationMask)
        
    else
        testResults(8) = 1;
    end
catch
    testResults(8) = 1;
end

%% Test 9 - Constructor - test multiple users with same number of elevations
try
    test9 = sgt.User(userPosition2, 'ElevationMask', myElevationMask2);
    
    if (test9(1).ElevationMask == myElevationMask2(1)) && (test9(2).ElevationMask == myElevationMask2(2))
        
    else
        testResults(9) = 1;
    end
catch
    testResults(9) = 1;
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












