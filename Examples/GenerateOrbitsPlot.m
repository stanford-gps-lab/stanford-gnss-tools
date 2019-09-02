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
time = 1200;     % [s]

%% Build Satellite Constellation
satellite = sgt.Satellite.fromYuma(almanac);

%% Plot Orbits
satellite.plotOrbit;
set(gca,'Color','k')