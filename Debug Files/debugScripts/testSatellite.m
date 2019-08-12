function testSatellite()
disp('Testing sgt.Satellite...')

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

%% Test 1 - test basic
try
    test1 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1);
    
catch
    testResults(1) = 1;
end

%% Test 2 - test varargin Constellation
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

%% Test 3 - test bad varargin Constellation
try
    test3 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Constellation', {'GPS', 'Galileo'});
    
    testResults(3) = 1;
catch
    
end

%% Test 4 - test multiple satellites with one varargin Constellation
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

%% Test 5 - test multiple satellites with same number of varargin Constellation
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

%% Test 6 - test multiple satellites with wrong number of varargin Constellation
try
    test6 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS', 'GLONASS'});
    
    testResults(6) = 1;
catch

end

%% Display test results
if any(testResults)
    disp('-----------------')
    disp('Testing Satellite.m')
    disp('-----------------')
    
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
end










