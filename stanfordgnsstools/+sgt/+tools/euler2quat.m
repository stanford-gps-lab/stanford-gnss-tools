function quat = euler2quat(angles)
% euler2quat converts input Euler angles to a quaternion vector. angles is
% a 3xN matrix and quat is output as a 4xN matrix. This is eq. 2.38 in
% Groves 2nd ed.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

quat(1,:) = cos(angles(1,:)./2).*cos(angles(2,:)./2).*cos(angles(3,:)./2) + ...
    sin(angles(1,:)./2).*sin(angles(2,:)./2).*sin(angles(3,:)./2);
quat(2,:) = sin(angles(1,:)./2).*cos(angles(2,:)./2).*cos(angles(3,:)./2) - ...
    cos(angles(1,:)./2).*sin(angles(2,:)./2).*sin(angles(3,:)./2);
quat(3,:) = cos(angles(1,:)./2).*sin(angles(2,:)./2).*cos(angles(3,:)./2) + ...
    sin(angles(1,:)./2).*cos(angles(2,:)./2).*sin(angles(3,:)./2);
quat(4,:) = cos(angles(1,:)./2).*cos(angles(2,:)./2).*sin(angles(3,:)./2) - ...
    sin(angles(1,:)./2).*sin(angles(2,:)./2).*cos(angles(3,:)./2);
