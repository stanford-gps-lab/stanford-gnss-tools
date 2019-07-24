% Test an almanac input
clear; close all; clc;

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

%% Test 1
test1 = sgt.Satellite.fromAlmMatrix(alm);

%% Test 2
test2 = sgt.Satellite.fromAlmMatrix(alm, 'Constellation', 'Galileo')


