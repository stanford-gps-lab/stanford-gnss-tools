function satelliteObject = getSatelliteObject(allSatelliteObjects, satellitePRN)
% This function retrieves the appropriate satellite object given an array
% of satellite objects and its PRN. This assumes you do not have any
% satellites with the same PRN.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Find the satellite object with the given PRN
allSatPRNs = [allSatelliteObjects.PRN];
indSat = allSatPRNs == satellitePRN;
satelliteObject = allSatelliteObjects(indSat);
end