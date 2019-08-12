function ipp = getIPP(obj)
% getIPP    get the ionospheric pierce points for the satellites in view
%
% returns an Sx2 matrix for S satellites in view for the given user

% NOTE: currently only works for a single observation (single user)
% TODO: get this to work on a set of observations at once

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% convert angles to radian
el = obj.ElevationAngles * pi/180;
az = obj.AzimuthAngles * pi/180;
uLat = obj.User.PositionLLH(1) * pi/180;
uLon = obj.User.PositionLLH(2) * pi/180;

% calculate the earth angle
Rearth = sgt.constants.EarthConstants.R;
Riono = sgt.constants.EarthConstants.Riono;
psiPP = 0.5 * pi - el - asin(Rearth * cos(el) / Riono);

% helper for readibility
sinPsiPP = sin(psiPP);

% calulate IPP latitude
ippLat = asin(sin(uLat).*cos(psiPP) + cos(uLat).*sinPsiPP.*cos(az)); % Svx1

%calulate IPP longitude
ippLon = uLon + asin(sinPsiPP.*sin(az) ./ cos(ippLat)); % Svx1

% fix IPPs that look across the poles
idx = find((ippLat > 70*pi/180 & tan(psiPP).*cos(az) > tan(pi/2 - ippLat)) | ...
           (ippLat < -70*pi/180 & tan(psiPP).*cos(az + pi) > tan(pi/2 + ippLat)));
ippLon(idx) = ippLon(idx) + pi;

% convert from radian to deg
ipp = [ippLat ippLon] * 180/pi;