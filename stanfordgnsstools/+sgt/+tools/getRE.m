function RE = getRE(lat)
% This function gets the transverse radius of curviture as it relates to
% the latitude. (Not sure if its geocentric or geodetic). lat is input in
% degrees.
RE = sgt.constants.EarthConstants.R/sqrt(1 - sgt.constants.EarthConstants.e2*(sin(lat*pi/180)^2));