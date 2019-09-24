function gravEllipsoid = getEllipsoidGravitationalAcceleration(latb, lonb)
% This function finds the gravitation acceleration on the surface of an
% ellipsoid given the geodetic latitude. gravEllipsoid is given in the ECEF
% frame. This function references equation 2.132 in Groves 2nd ed.

% Get rotation matrix from local to ECEF frame
Cne = sgt.tools.local2ECEFMat(latb, lonb);

% Get gravity at ellipsoid in the ECEF frame
g0e = sgt.tools.getGravityEllipsoid(latb)*Cne*[0;0;-1];

% Get skew symmetric earth rotation in the ECEF frame
Omegaiee = sgt.tools.vec2skewSym([0, 0, sgt.constants.EarthConstants.omega]);

% Calculate gravitational acceleration at the ellipsoid
gravEllipsoid = g0e + Omegaiee*Omegaiee*sgt.tools.getGeocentricSurfaceRadius(latb);