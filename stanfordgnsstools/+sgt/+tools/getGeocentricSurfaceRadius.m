function reSe = getGeocentricSurfaceRadius(latb)
% This function gets the geocentric radius at the surface of the earth
% according to equation 2.137 in Groves 2nd edition. lat is the geodetic
% latitude input in [deg].
reSe = getRE(latb)*sqrt((cos(latb*pi/180)^2) + ((1 - sgt.constants.EarthConstants.e2)^2)*(sin(latb*pi/180)^2));
end

function RE = getRE(lat)
% This function gets the transverse radius of curviture as it relates to
% the geodetic latitude. (Not sure if its geocentric or geodetic). lat is 
% input in degrees. Eq 2.106 in Groves 2nd edition
RE = sgt.constants.EarthConstants.R/sqrt(1 - sgt.constants.EarthConstants.e2*(sin(lat*pi/180)^2));
end