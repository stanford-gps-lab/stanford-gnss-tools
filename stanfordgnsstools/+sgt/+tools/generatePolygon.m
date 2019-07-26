function polygon = generatePolygon(llMat)
% generatePolygon   This function generates polygons in 2D to specify a
% coverage area for SBAS services. The polygon can then be used to assess
% whether users are within a service region or not.
%
%   polygon = sgt.tools.generatePolygon(llMat) creates a 2D polygon from a
%   set of M [lat, lon] points. The input can be either a set of data
%   written from a .dat file, or an Mx2 matrix. The output is a polyshape
%   object.
%
%   See also: sgt.User