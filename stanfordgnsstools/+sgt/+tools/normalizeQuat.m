function quatOut = normalizeQuat(quatIn)
% normalizeQuat normalizes the input quaternion using eq. E.43 in Groves
% 2nd Ed. if quatIn is a 4xN matrix, quatOut is output as a 4xN matrix.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

quatOut = quatIn./sqrt(quatIn(1,:).^2 + quatIn(2,:).^2 + quatIn(3,:).^2 + quatIn(4,:).^2);