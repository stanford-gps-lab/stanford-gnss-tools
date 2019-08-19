function ecef2enuMat = ecef2enu(posLLH)
% ecef2enu(posLLH) returns the rotation matrix from the ecef to enu frame.
% posLLH is a Nx3 array [deg deg m] where N is the number of input
% positions. ecef2enuMat is a 3x3xN matrix.

% Number of positions
[numPos, ~] = size(posLLH);

% Convert to radians
latRad = posLLH(:,1).*180/pi;
lonRad = posLLH(:,2).*180/pi;

% Preallocate
ecef2enuMat = zeros(3,3,numPos);

% Loop through the input positions
for i = 1:numPos
    ecef2enuMat(:,:,i) = [...
        -sin(lonRad(i))         ,  cos(lonRad(i))         , 0;...
        -sin(latRad(i))*cos(lonRad(i)), -sin(latRad(i))*sin(lonRad(i)), cos(latRad(i));...
        cos(latRad(i))*cos(lonRad(i)),  cos(latRad(i))*sin(lonRad(i)), sin(latRad(i))...
    ];
end
end