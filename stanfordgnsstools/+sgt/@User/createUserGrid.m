function users = createUserGrid(polyFile, latStep, lonStep)
% createUserGrid    create a regular grid of users within a given polygon
%
%   usrs = sgt.User.createUserGrid(polyfile, latstep, lonstep)
%   creates a list of users that lie within a box that bounds the polygon
%   specified in the polyfile.  The grid latitude and longitude step sizes
%   as specified as latstep and lonstep, respectively.
%
%   user = sgt.User.createUserGrid(numUsers)
%   creates a list of users that are evenly distributed throughout the 
%   globe. NOTICE: The number of users that are generated are not exactly
%   equal to the value numUsers. This is done in order to evenly distribute
%   users. If it is preferred to generate a grid of users that are
%   constrained within lat and lon boundaries, create a polyfile in the
%   form of a rectangle and use the 3-argument implementation of this 
%   function shown above.
%
%   See also: sgt.User, sgt.User.createFromLLHFile

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

if (nargin == 1)
    sqrtNumUsers = sqrt(polyFile);    % Value specified in this case is the number of users
    % define the bounds for the grid
    latMin = -90;
    latMax = 90;
    lonMin = 0;
    lonMax = 360;
    
    % create the lat/lon points that define the grid
    latStep = ceil((latMax - latMin)/sqrtNumUsers);
    lonStep = ceil((lonMax - lonMin)/sqrtNumUsers);
    gridLat = latMin+latStep:latStep:latMax-latStep;    % Don't double count the poles
    gridLon = lonMin:lonStep:lonMax-lonStep;    % Don't double count the prime meridian
    [latMesh, lonMesh] = meshgrid(gridLat, gridLon);
    posLLH = [latMesh(:), lonMesh(:), zeros(length(latMesh(:)), 1)];
    % Add polar locations
    posLLH = [-90, 0, 0;...
        posLLH;...
        90, 0, 0];
    
    % create the users (the IDs will just be sequential)
    users = sgt.User(posLLH);
    
else
    % load in the polygon file
    poly = load(polyFile);
    polygon = sgt.tools.generatePolygon(polyFile);
    
    % define the bounds for the grid
    latMin = max(floor(min(poly(:,1))/latStep)*latStep, -90);
    latMax = min(ceil(max(poly(:,1))/latStep)*latStep, 90-latStep);
    lonMin = floor(min(poly(:,2))/lonStep) * lonStep;
    lonMax = ceil(max(poly(:,2))/lonStep) * lonStep;
    
    % create the lat/lon points that define the grid
    gridLat = latMin:latStep:latMax;
    gridLon = lonMin:lonStep:lonMax;
    [latMesh, lonMesh] = meshgrid(gridLat, gridLon);
    posLLH = [latMesh(:), lonMesh(:), zeros(length(latMesh(:)), 1)];
    
    % create the users (the IDs will just be sequential) and flag whether or
    % not they are within the polygon
    users = sgt.User(posLLH, 'Polygon', polygon);
end
end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% Constellation
validConstellationFn = @(x) (ischar(x) || iscellstr(x)); %#ok<ISCLSTR>
parser.addParameter('Constellation', 'GPS', validConstellationFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end