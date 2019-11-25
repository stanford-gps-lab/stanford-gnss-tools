function ecef2nedMat = ecef2ned(posECEF)
% ecef2ned(posECEF) returns the rotation matrix from the ecef to ned frame.
% posECEF is a 1x3 array [m m m]. ecef2nedMat is a 3x3 matrix.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Find LLH
[posLat, posLon, posH] = sgt.tools.ecef2llh(posECEF(1), posECEF(2), posECEF(3));

% Convert to radians
latRad = posLat.*pi/180;
lonRad = posLon.*pi/180;

% Preallocate
ecef2nedMat = zeros(3,3);

ecef2nedMat(:,:) = [...
    -sin(latRad)*cos(lonRad), -sin(latRad)*sin(lonRad), cos(latRad);...
    -sin(lonRad), cos(lonRad), 0;...
    -cos(latRad)*cos(lonRad), -cos(latRad)*sin(lonRad), -sin(latRad)...
    ];
end