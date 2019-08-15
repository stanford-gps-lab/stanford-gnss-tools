function testSatellite()
fprintf('Testing sgt.Satellite: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define test parameters
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

polygonFile = 'usrconus.dat';
users = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);
time = 0;
%% Test 1 - Constructor - single satellite
try
    test1 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1);
catch
    testResults(1) = 1;
end

%% Test 2 - Constructor - test varargin Constellation
try
    test2 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Constellation', 'Galileo');
    
    if strcmp(test2.Constellation, 'Galileo')
        
    else
        testResults(2) = 1;
    end
catch
    testResults(2) = 1;
end

%% Test 3 - Constructor - test bad varargin Constellation
try
    test3 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Constellation', {'GPS', 'Galileo'});
    
    testResults(3) = 1;
catch
    
end

%% Test 4 - Constructor - test multiple satellites with one varargin Constellation
try
    test4 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', 'Galileo');
    
    if (numel(test4) == 2) && (strcmp(test4(1).Constellation, 'Galileo')) &&...
            (strcmp(test4(2).Constellation, 'Galileo'))
        
    else
        testResults(4) = 1;
    end
catch
    
end

%% Test 5 - Constructor - test multiple satellites with same number of varargin Constellation
try
    test5 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS'});
    
    if (numel(test5) == 2) && (strcmp(test5(1).Constellation, 'Galileo')) &&...
            (strcmp(test5(2).Constellation, 'BDS'))
        
    else
        testResults(5) = 1;
    end
catch
    
end

%% Test 6 - Constructor - test multiple satellites with wrong number of varargin Constellation
try
    test6 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS', 'GLONASS'});
    
    testResults(6) = 1;
catch
    
end

%% Test 7 - obj.fromAlmMatrix - basic
try
    test7 = sgt.Satellite.fromAlmMatrix(alm);
    
catch
    testResults(7) = 1;
end

%% Test 8 - obj.fromAlmMatrix - test varargin
try
    test8 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', 'Galileo');
    
    if strcmp(test8.Constellation, 'Galileo')
        
    else
        testResults(8) = 1;
    end
catch
    testResults(8) = 1;
end

%% Test 9 - obj.fromAlmMatrix - test multiple satellites with no varargin
try
    test9 = sgt.Satellite.fromAlmMatrix(alm2);
    
catch
    testResults(9) = 1;
end

%% Test 10 - obj.fromAlmMatrix - test multiple satellites with one varargin
try
    test10 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', 'BDS');
    
    if (strcmp(test10(1).Constellation, 'BDS')) && (strcmp(test10(2).Constellation, 'BDS'))
        
    else
        testResults(10) = 1;
    end
catch
    testResults(10) = 1;
end

%% Test 11 - obj.fromAlmMatrix - test multiple satellites with multiple varargin
try
    test11 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo'});
    
    if (strcmp(test11(1).Constellation, 'BDS')) && (strcmp(test11(2).Constellation, 'Galileo'))
        
    else
        testResults(11) = 1;
    end
catch
    testResults(11) = 1;
end

%% Test 12 - obj.fromAlmMatrix - test one satellite with multiple varargin
try
    test12 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', {'BDS', 'Galileo'});
    
    testResults(12) = 1;
catch
    
end

%% Test 13 - obj.fromAlmMatrix - test multiple satellite with wrong # of varargin
try
    test13 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo', 'Galileo'});
    
    testResults(13) = 1;
catch
    
end

%% Test 14 - obj.fromAlmMatrix - variant of test 14
try
    test14 = sgt.Satellite.fromAlmMatrix(alm3, 'Constellation', {'BDS', 'Galileo'});
    
    testResults(14) = 1;
catch
    
end

%% Test 15 - obj.fromYuma - basic
try
    test15 = sgt.Satellite.fromYuma('current.alm');
catch
    testResults(15) = 1;
end

%% Test 16 - obj.fromYuma - Incomplete Almanac
try
    test16 = sgt.Satellite.fromYuma('badCurrent.alm');
    
    testResults(16) = 1;
catch
    
end

%% Test 17 - obj.getPosition - basic
try
    satellite = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta,...
        raan, argumentOfPerigee, meanAnomaly, af0, af1);
    
    test17 = satellite.getPosition(time, 'ECEF');
catch
    testResults(1) = 17;
end

%% Test 18 - obj.plotOrbit - Test a basic orbit plot
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit
catch
    testResults(18) = 1;
end

%% Test 19 - obj.plotOrbit - Test an orbit plot with a UserGrid varargin
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit(time, 'UserGrid', users)
catch
    testResults(19) = 1;
end

%% Test 20 - obj.plotOrbit - Plot an orbit plot with UserGrid and polygon
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit(time, 'UserGrid', users, 'PolygonFile', polygonFile)
catch
    testResults(20) = 1;
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

close all;










