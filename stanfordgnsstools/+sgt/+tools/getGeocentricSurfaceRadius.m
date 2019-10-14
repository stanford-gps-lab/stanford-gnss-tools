function reSe = getGeocentricSurfaceRadius(latb)
% This function gets the geocentric radius at the surface of the earth
% according to equation 2.137 in Groves 2nd edition. lat is the geodetic
% latitude input in [deg].

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

reSe = getRE(latb)*sqrt((cos(latb*pi/180)^2) + ((1 - sgt.constants.EarthConstants.e2)^2)*(sin(latb*pi/180)^2));
end

function RE = getRE(lat)
% This function gets the transverse radius of curviture as it relates to
% the geodetic latitude. (Not sure if its geocentric or geodetic). lat is 
% input in degrees. Eq 2.106 in Groves 2nd edition
RE = sgt.constants.EarthConstants.R/sqrt(1 - sgt.constants.EarthConstants.e2*(sin(lat*pi/180)^2));
end