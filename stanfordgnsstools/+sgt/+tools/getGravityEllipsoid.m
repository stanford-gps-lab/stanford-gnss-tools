function g0 = getGravityEllipsoid(latb)
% This function fetches g0 with respect to the earth using the equation
% specified in the WGS84 datum (eq 2.134 from Groves). lat is the
% geodetic latitude and is input in [deg]. This does not take into
% account centripital accleration.
% sgt.tools.getEllipsoidGravitationalAcceleration accounts for centripetal
% acceleration.
g0 = 9.7803253359*(1 + 0.001931853*(sin(latb*pi/180)^2))/(sqrt(1 - sgt.constants.EarthConstants.e2*(sin(latb*pi/180)^2)));