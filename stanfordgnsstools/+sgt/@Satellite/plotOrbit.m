function plotOrbit(obj, time, varargin)
% satellite.plotOrbits(obj, time, varargin)  a function that plots the 3D
%   Earth with the orbits of all the satellites (obj). Optionally, a
%   UserGrid can also be passed to plot the UserGrid on the Earth as well.
%
%   See Also: sgt.Satellite, sgt.UserGrid, sgt.UserGrid.createUserGrid
%
%   varargin:
%   -----
%   'UserGrid' - A valid UserGrid object that will plot the locations of
%   the users on the Earth.
%   -----
%   'PolygonFile' - A polygon file that contains the information necessary
%   to create a geographic boundary

% Useful variables
numSats = length(obj);

% Parse inputs
res = parseInput(varargin{:});

% Propagate satellite orbits for plotting purposes
satOrbit = propagateOrbit(obj);

% Plot satellite orbits with satellite at position at time 'time'
figure; hold on;
for i = 1:numSats
    plot3(satOrbit(:,1,i), satOrbit(:,2,i), satOrbit(:,3,i))
end

% Plot varargin variables

end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% Polygon
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn)

% UserGrid
validUserGridFn = @(x) (isa(x, 'UserGrid'));
parser.addParameter('UserGrid', [], validUserGridFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end

% Propagate Orbit for plotting purposes
function satOrbit = propagateOrbit(obj)
% Create a cell matrix comprised of M Nx3 matrices where M is the total
% number of satellites, N is the number of discrete points in time, and the
% three columns represent the XYZ position in ECEF.

% Get Constants
sgtPi = sgt.constants.UniversalConstants.pi;
sgtMu = sgt.constants.EarthConstants.mu;

% Number of satellites
numSats = length(obj);

% Preallocate satOrbit
satPositions = sgt.SatellitePosition();

% Loop through number of satellites to propagate orbits
% for i = 1:numSats
% Get current object
%    currentObj = obj(i);

% Get orbital period
orbitalPeriod = 2*sgtPi*(obj(1).SqrtA^3)/sqrt(sgtMu);

% Time for satellites positions
time = [0:1000:ceil(orbitalPeriod)]';

% Get positions of satelite i for all times
satPositions = obj.getPosition(time, 'ECEF')';

% Convert necessary information to a nice matrix to work with
for i = 1:numSats
    satOrbit(:,:,i) = [satPositions(:,i).ECEF]';
end
% end


end