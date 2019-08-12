function testUser()
disp('Testing sgt.User...')

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

%% Test 1 - basic
try
    test1 = sgt.User(userPosition);
    
    if sum(abs(test1.PositionECEF - sgt.tools.llh2ecef(userPosition)') < 10) == 3

    else
        testResults(1) = 1;
    end
catch
    testResults(1) = 1;
end

%% Test 2 - flipped userPostion
try
    test2 = sgt.User(userPosition');
    
    testResults(2) = 1;
catch

end

%% Test 3 - separated position
try
    test3 = sgt.User(userPosition(1), userPosition(2), userPosition(3));
    
    testResults(3) = 1;
catch

end

%% Test 4 - vector of userPosition
try
    test4 = sgt.User(userPosition2);
    
catch
    testResults(4) = 1;
end

%% Test 5 - test single user with single ID
try
    test5 = sgt.User(userPosition, 'ID', 1);
    
catch
    testResults(5) = 1;
end

%% Test 6 - test single user with multiple IDs
try
    test6 = sgt.User(userPosition, 'ID', [1, 2]);
    
    testResults(6) = 1;
catch

end

%% Test 7 - test multiple users with same number of IDs
try
    test7 = sgt.User(userPosition2, 'ID', [1 2]);
    
catch
    testResults(7) = 1;
end

%% Test 8 - test multiple users with wrong number of IDs
try
    test8 = sgt.User(userPosition2, 'ID', [1 2 3]);
    
    testResults(8) = 1;
catch

end

%% Test 9 - test multiple users with single ID
try
    test9 = sgt.User(userPosition2, 'ID', 1);
    
    testResults(9) = 1;
catch

end

%% Test 10 - test single user with polygon
try
    test10 = sgt.User(userPosition, 'PolygonFile', polygonFile);
    
    if test10.InBound

    else
        testResults(10) = 1;
    end
catch
    testResults(10) = 1;
end

%% Test 11 - test multiple users with polygon
try
    test11 = sgt.User(userPosition3, 'PolygonFile', polygonFile);
    
    if test11(1).InBound && ~test11(2).InBound

    else
        testResults(11) = 1;
    end
catch
    testResults(11) = 1;
end

%% Test 12 - test single user with single elevation
try
    test12 = sgt.User(userPosition, 'ElevationMask', myElevationMask);
    
    if test12.ElevationMask == myElevationMask

    else
        testResults(12) = 1;
    end
catch
    testResults(12) = 1;
end

%% Test 13 - test multiple users with single elevation
try
    test13 = sgt.User(userPosition2, 'ElevationMask', myElevationMask);
    
    if (test13(1).ElevationMask == myElevationMask) && (test13(2).ElevationMask == myElevationMask)

    else
        testResults(13) = 1;
    end
catch
    testResults(13) = 1;
end

%% Test 14 - test single user with multiple elevations
try
    test14 = sgt.User(userPosition, 'ElevationMask', myElevationMask2);
    
    testResults(14) = 1;
catch

end

%% Test 15 - test multiple users with same number of elevations
try
    test15 = sgt.User(userPosition2, 'ElevationMask', myElevationMask2);
    
    if (test15(1).ElevationMask == myElevationMask2(1)) && (test15(2).ElevationMask == myElevationMask2(2))

    else
        testResults(15) = 1;
    end
catch
    testResults(15) = 1;
end

%% Test 16 - test multiple users with wrong number of elevations
try
    test16 = sgt.User(userPosition4, 'ElevationMask', myElevationMask2);
    
    testResults(16) = 1;
catch

end

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing User.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end












