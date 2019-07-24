function testSatellite()
disp('-----------------')
disp('Testing Satellite.m')
disp('-----------------')

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
    disp('test1 passed')
catch
    disp('test1 failed')
end

%% Test 2 - test varargin Constellation
try
    test2 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Constellation', 'Galileo');
    
    if strcmp(test2.Constellation, 'Galileo')
        disp('test2 passed')
    else
        disp('test2 failed')
    end
    
catch
    disp('test2 failed')
end

%% Test 3 - test bad varargin Constellation
try
    test3 = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
        meanAnomaly, af0, af1, 'Constellation', {'GPS', 'Galileo'});
    
    disp('test3 failed')
    
catch
    disp('test3 passed')
end

%% Test 4 - test multiple satellites with one varargin Constellation
try
    test4 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', 'Galileo');
    
    if (numel(test4) == 2) && (strcmp(test4(1).Constellation, 'Galileo')) &&...
            (strcmp(test4(2).Constellation, 'Galileo'))
        disp('test4 passed')
    else
        disp('test4 failed')
    end
    
catch
    disp('test4 failed')
end

%% Test 5 - test multiple satellites with same number of varargin Constellation
try
    test5 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS'});
    
    if (numel(test5) == 2) && (strcmp(test5(1).Constellation, 'Galileo')) &&...
            (strcmp(test5(2).Constellation, 'BDS'))
        disp('test5 passed')
    else
        disp('test5 failed')
    end
catch
    disp('test5 failed')
end

%% Test 6 - test multiple satellites with wrong number of varargin Constellation
try
    test6 = sgt.Satellite(prn*ones(2,1), eccentricity*ones(2,1), toa*ones(2,1),...
        inclination*ones(2,1), rora*ones(2,1), sqrta*ones(2,1), raan*ones(2,1),...
        argumentOfPerigee*ones(2,1), meanAnomaly*ones(2,1), af0*ones(2,1), af1*ones(2,1),...
        'Constellation', {'Galileo', 'BDS', 'GLONASS'});
    
    disp('test6 failed')
    
catch
    disp('test6 passed')
end










