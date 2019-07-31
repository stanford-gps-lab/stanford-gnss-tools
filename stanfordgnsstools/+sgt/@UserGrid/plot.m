function plot(obj, varargin)
% plot  a method to plot the location of users in UserGrid
%
%   userGrid.plot(varargin) plots the users contained within userGrid on a
%   map of the earth. The default map is a spherical globe.
%
%   See Also: sgt.User, sgt.UserGrid
%
%   varargin:
%   -----
%   'PolygonFile' - a polygon file that contains a set of points that
%   define a geographic boundary.

% Parse varargin
if (nargin > 1)
    res = parseInput(varargin{:});
    
    if (~isempty(res.PolygonFile))
        polygon = sgt.tools.generatePolygon(res.PolygonFile);
    end
end

% Plot map
sgt.plotearth.earth_sphere('m');

% Plot user locations on map
hold on
plot3(obj.GridPositionECEF(:,1), obj.GridPositionECEF(:,2), obj.GridPositionECEF(:,3), 'r.')




end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% PolygonFile
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end