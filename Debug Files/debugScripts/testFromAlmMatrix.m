function testFromAlmMatrix()
disp('-----------------')
disp('Testing fromAlmMatrix.m')
disp('-----------------')

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
    
    disp('test1 passed')
catch
    disp('*****test1 failed*****')
end

%% Test 2 - test varargin
try
    test2 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', 'Galileo');
    
    if strcmp(test2.Constellation, 'Galileo')
        disp('test2 passed')
    else
        disp('*****test2 failed*****')
    end
catch
    disp('*****test2 failed*****')
end

%% Test 3 - test multiple satellites with no varargin
try
    test3 = sgt.Satellite.fromAlmMatrix(alm2);
    
    disp('test3 passed')
catch
    disp('*****test3 failed*****')
end

%% Test 4 - test multiple satellites with one varargin
try
    test4 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', 'BDS');
    
    if (strcmp(test4(1).Constellation, 'BDS')) && (strcmp(test4(2).Constellation, 'BDS'))
        disp('test4 passed')
    else
        disp('*****test4 failed*****')
    end
catch
    disp('*****test4 failed*****')
end

%% Test 5 - test multiple satellites with multiple varargin
try
    test5 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo'});
    
    if (strcmp(test5(1).Constellation, 'BDS')) && (strcmp(test5(2).Constellation, 'Galileo'))
        disp('test5 passed')
    else
        disp('*****test5 failed*****')
    end
catch
    disp('*****test5 failed*****')
end

%% Test 6 - test one satellite with multiple varargin
try
    test6 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', {'BDS', 'Galileo'});
    
    disp('*****test6 failed*****')
catch
    disp('test6 passed')
end

%% Test 7 - test multiple satellite with wrong # of varargin
try
    test7 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo', 'Galileo'});
    
    disp('*****test7 failed*****')
catch
    disp('test7 passed')
end

%% Test 8 - variant of test 7
try
    test8 = sgt.Satellite.fromAlmMatrix(alm3, 'Constellation', {'BDS', 'Galileo'});
    
    disp('*****test8 failed*****')
catch
    disp('test8 passed')
end




















