function plot(obj, varargin)
% plot  a method to plot the location of users in UserGrid
%
%   userGrid.plot(varargin) plots the users contained within userGrid on a
%   map of the earth. The default map is a spherical globe.
%
%   See Also: sgt.User, sgt.UserGrid, sgt.UserGrid.createUserGrid
%
%   varargin:
%   -----
%   'PolygonFile' - a polygon file that contains a set of points that
%   define a geographic boundary.
%   -----
%   'Globe3D' - plots the userGrid and other information on a 3D globe

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Define 2D axis parameters
axis2D = [-180, 180, -90, 90];

% Parse varargin
if (nargin > 1)
    res = parseInput(varargin{:});
    
    if (res.Globe3D)
        figure;
        % Plot map
        sgt.plotearth.earth_sphere('m'); hold on;
        % Plot user locations on map
        plot3(obj.GridPositionECEF(:,1), obj.GridPositionECEF(:,2), obj.GridPositionECEF(:,3), 'r.', 'MarkerSize', 10)
        % Plot polygon if requested
        if (~isempty(res.PolygonFile))
            polygonLLH = load(res.PolygonFile);
            polygonECEF = sgt.tools.llh2ecef([polygonLLH(:,1),...
                polygonLLH(:,2), 2e5*ones(length(polygonLLH),1)]);
            fill3(polygonECEF(:,1), polygonECEF(:,2), polygonECEF(:,3), 'c', 'FaceAlpha', 0.5)
            
            inBound = [obj.Users(:).InBound];
            if (sum(inBound) > 0)
                plot3(obj.GridPositionECEF(inBound,1), obj.GridPositionECEF(inBound,2), obj.GridPositionECEF(inBound,3), 'b.', 'MarkerSize', 10)
            end
        end
        
    else
        figure;
        % Plot map
        coastData = load('coast'); 
        plot(coastData.long, coastData.lat, 'k'); axis(axis2D); axis equal; hold on;
        % Plot user locations on map
        plot(obj.GridPositionLLH(:,2), obj.GridPositionLLH(:,1), 'r.')
        % Plot polygon if requested
        if (~isempty(res.PolygonFile))
            polygon = sgt.tools.generatePolygon(res.PolygonFile);
            plot(polygon);
            
            inBound = [obj.Users(:).InBound];
            if (sum(inBound) > 0)
                plot(obj.GridPositionLLH(inBound, 2), obj.GridPositionLLH(inBound, 1), 'b.')
            end
        end
    end
else
    % Plot a 2D plot of the users on earth
    figure;
    % Plot map
    coastData = load('coast'); 
    plot(coastData.long, coastData.lat, 'k'); axis(axis2D); hold on;
    % Plot user locations on map
    plot(obj.GridPositionLLH(:,2), obj.GridPositionLLH(:,1), 'r.')
    
end
end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% PolygonFile
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn)

% Globe3D
validGlobe3DFn = @(x) (islogical(x));
parser.addParameter('Globe3D', false, validGlobe3DFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end