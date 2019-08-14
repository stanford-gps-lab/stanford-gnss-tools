function testSatelliteFromYuma()
fprintf('Testing sgt.Satellite.fromYuma: ')

testResults = [];
%% Test 1 - basic
try
    test1 = sgt.Satellite.fromYuma('current.alm');
    
catch
    testResults(1) = 1;
end

%% Test 2 - Incomplete Almanac
try
    test2 = sgt.Satellite.fromYuma('badCurrent.alm');
    
    testResults(2) = 1;
catch
    
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



