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
%   -----
%   'LOS' - (True/False) Plot line of site vectors from users to the
%   satellites in view

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Handle nargin arguments
if nargin < 1
    return;
end
if nargin < 2
    time = 0;
end

% Useful variables
numSats = length(obj);

% Parse inputs
res = parseInput(varargin{:});

% Propagate satellite orbits for plotting purposes
satOrbit = propagateOrbit(obj);

% Plot satellite orbits with satellite at position at time 'time'
figure; hold on;
for i = 1:numSats
    % Plot orbits
    h = plot3(satOrbit(1,:,i), satOrbit(2,:,i), satOrbit(3,:,i));
    
    % Consistent colors between orbits and satellite positions
    colorNum = get(h, 'color');
    
    % Get satellite positions
    satPosition = obj(i).getPosition(time, 'eci');
    plot3(satPosition.ECI(1), satPosition.ECI(2), satPosition.ECI(3), '.', 'MarkerSize', 15,  'color', colorNum)
end
% Get rotation matrix for plotearth
temp1 = obj(1).getPosition(time, 'ecef');
temp1 = temp1.ECEF./norm(temp1.ECEF);
temp2 = obj(1).getPosition(time, 'eci');
temp2 = temp2.ECI./norm(temp2.ECI);
zRotFn = @(angle) [cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];
costFn = @(x) sum((temp1 - zRotFn(x)*temp2).^2);
[zRotAngle, ~] = fminsearch(costFn, 1);
rotMat = zRotFn(zRotAngle);
sgt.plotearth.earth_sphere(rotMat, 'm')

% Plot varargin variables
if (~isempty(res.UserGrid))
    % Plot user locations on map
    plot3(res.UserGrid.GridPositionECEF(:,1), res.UserGrid.GridPositionECEF(:,2), res.UserGrid.GridPositionECEF(:,3), 'r.', 'MarkerSize', 10)
end
if (~isempty(res.PolygonFile))
    polygonLLH = load(res.PolygonFile);
    polygonECEF = sgt.tools.llh2ecef([polygonLLH(:,1),...
        polygonLLH(:,2), 2e5*ones(length(polygonLLH),1)]);
    fill3(polygonECEF(:,1), polygonECEF(:,2), polygonECEF(:,3), 'c', 'FaceAlpha', 0.5)
    
    inBound = [res.UserGrid.Users(:).InBound];
    if (sum(inBound) > 0)
        plot3(res.UserGrid.GridPositionECEF(inBound,1), res.UserGrid.GridPositionECEF(inBound,2), res.UserGrid.GridPositionECEF(inBound,3), 'b.', 'MarkerSize', 10)
    end
end

end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% Polygon
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn)

% UserGrid
validUserGridFn = @(x) (isa(x, 'sgt.UserGrid'));
parser.addParameter('UserGrid', [], validUserGridFn)

% LOS
validLOSFn = @(x) (islogical(x));
parser.addParameter('LOS', false, validLOSFn);

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
sgtOmega = sgt.constants.EarthConstants.omega;

% Number of satellites
numSats = length(obj);

% Get orbital period
orbitalPeriod = 2*sgtPi*(obj(1).SqrtA^3)/sqrt(sgtMu);

% Time for satellites positions
timeProp = [0:1000:ceil(orbitalPeriod)+1000]';

% Preallocate satOrbit
satOrbit = NaN(3, length(timeProp), numSats);

% Get positions of satelite i for all times
satPositions = obj.getPosition(timeProp, 'ECI')';

% Output satOrbit matrix
satOrbit = reshape([satPositions.ECI], [3, length(timeProp), numSats]);
% 
% % Convert necessary information to a nice matrix to work with
% for i = 1:numSats
%     omegakDot = obj(i).RateOfRightAscension - sgtOmega;
%     
%     % Create rotation matrix to covert to an 'ECEF' frame at the instant
%     % the plot is called
%     rotMat = [cos((time - obj(i).TOA)*omegakDot), -sin((time - obj(i).TOA)*omegakDot), 0;...
%         sin((time - obj(i).TOA)*omegakDot), cos((time - obj(i).TOA)*omegakDot), 0;...
%         0, 0, 1];
%     
%     % Get satellite orbits
%     satOrbit(:,:,i) = rotMat*[satPositions(:,i).ECI];
% end


end