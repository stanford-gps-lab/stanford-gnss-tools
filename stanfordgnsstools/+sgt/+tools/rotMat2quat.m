function quat = rotMat2quat(rotMat)
% This function creates a quaternion vector from a rotation matrix. These
% are given as eq 2.35 and 2.36 in Groves 2nd ed.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Preallocate
quat = zeros(4,1);

% Eq 2.35
quat(1) = (1/2)*sqrt(1 + rotMat(1,1) + rotMat(2,2) + rotMat(3,3));
quat(2) = (rotMat(2,3) - rotMat(3,2))/(4*quat(1));
quat(3) = (rotMat(3,1) - rotMat(1,3))/(4*quat(1));
quat(4) = (rotMat(1,2) - rotMat(2,1))/(4*quat(1));

% If quat(1) close to 0, use eq. 2.36
if (quat(1) < 0.1) % Not sure if 0.1 is the correct value to use here
    quat = zeros(4,1);
    quat(2) = (1/2)*sqrt(1 + rotMat(1,1) - rotMat(2,2) - rotMat(3,3));
    quat(1) = (rotMat(2,3) - rotMat(3,2))/(4*quat(2));
    quat(3) = (rotMat(2,1) + rotMat(1,2))/(4*quat(2));
    quat(4) = (rotMat(3,1) + rotMat(1,3))/(4*quat(2));
end