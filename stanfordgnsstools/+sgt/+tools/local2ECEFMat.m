function rotMat = local2ECEFMat(latb, lonb)
% This function creates a rotation matrix that converts vectors in the
% local frame (NED) into vectors in the ECEF frame. latb and lonb are the
% geodetic latitude [deg] and longitude [deg], respectively. This function
% references eq. 2.150 in Groves 2nd ed.

% Preallocate
rotMat = zeros(3);

% Convert degrees to radians
latbRad = latb*pi/180;
lonbRad = lonb*pi/180;

% Allocate
rotMat(1,1) = -sin(latbRad)*cos(lonbRad);
rotMat(1,2) = -sin(lonbRad);
rotMat(1,3) = -cos(latbRad)*cos(lonbRad);
rotMat(2,1) = -sin(latbRad)*sin(lonbRad);
rotMat(2,2) = cos(lonbRad);
rotMat(2,3) = -cos(latbRad)*sin(lonbRad);
rotMat(3,1) = cos(latbRad);
rotMat(3,2) = 0;
rotMat(3,3) = -sin(latbRad);