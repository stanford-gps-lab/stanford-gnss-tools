function testSaveUserGrid()
disp('Testing sgt.UserGrid.saveUserGrid...')

testResults = [];
%% Define test parameters
fileName = 'myFile';
filePath = [pwd, '\testDirectory'];
userGrid = sgt.UserGrid.createUserGrid('NumUsers', 100);

%% Test 1 - save a userGrid file
try
    userGrid.saveUserGrid(fileName);
    
catch
    testResults(1) = 1;
end

%% Test 2 - save a userGrid file to a specified path
try 
    userGrid.saveUserGrid(fileName, 'Path', filePath);
    
catch
    testResults(2) = 1;
end

%% Clean up after test
rmdir(filePath, 's')

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing sgt.UserGrid.saveUserGrid.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end