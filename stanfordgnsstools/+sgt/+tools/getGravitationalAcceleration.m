function grav = getGravitationalAcceleration(posECEF)
% This function gets the gravitaional acceleration at a position in the
% ECEF frame. grav is returned as a vector in the ECEF frame. This function
% references eq 2.138 in Groves 2nd ed.

% Convert geodetic latitude, longitude, and height to geodetic
[latb, hb] = sgt.tools.getGeodeticLatitudeAndHeight(posECEF);
lonb = atan2(posECEF(2), posECEF(1));

% Calculate the gravitation acceleration in the ECEF frame.
grav = ((sgt.tools.getGeocentricSurfaceRadius(latb)^2)/...
    ((sgt.tools.getGeocentricSurfaceRadius(latb) + hb)^2))*...
    sgt.tools.getEllipsoidGravitationalAcceleration(latb, lonb);