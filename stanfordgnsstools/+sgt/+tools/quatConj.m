function quatOut = quatConj(quatIn)
% quatConj(quatIn) outputs the conjugate of the input quaternion. Assumes
% that quatIn(1) is the magnitude of the rotation. From eq. E.19 in Groves
% 2nd Ed. If quatIn is a 4xN matrix, quatOut is output as a 4xN matrix.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

quatOut(1,:) = quatIn(1,:);
quatOut(2:4,:) = -quatIn(2:4,:);