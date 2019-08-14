function pdop = getPDOP(obj)
% obj.getPDOP()    retrieves the Position Dilution of Precision (PDOP) for
%   the input UserObservation(s) (obj). For N UserObservations, an Nx1
%   array is output.

% Number of input objects
numObj = length(obj);

% Preallocate gdop
pdop = NaN(numObj, 1);

for i = 1:numObj
    % build the G matrix in the ENU frame
    inview = obj(i).SatellitesInViewMask;  % need an in view mask
    Genu = [obj(i).LOSenu(inview,:) ones(obj(i).NumSatellitesInView, 1)];
    
    % compute H = inv(Genu'Genu)
    H = inv(Genu' * Genu);
    
    % extract the diag of H for all the dop calculations
    DOPs = diag(H);
    
    % Compute PDOP
    pdop = sqrt(sum(DOPs(1:3)));
    
end

end