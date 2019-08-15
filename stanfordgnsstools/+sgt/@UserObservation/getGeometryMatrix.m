function geometryMatrix = getGeometryMatrix(obj)
% obj.getGeometryMatrix()    retrieves the geometry matrix for the input
%   UserObservation(s). For N UserObservations, an Nx1 cell array is output
%   where each cell contains the geometry matrix for each discrete
%   UserObservation.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Number of Observations
numObj = length(obj);


% Preallocate Geometry Matrix
geometryMatrix{numObj, 1} = {};

for i = 1:numObj
    % build the G matrix in the ENU frame
    inview = obj(i).SatellitesInViewMask;  % need an in view mask
    geometryMatrix{i} = [obj(i).LOSenu(inview,:) ones(obj(i).NumSatellitesInView, 1)];
end

if (numObj == 1)
    geometryMatrix = geometryMatrix{1};
end

end