function rotMat = quat2rotMat(quat)
% This function creates a rotation matrix from a quaternion vector. This
% function references equation 2.34 in Groves 2nd edition.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Preallocate
rotMat = zeros(3);

% Allocate
rotMat(1,1) = quat(1)^2 + quat(2)^2 - quat(3)^2 - quat(4)^2;
rotMat(1,2) = 2*(quat(2)*quat(3) + quat(4)*quat(1));
rotMat(1,3) = 2*(quat(2)*quat(4) - quat(3)*quat(1));
rotMat(2,1) = 2*(quat(2)*quat(3) - quat(4)*quat(1));
rotMat(2,2) = quat(1)^2 - quat(2)^2 + quat(3)^2 - quat(4)^2;
rotMat(2,3) = 2*(quat(3)*quat(4) + quat(2)*quat(1));
rotMat(3,1) = 2*(quat(2)*quat(4) + quat(3)*quat(1));
rotMat(3,2) = 2*(quat(3)*quat(4) - quat(2)*quat(1));
rotMat(3,3) = quat(1)^2 - quat(2)^2 - quat(3)^2 + quat(4)^2;