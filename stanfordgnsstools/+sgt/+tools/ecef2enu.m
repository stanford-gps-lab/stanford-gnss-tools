function ecef2enuMat = ecef2enu(posLLH)
% ecef2enu(posLLH) returns the rotation matrix from the ecef to enu frame.
% posLLH is a 1x3 array [deg deg m]. ecef2enuMat is a 3x3 matrix.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Convert to radians
latRad = posLLH(1).*pi/180;
lonRad = posLLH(2).*pi/180;

% Preallocate
ecef2enuMat = zeros(3,3);

ecef2enuMat(:,:) = [...
    -sin(lonRad), cos(lonRad), 0;...
    -sin(latRad)*cos(lonRad), -sin(latRad)*sin(lonRad), cos(latRad);...
    cos(latRad)*cos(lonRad),  cos(latRad)*sin(lonRad), sin(latRad)...
    ];
end