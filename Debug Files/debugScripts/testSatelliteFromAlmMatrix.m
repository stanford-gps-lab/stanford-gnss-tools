function testSatelliteFromAlmMatrix()
fprintf('Testing sgt.Satellite.fromAlmMatrix: ')

testResults = [];
%% set almanac terms and test fromAlmMatrix.m
prn = 1;
eccentricity = 0.0091;
toa = 319488;
inclination = 0.9764;
rora = -7.7832e-9;
sqrta = 5.1536e3;
raan = 2.3016;
argumentOfPerigee = 0.7415;
meanAnomaly = 1.5358;
af0 = -7.6294e-5;
af1 = -1.0914e-11;

alm = [prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
    meanAnomaly, af0, af1];

alm2 = repmat(alm, [2,1]);

alm3 = repmat(alm, [3,1]);

%% Test 1 - basic
try
    test1 = sgt.Satellite.fromAlmMatrix(alm);
    
catch
    testResults(1) = 1;
end

%% Test 2 - test varargin
try
    test2 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', 'Galileo');
    
    if strcmp(test2.Constellation, 'Galileo')

    else
        testResults(2) = 1;
    end
catch
 testResults(2) = 1;
end

%% Test 3 - test multiple satellites with no varargin
try
    test3 = sgt.Satellite.fromAlmMatrix(alm2);
    
catch
     testResults(3) = 1;
end

%% Test 4 - test multiple satellites with one varargin
try
    test4 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', 'BDS');
    
    if (strcmp(test4(1).Constellation, 'BDS')) && (strcmp(test4(2).Constellation, 'BDS'))

    else
         testResults(4) = 1;
    end
catch
    testResults(4) = 1;
end

%% Test 5 - test multiple satellites with multiple varargin
try
    test5 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo'});
    
    if (strcmp(test5(1).Constellation, 'BDS')) && (strcmp(test5(2).Constellation, 'Galileo'))

    else
        testResults(5) = 1;
    end
catch
    testResults(5) = 1;
end

%% Test 6 - test one satellite with multiple varargin
try
    test6 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', {'BDS', 'Galileo'});
    
    testResults(6) = 1;
catch

end

%% Test 7 - test multiple satellite with wrong # of varargin
try
    test7 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo', 'Galileo'});
    
    testResults(7) = 1;
catch

end

%% Test 8 - variant of test 7
try
    test8 = sgt.Satellite.fromAlmMatrix(alm3, 'Constellation', {'BDS', 'Galileo'});
    
    testResults(8) = 1;
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


















