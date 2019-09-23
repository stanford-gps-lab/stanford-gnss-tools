function g0 = getg0(lat)
% This function fetches g0 with respect to the earth using the equation
% specified in the WGS84 datum (eq 2.314 from Groves). Latitude is input in
% degrees. (not sure if this is geocentric or geodetic latitude...)
g0 = 9.7803253359*(1 + 0.001931853*(sin(lat*pi/180)^2))/(sqrt(1 - sgt.constants.EarthConstants.e2*(sin(lat*pi/180)^2)));