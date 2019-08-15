function vdop = getVDOP(obj)
% obj.getHDOP()    retrieves the Vertical Dilution of Precision (VDOP)
%   for the input UserObservation(s) (obj). For N UserObservations, an Nx1
%   array is output.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Number of input objects
numObj = length(obj);

% Preallocate gdop
vdop = NaN(numObj, 1);

for i = 1:numObj
    % build the G matrix in the ENU frame
    inview = obj(i).SatellitesInViewMask;  % need an in view mask
    Genu = [obj(i).LOSenu(inview,:) ones(obj(i).NumSatellitesInView, 1)];
    
    % compute H = inv(Genu'Genu)
    H = inv(Genu' * Genu);
    
    % extract the diag of H for all the dop calculations
    DOPs = diag(H);
    
    % Compute VDOP
    vdop = sqrt(DOPs(3));
    
end

end