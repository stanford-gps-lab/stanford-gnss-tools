function losenub = findLOSenub(losxyzb, usereHat, usernHat, useruHat,...
    losMask)

%findLOSenub converts 4D line of sight vectors from XYZ to East North Up
%   (ENU)
%
%losenub = findLOSenub(losxyzb, uesreHat, usernHat, useruHat)
%   Given N line of sight (LOS) vectors in ECEF WGS-84 coordinates (X in first
%   column, Y in second column, Z in the third column and 1 in the fourth) in
%   losxyzb and N east, north, and up unit vectors (at the user location)
%   in usereHat, usernHat, and useruHat respectively this function returns the N
%   LOS unit vectors augmented by a one at the end in the East, North
%   and Up frame.  These LOS vectors may then be used to form the position
%   solution.
%
%losenub = findLOSenub(losxyzb, uesreHat, usernHat, useruHat, losMask)
%  losMask is an optional input vector [N*Mx1] of indices (1 to N*M) that
%  specifies which LOS vectors to selectively compute.
%
%   See also: findLOSxyzb
%
%Copyright 2019 Stanford University GPS Laboratory
%   This file is part of stanford-gnss-toolbox which is released under the
%   MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

[numLOS, ~] = size(losxyzb);
[numUser, ~] = size(usereHat);
numSat = numLOS/numUser;

% Check if losMask argument is present
if (nargin==4)
    losMask = [1:numLOS]';
end
numMask = length(losMask);
satelliteID = 1:numSat;

% expand the user east unit vector to match the lines of sight
[temp1, ~] = meshgrid(usereHat(:,3), satelliteID);
eHat(:,3) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(usereHat(:,2), satelliteID);
eHat(:,2) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(usereHat(:,1), satelliteID);
eHat(:,1) = reshape(temp1, numLOS, 1);


% expand the user north unit vector to match the lines of sight
[temp1, ~] = meshgrid(usernHat(:,3), satelliteID);
nHat(:,3) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(usernHat(:,2), satelliteID);
nHat(:,2) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(usernHat(:,1), satelliteID);
nHat(:,1) = reshape(temp1, numLOS, 1);


% expand the user up unit vector to match the lines of sight
[temp1, ~] = meshgrid(useruHat(:,3), satelliteID);
uHat(:,3) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(useruHat(:,2), satelliteID);
uHat(:,2) = reshape(temp1, numLOS, 1);

[temp1, ~] = meshgrid(useruHat(:,1), satelliteID);
uHat(:,1) = reshape(temp1, numLOS, 1);

% calculate the LOS vectors in the ENU frame

% dot the east unit vector with the los vector to determine 
% -cos(elev)*sin(azim)
losenub(:,1)=sum((-eHat.*losxyzb(:,1:3))')';

end




