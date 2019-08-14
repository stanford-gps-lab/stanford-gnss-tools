function vdop = getVDOP(obj)
% obj.getHDOP()    retrieves the Vertical Dilution of Precision (VDOP)
%   for the input UserObservation(s) (obj). For N UserObservations, an Nx1
%   array is output.

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