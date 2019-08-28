function [] = calculateObservationData(obj)
% calculateObservationData  compute all of the properties that depend on
% the user and the satellite positions.  This includes the following:
%   - LOS in ECEF and ENU coordinates
%   - list of the satellites in view and number of satellites in view
%   - the elevation and azimuth angles of the satellites in view
%   - the range measurements to the satellites in view

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

%
% Setup
%

% get the number of satellites and their positions
[S, ~] = size(obj.SatellitePosition);
satellitePosition = [obj.SatellitePosition.ECEF];

%
% calculate the ECEF LOS
%

% compute the range to the sallites
losecef = satellitePosition - repmat(obj.User.PositionECEF, 1, S);

% normalize by magnitude
r = vecnorm(losecef);
losecef = losecef ./ repmat(r, 3, 1);
obj.LOSecef = losecef';

%
% calculate the ENU LOS
%
losenu = obj.User.ECEF2ENU * losecef;
obj.LOSenu = losenu';

%
% determine the satellites in view
%
u = losenu(3,:);
svInView = (u >= sin(obj.User.ElevationMask));
obj.SatellitesInViewMask  = svInView';
obj.NumSatellitesInView = sum(svInView);

%
% compute elevation angles to the satellites in view
%
obj.ElevationAngles = asin(losenu(3,:)');

%
% compute the azimuth angles to the satellites in view
%
obj.AzimuthAngles = atan2(losenu(1,:)', losenu(2,:)');

%
% compute the range to the satellites in view
%
obj.Range = r';