function losxyzb = findLOSxyzb(userxyz, satellitexyz, losMask)
% findLOSxyzb calculates the 4D line of sight vectors.
%
%losxyzb = findLOSxyzb(userxyz, satellitexyz)
%  Given N user xyz positions [Nx3] and M satellite xyz positions [Mx3] 
%  both in ECEF WGS-84 coordinates (X in first column, Y in second column,
%  Z in third column) in userxyz and satellitexyz respectively, this 
%  function returns the N*M line of sight (LOS) unit vectors augmented by a
%  one at the end. These LOS vectors may then be used to form the position 
%  solution.  
% 
%losxyzb = findLOSxyzb(userxyz, satellitexyz, losMask)
%  losMask is an optional input vector [N*Mx1] of indices (1 to N*M) that 
%  specifies which LOS vectors to selectively compute.
%  
%   See also: findLOSenub
% 
%Copyright 2019 Stanford University GPS Laboratory
%   This file is part of stanford-gnss-toolbox which is released under the 
%   MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

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




