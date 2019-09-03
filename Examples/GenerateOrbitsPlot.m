% This template gives an example of how to build a number of users and
% satellites in sgt. This scipt gives an introduction into how these
% building blocks work together.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools
clear; close all; clc;

%% Set Parameters
almanac = 'current.alm';    % Yuma File
time = 0;     % [s]
posLLH = [0 0 0];
userGrid = sgt.UserGrid(posLLH);

% %% Test
% % alm = [1, 0.8, 0, 30*pi/180, 0, sqrt(8e6), 50*pi/180, 20*pi/180, 30*pi/180, 0, 0];
% satellite = sgt.Satellite.fromYuma(almanac);
% satellite = satellite(1);
% satPos = satellite.getPosition(time, 'ECI');
% satPos.ECI

%% Build Satellite Constellation
satellite = sgt.Satellite.fromYuma(almanac);

%% Plot Orbits
satellite.plotOrbit(time, 'UserGrid', userGrid, 'LOS', true);
% set(gca,'Color','k')

% time2 = 86400/2;
% satellite.plotOrbit(time2, 'UserGrid', userGrid);