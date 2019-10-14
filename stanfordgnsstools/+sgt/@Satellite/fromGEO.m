function obj = fromGEO(prn, longitude, af0, af1, constellation)
% fromGEO(prn, longitude) creates a satellite object of a geostationary
% satellite with a given prn, longitude [deg], clock bias (s), clock drift (s/s), and constellation.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

numObj = length(prn);

% Create satellite object
obj = sgt.Satellite(prn, zeros(numObj,1), zeros(numObj,1), zeros(numObj,1),...
    zeros(numObj,1), sqrt(42164e3)*ones(numObj,1), zeros(numObj,1), zeros(numObj,1),...
    longitude.*pi/180, af0, af1, 'Constellation', constellation);




