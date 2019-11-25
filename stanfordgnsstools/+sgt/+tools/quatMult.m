function quatOut = quatMult(quat1, quat2)
% quatOut = quatMult(quat1, quat2) performs a quaternion multiplication 
% using eq. E.15 from Groves 2nd Ed. If quat1 and quat2 are of size 4xN,
% quatOut is of size 4xN.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

quatOut(1,:) = quat1(1,:).*quat2(1,:) - quat1(2,:).*quat2(2,:) - ...
    quat1(3,:).*quat2(3,:) - quat1(4,:).*quat2(4,:);
quatOut(2,:) = quat1(1,:).*quat2(2,:) + quat1(2,:).*quat2(1,:) + ...
    quat1(3,:).*quat2(4,:) - quat1(4,:).*quat2(3,:);
quatOut(3,:) = quat1(1,:).*quat2(3,:) - quat1(2,:).*quat2(4,:) + ...
    quat1(3,:).*quat2(1,:) + quat1(4,:).*quat2(2,:);
quatOut(4,:) = quat1(1,:).*quat2(4,:) + quat1(2,:).*quat2(3,:) - ...
    quat1(3,:).*quat2(2,:) + quat1(4,:).*quat2(1,:);