function [varargout] = llh2ecef(lat, lon, h)
% llh2ecef    convert from a lat/lon/height in [deg]/[deg]/[m] to an ECEF
% position in [m].
%
%	ecef = sgt.tools.llh2ecef(llh) calculates the Nx3 ECEF position from 
%   the Nx3 geocentric llh matrix containing the latitude, longitude, and 
%   height information in [deg, deg, m].  The llh matrix must be an Nx3 
%   matrix with each row containing a [lat, lon, h] point to convert.  The 
%   resulting ecef matrix will also be an Nx3 matrix with each row 
%   containing the [x, y, z] position.
%
%	[x, y, z] = sgt.tools.llh2ecef(lat, lon, h) calculates the ECEF
%	position given the geocentric latitude ([deg]), longitude ([deg]), and 
%   height ([m]) as three separate vector.  Each vector must have the same 
%   size. The ECEF position is returned as three separate vectors x, y, and 
%   z containing the corresponding ECEF position component.
%
% 	See Also: sgt.User

% Copyright 2001-2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools


% want to allow either a matrix input or 3 separate arrays, so check to see
% if the user entered a matrix
if nargin == 1
	[~, c] = size(lat);
	if c ~= 3
		error('invalid matrix input format');
	end

	% split out the 3 elements
	lon = lat(:,2);
	h = lat(:,3);
	lat = lat(:,1);
end

% convert from deg to rad
lonRad = lon * pi/180;
latRad = lat * pi/180;

% get sin and cos of latitude
sinLat = sin(latRad);
cosLat = cos(latRad);

% setup additional values
f = sgt.constants.EarthConstants.f;
e2 = (2 - f) * f;
r_N  = sgt.constants.EarthConstants.R ./ sqrt(1 - e2*sinLat.*sinLat);

% do the conversion
x = (r_N + h).*cosLat.*cos(lonRad);
y = (r_N + h).*cosLat.*sin(lonRad);
z = (r_N*(1 - e2) + h).*sinLat;

% if the input was a matrix, return a matrix output, if the input was 3 
% separate vectors, then return 3 separate vectors
if nargin == 1
	varargout{1} = [x y z];
else
	varargout{1} = x;
	varargout{2} = y;
	varargout{3} = z;
end