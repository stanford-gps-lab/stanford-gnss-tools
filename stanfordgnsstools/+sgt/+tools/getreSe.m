function reSe = getreSe(lat)
% This function gets the geocentric radius at the surface of the earth
% according to equation 2.137 in Groves 2nd edition. lat is input in
% degrees.
reSe = sgt.tools.getRE(lat)*sqrt((cos(lat*pi/180)^2) + ((1 - sgt.constants.EarthConstants.e2)^2)*(sin(lat*pi/180)^2));