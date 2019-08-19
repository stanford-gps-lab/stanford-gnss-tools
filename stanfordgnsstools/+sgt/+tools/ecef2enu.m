function ecef2enuMat = ecef2enu(posLLH)
% ecef2enu(posLLH) returns the rotation matrix from the ecef to enu frame.
% posLLH is a 1x3 array [deg deg m]. ecef2enuMat is a 3x3 matrix.

% Convert to radians
latRad = posLLH(1).*180/pi;
lonRad = posLLH(2).*180/pi;

% Preallocate
ecef2enuMat = zeros(3,3);

ecef2enuMat(:,:) = [...
    -sin(lonRad), cos(lonRad), 0;...
    -sin(latRad)*cos(lonRad), -sin(latRad)*sin(lonRad), cos(latRad);...
    cos(latRad)*cos(lonRad),  cos(latRad)*sin(lonRad), sin(latRad)...
    ];
end