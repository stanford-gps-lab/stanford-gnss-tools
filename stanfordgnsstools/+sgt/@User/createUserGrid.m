function usrs = createUserGrid(polyfile, latstep, lonstep)
% createUserGrid    create a regular grid of users within a given polygon
%
%   usrs = sgt.User.createUserGrid(polyfile, latstep, lonstep)
%   creates a list of users that lie within a box that bounds the polygon
%   specified in the polyfile.  The grid latitude and longitude step sizes
%   as specified as latstep and lonstep, respectively.
%
%

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% load in the polygon file
poly = sgt.tools.generatePolygon(polyfile);

% define the bounds for the grid
latmin = max(floor(min(poly(:,1))/latstep)*latstep, -90);
latmax = min(ceil(max(poly(:,1))/latstep)*latstep, 90-latstep);
lonmin = floor(min(poly(:,2))/lonstep) * lonstep;
lonmax = ceil(max(poly(:,2))/lonstep) * lonstep;

% create the lat/lon points that define the grid
gridLat = latmin:latstep:latmax;
gridLon = lonmin:lonstep:lonmax;
[latmesh, lonmesh] = meshgrid(gridLat, gridLon);
posllh = [latmesh(:), lonmesh(:), zeros(length(latmesh(:)), 1)];

% create the users (the IDs will just be sequential) and flag whether or
% not they are within the polygon
usrs = sgt.User(posllh, 'Polygon', poly);