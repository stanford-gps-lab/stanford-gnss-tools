function grav = getGravitationalAcceleration(posECEF)
% This function gets the gravitaional acceleration at a position in the
% ECEF frame. grav is returned as a vector in the ECEF frame. This function
% references eq 2.138 in Groves 2nd ed.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Convert posECEF to vertical vector
[a, b] = size(posECEF);
if b > a
   posECEF = posECEF'; 
end

% Convert geocentric latitude, longitude, and height to geodetic
[latb, hb] = sgt.tools.getGeodeticLatitudeAndHeight(posECEF);
lonb = atan2(posECEF(2), posECEF(1))*180/pi;

% Calculate the gravitation acceleration in the ECEF frame.
grav = ((sgt.tools.getGeocentricSurfaceRadius(latb)^2)/...
    ((sgt.tools.getGeocentricSurfaceRadius(latb) + hb)^2))*...
    getEllipsoidGravitationalAcceleration(latb, lonb, posECEF);
end

function gravEllipsoid = getEllipsoidGravitationalAcceleration(latb, lonb, posECEF)
% This function finds the gravitation acceleration on the surface of an
% ellipsoid given the geodetic latitude. gravEllipsoid is given in the ECEF
% frame. This function references equation 2.132 in Groves 2nd ed.

% Get rotation matrix from local to ECEF frame
Cne = sgt.tools.local2ECEFMat(latb, lonb);

% Get gravity at ellipsoid in the ECEF frame
g0e = getGravityEllipsoid(latb)*Cne*[0;0;1];

% Get skew symmetric earth rotation in the ECEF frame
Omegaiee = sgt.tools.vec2skewSym([0, 0, sgt.constants.EarthConstants.omega]);

% Vector to the surface of the Earth under the body
rSeVec = sgt.tools.getGeocentricSurfaceRadius(latb)*posECEF/norm(posECEF);

% Calculate gravitational acceleration at the ellipsoid
gravEllipsoid = g0e + Omegaiee*Omegaiee*rSeVec;
end

function g0 = getGravityEllipsoid(latb)
% This function fetches g0 with respect to the earth using the equation
% specified in the WGS84 datum (eq 2.134 from Groves). lat is the
% geodetic latitude and is input in [deg]. This does not take into
% account centripital accleration.
% getEllipsoidGravitationalAcceleration accounts for centripetal
% acceleration.
g0 = sgt.constants.EarthConstants.g0*(1 + 0.001931853*(sin(latb*pi/180)^2))/(sqrt(1 - sgt.constants.EarthConstants.e2*(sin(latb*pi/180)^2)));
end
