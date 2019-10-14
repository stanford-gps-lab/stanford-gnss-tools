function quatMat = quat2MatMult(quatVec, matStr)
% This function takes a quaternion as an input and outputs a matrix that
% can be used in quaternion multiplication. matStr states whether the
% output matrix is the pre-multiplied or post-multiplied quaternion being
% converted. Reference eq E.15 in Groves 2nd edition.
%
% valid matStr: 'pre', 'post'

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Check inputs
if (nargin == 1)
    matStr = 'pre';
end

switch lower(matStr)
    case  'pre'
        quatMat = [quatVec(1), -quatVec(2), -quatVec(3), -quatVec(4);...
            quatVec(2), quatVec(1), -quatVec(4), quatVec(3);...
            quatVec(3), quatVec(4), quatVec(1), -quatVec(2);...
            quatVec(4), -quatVec(3), quatVec(2), quatVec(1)];
    case 'post'
        quatMat = [quatVec(1), -quatVec(2), -quatVec(3), -quatVec(4);...
            quatVec(2), quatVec(1), quatVec(4), -quatVec(3);...
            quatVec(3), -quatVec(4), quatVec(1), quatVec(2);...
            quatVec(4), quatVec(3), -quatVec(2), quatVec(1)];
    otherwise
        error('Incorrect statement for matStr')
end