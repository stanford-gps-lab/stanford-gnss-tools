function losxyzb = findLOSxyzb(userxyz, satellitexyz, losMask)

%*************************************************************************
%*     Copyright c 2009 The board of trustees of the Leland Stanford     *
%*                      Junior University. All rights reserved.          *
%*     This script file may be distributed and used freely, provided     *
%*     this copyright notice is always kept with it.                     *
%*                                                                       *
%*     Questions and comments should be directed to Todd Walter at:      *
%*     twalter@stanford.edu                                              *
%*************************************************************************
%
% findLOSxyzb calculates the 4D line of sight vectors
%
% LOSxyzb = findLOSxyzb(userxyz, satellitexyz)
%  Given N user xyz positions [Nx3] and M satellite xyz positions [Mx3] 
%  both in ECEF WGS-84 coordinates (X in first column, Y in second column,
%  Z in third column) in userxyz and satellitexyz respectively, this 
%  function returns the N*M line of sight (LOS) unit vectors augmented by a
%  one at the end. These LOS vectors may then be used to form the position 
%  solution.  
% 
% LOSxyzb = findLOSxyzb(userxyz, satellitexyz, losMask)
%  losMask is an optional input vector [N*Mx1] of indices (1 to N*M) that 
%  specifies which LOS vectors to selectively compute.
%  
%   See also: findLOSenub

%2001Mar26 Created by Todd Walter
%2001Apr26 Modified by Wyant Chan   -   Added losmask feature
%2009Nov23 Modified by Todd Walter - Changed sign convention
%2019May8 Modified by Andrew Neish - Adapted for MAASTv2

[numUser, ~] = size(userxyz); % Evaluate number of users
[numSat, ~] = size(satellitexyz); % Evaluate number of satellites
numLOS = numUser*numSat; % Evaluate number of lines of site

% Check if losMask argument is present
if (nargin==2)
    losMask = [1:numLOS]';
end
numMask = length(losMask);

%initialize 4th column of the line of sight vector
losxyzb = ones(numMask,4);

%build the line of sight vector
[temp1, temp2] = meshgrid(userxyz(:,1), satellitexyz(:,1));
temp1 = reshape(temp1, numLOS, 1);
temp2 = reshape(temp2, numLOS, 1);
losxyzb(:,1) = temp2(losMask) - temp1(losMask);

[temp1, temp2] = meshgrid(userxyz(:,2), satellitexyz(:,2));
temp1 = reshape(temp1,numLOS,1);
temp2 = reshape(temp2,numLOS,1);
losxyzb(:,2) = temp2(losMask) - temp1(losMask);

[temp1, temp2]=meshgrid(userxyz(:,3), satellitexyz(:,3));
temp1 = reshape(temp1,numLOS,1);
temp2 = reshape(temp2,numLOS,1);
losxyzb(:,3) = temp2(losMask) - temp1(losMask);

%normalize first three columns
mag=sqrt(sum(losxyzb(:,1:3)'.^2))';
losxyzb(:,1)=losxyzb(:,1)./mag;
losxyzb(:,2)=losxyzb(:,2)./mag;
losxyzb(:,3)=losxyzb(:,3)./mag;




