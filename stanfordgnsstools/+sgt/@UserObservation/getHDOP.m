function hdop = getHDOP(obj)
% obj.getHDOP()    retrieves the Horizontal Dilution of Precision (HDOP)
%   for the input UserObservation(s) (obj). For N UserObservations, an Nx1
%   array is output.

% Number of input objects
numObj = length(obj);

% Preallocate gdop
hdop = NaN(numObj, 1);

for i = 1:numObj
    % build the G matrix in the ENU frame
    inview = obj(i).SatellitesInViewMask;  % need an in view mask
    Genu = [obj(i).LOSenu(inview,:) ones(obj(i).NumSatellitesInView, 1)];
    
    % compute H = inv(Genu'Genu)
    H = inv(Genu' * Genu);
    
    % extract the diag of H for all the dop calculations
    DOPs = diag(H);
    
    % Compute HDOP
    hdop = sqrt(sum(DOPs(1:2)));
    
end

end