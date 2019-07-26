function polygon = generatePolygon(llMat)
% generatePolygon   This function generates polygons in 2D to specify a
% coverage area for SBAS services. The polygon can then be used to assess
% whether users are within a service region or not.
%
%   polygon = sgt.tools.generatePolygon(llMat) creates a 2D polygon from a
%   set of M [lat, lon] points. The input can be either a set of data
%   written from a .dat file, or an Mx2 matrix. The output is a polyshape
%   object. .dat files should be input as a character type
%   (e.g. 'usrconus.dat')
%
%   See also: sgt.User

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

if (isa(llMat, 'double')) || (isa(llMat, 'single'))
    llMatrix = llMat;
    
elseif (isa(llMat, 'char'))
    % Load data from .dat file
    llMatrix = load(llMat);
    
else
    error('Input must be of type double, single, or char')
end

% Generate polyshape object
polygon = polyshape(llMatrix(:,2), llMatrix(:,1));

end

function checkInputs(llMatrix)
% Check for errors in input .dat matrix
[~, c] = size(llMatrix);
if (c ~= 2)
    error('Polygon formated incorrectly')
end

end