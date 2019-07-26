function testUser()
clear; close all; clc;
disp('-----------------')
disp('Testing User.m')
disp('-----------------')

%% Define test parameters
userPosition = [37.427127, -122.173243, 17];
userPosition2 = repmat(userPosition, [2, 1]);

%% Test 1 - basic
try
    test1 = sgt.User(userPosition);
    
    if sum(abs(test1.PositionECEF - lla2ecef(userPosition)') < 10) == 3
        disp('test1 passed')
    else
        disp('*****test1 failed*****')
    end
catch
    disp('*****test1 failed*****')
end

%% Test 2 - flipped userPostion
try
    test2 = sgt.User(userPosition');
    
    disp('*****test2 failed*****')
catch
    disp('test2 passed')
end

%% Test 3 - separated position
try
    test3 = sgt.User(userPosition(1), userPosition(2), userPosition(3));
    
    disp('*****test3 failed*****')
catch
    disp('test3 passed')
end

%% Test 4 - vector of userPosition
try
    test4 = sgt.User(userPosition2);
    
    disp('test4 passed')
catch
    disp('*****test4 failed*****')
end

%% Test 5 - test single user with single ID
try
    test5 = sgt.User(userPosition, 'ID', 1);
    
    disp('test5 passed')
catch
    disp('*****test5 failed*****')
end

%% Test 6 - test single user with multiple IDs
try
    test6 = sgt.User(userPosition, 'ID', [1, 2]);
    
    disp('*****test6 failed*****')
catch
    disp('test6 passed')
end

%% Test 7 - test multiple users with same number of IDs
try
    test7 = sgt.User(userPosition2, 'ID', [1 2]);
    
    disp('test7 passed')
catch
    disp('*****test7 failed*****')
end

%% Test 8 - test multiple users with wrong number of IDs
try
    test8 = sgt.User(userPosition2, 'ID', [1 2 3]);
    
    disp('*****test8 failed*****')
catch
    disp('test8 passed')
end

%% Test 9 - test multiple users with single ID
try
    test9 = sgt.User(userPosition2, 'ID', 1);
    
    disp('*****test9 failed*****')
catch
    disp('test9 passed')
end

%% Test 10 - test single user with polygon

%% Test 11 - test multiple users with polygon

%% Test 12 - test single user with bad polygon

%% Test 13 - test single user with single elevation

%% Test 14 - test multiple users with single elevation

%% Test 15 - test single user with multiple elevations

%% Test 16 - test multiple users with same number of elevations

%% Test 17 - test multiple users with wrong number of elevations













