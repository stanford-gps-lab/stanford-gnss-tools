%testSatellite constructor
clear; close all; clc;

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

% %% Test basic
% testBasic = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
%     meanAnomaly, af0, af1);

% %% Test varargin
% testVarargin = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
%     meanAnomaly, af0, af1, 'Constellation', 'Galileo');

%% Test bad varargin
testBadVarargin = sgt.Satellite(prn, eccentricity, toa, inclination, rora, sqrta, raan, argumentOfPerigee,...
    meanAnomaly, af0, af1, 'Constellation', {'GPS', 'Galileo'})