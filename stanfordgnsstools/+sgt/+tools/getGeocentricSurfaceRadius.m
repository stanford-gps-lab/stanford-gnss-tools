function reSe = getGeocentricSurfaceRadius(latb)
% This function gets the geocentric radius at the surface of the earth
% according to equation 2.137 in Groves 2nd edition. lat is the geodetic
% latitude input in [deg].
reSe = sgt.tools.getRE(latb)*sqrt((cos(latb*pi/180)^2) + ((1 - sgt.constants.EarthConstants.e2)^2)*(sin(latb*pi/180)^2));