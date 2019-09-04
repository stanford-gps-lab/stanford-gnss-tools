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
posLLH = [37.427127, -122.173243, 17];  % [deg deg m] Stanford GPS Lab location
almanac = 'forGNSS2019.alm';    % Yuma File
time = 327720;     % [s]

%% Build User Grid
user = sgt.User(posLLH);

%% Build Satellite Constellation
satellite = sgt.Satellite.fromYuma(almanac);

%% Calculate Satellite Positions
satellitePosition = satellite.getPosition(time);

%% Calculate User Observations
userObservation = sgt.UserObservation(user, satellitePosition);

%% Plot Orbits with User Position
satellite.plotOrbit(time, 'User', user, 'LOS', true)