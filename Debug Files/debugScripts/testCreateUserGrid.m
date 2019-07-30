function testCreateUserGrid()

testResults = [];
%% Define parameters here
polyfile = 'usrconus.dat';
latStep = 10;
lonStep = 10;

%% Test 1 - basic call of the method
try
    test1 = sgt.User.createUserGrid(polyfile, latStep, lonStep);
    
    if test1(end).ID ~= 32
        testResults(1) = 1;
    end
    
catch
    testResults(1) = 1;
end

%% Test 2 - Create user grid without polyfile or lat/lon
try
    test2 = sgt.User.createUserGrid(100);
catch
    testResults(2) = 1;
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