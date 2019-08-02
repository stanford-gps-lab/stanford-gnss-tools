function testSatelliteGetPosition()

testResults = [];
%% Define test parameters
prn = 14;
eccentricity = 0.004552247002721;
toa = 504000;
inclination = 0.960744311428339;
rateOfRightAscension = -7.866756253402961e-9;
sqrta = 5.153494356155396e3;
raan = 0.738489569374794;
argumentOfPerigee = 2.885975350834545;
meanAnomaly = -0.889237036634749;
af0 = 1.832102425396442e-4;
af1 = 3.410605131648481e-13;
satellite = sgt.Satellite(prn, eccentricity, toa, inclination, rateOfRightAscension, sqrta, raan, argumentOfPerigee, meanAnomaly, af0, af1);

time = 496800;
refPos =  [-1.925132225718e+007  5.287213508708e+006  1.758197241879e+007];
%% Test 1 - basic
try
    test1 = satellite.getPosition(time, 'ECEF');
    
catch
    testResults(1) = 1;
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







