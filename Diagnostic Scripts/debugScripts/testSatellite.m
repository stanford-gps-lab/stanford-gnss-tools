function testSatellite()
fprintf('Testing sgt.Satellite: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define test parameters
% Constructor
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

% obj.fromAlmMatrix
alm = [prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
    meanAnomaly, af0, af1];
alm2 = repmat(alm, [2,1]);

% Polygon
polygonFile = 'usrconus.dat';
users = sgt.UserGrid.createUserGrid('NumUsers', 100, 'PolygonFile', polygonFile);
time = 0;

% sgt.Config
config = sgt.Config;
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

%% Test 3 - Constructor - test multiple satellites with one varargin Constellation
try
    test3 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', 'Galileo');
    
    if (numel(test3) == 2) && (strcmp(test3(1).Constellation, 'Galileo')) &&...
            (strcmp(test3(2).Constellation, 'Galileo'))
        
    else
        testResults(3) = 1;
    end
catch
    testResults(3) = 1;
end

%% Test 4 - Constructor - test multiple satellites with same number of varargin Constellation
try
    test4 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS'});
    
    if (numel(test4) == 2) && (strcmp(test4(1).Constellation, 'Galileo')) &&...
            (strcmp(test4(2).Constellation, 'BDS'))
        
    else
        testResults(4) = 1;
    end
catch
    testResults(4) = 1;
end

%% Test 5 - obj.fromAlmMatrix - basic
try
    test5 = sgt.Satellite.fromAlmMatrix(alm);
    
catch
    testResults(5) = 1;
end

%% Test 6 - obj.fromAlmMatrix - test varargin
% try
    test6 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', 'Galileo');
    
    if strcmp(test6.Constellation, 'Galileo')
        
    else
        testResults(6) = 1;
    end
% catch
%     testResults(6) = 1;
% end

%% Test 7 - obj.fromAlmMatrix - test multiple satellites with no varargin
try
    test7 = sgt.Satellite.fromAlmMatrix(alm2);
    
catch
    testResults(7) = 1;
end

%% Test 8 - obj.fromAlmMatrix - test multiple satellites with one varargin
try
    test8 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', 'BDS');
    
    if (strcmp(test8(1).Constellation, 'BDS')) && (strcmp(test8(2).Constellation, 'BDS'))
        
    else
        testResults(8) = 1;
    end
catch
    testResults(8) = 1;
end

%% Test 9 - obj.fromAlmMatrix - test multiple satellites with multiple varargin
try
    test9 = sgt.Satellite.fromAlmMatrix(alm2, 'Constellation', {'BDS', 'Galileo'});
    
    if (strcmp(test9(1).Constellation, 'BDS')) && (strcmp(test9(2).Constellation, 'Galileo'))
        
    else
        testResults(9) = 1;
    end
catch
    testResults(9) = 1;
end

%% Test 10 - obj.fromYuma - basic
try
    test10 = sgt.Satellite.fromYuma('current.alm');
catch
    testResults(10) = 1;
end

%% Test 11 - obj.getPosition - basic
try
    satellite = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta,...
        raan, argumentOfPerigee, meanAnomaly, af0, af1);
    
    test11 = satellite.getPosition(time, 'ECEF');
catch
    testResults(11) = 1;
end

%% Test 12 - obj.plotOrbit - Test a basic orbit plot
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit
catch
    testResults(12) = 1;
end

%% Test 13 - obj.plotOrbit - Test an orbit plot with a UserGrid varargin
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit(time, 'UserGrid', users)
catch
    testResults(13) = 1;
end

%% Test 14 - obj.plotOrbit - Plot an orbit plot with UserGrid and polygon
try
    satellites = sgt.Satellite.fromYuma('current.alm');
    satellites.plotOrbit(time, 'UserGrid', users, 'PolygonFile', polygonFile)
catch
    testResults(14) = 1;
end

%% Test 15 - Constructor - Test single satellite with config
try
    test15 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Config', config);
    
    if (~iscell(config.Satellite)) || any((size(config.Satellite) ~= [11,2]))
        testResults(15) = 1;
    end
catch
    testResults(15) = 1;
end

%% Test 16 - Constructor - Test multiple satellites with config
try
    test16 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1),...
        af1*ones(2,1), 'Config', config);
    
    if (~iscell(config.Satellite)) || any((size(config.Satellite) ~= [11,2]))
        testResults(16) = 1;
    end
catch
    testResults(16) = 1;
end

%% Test 17 - obj.fromAlmMatrix - test single satellite with config
try
    test17 = sgt.Satellite.fromAlmMatrix(alm, 'Config', config);
    
    if (~iscell(config.Satellite)) %|| any((size(config.Satellite) ~= [11,2]))
        testResults(17) = 1;
    end
catch
    testResults(17) = 1;
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










