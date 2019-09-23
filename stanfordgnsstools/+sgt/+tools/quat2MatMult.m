function quatMat = quat2MatMult(quatVec, matStr)
% This function takes a quaternion as an input and outputs a matrix that
% can be used in quaternion multiplication. matStr states whether the
% output matrix is the pre-multiplied or post-multiplied quaternion being
% converted. Reference eq E.15 in Groves 2nd edition.
%
% valid matStr: 'pre', 'post'

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