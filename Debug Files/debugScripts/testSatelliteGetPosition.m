% testSatelliteGetPositition
% Test script for the satellite get position function
clear; close all; clc

%% Define a satellite
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

%% Get the position of the satellite
time = 496800;
satellitePosition = satellite.getPosition(time, 'ECEF')

%% Check position of the satellite
refPos =  [-1.925132225718e+007  5.287213508708e+006  1.758197241879e+007]







