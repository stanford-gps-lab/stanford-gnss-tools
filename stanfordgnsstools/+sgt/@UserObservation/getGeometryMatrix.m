function geometryMatrix = getGeometryMatrix(obj)
% obj.getGeometryMatrix()    retrieves the geometry matrix for the input
%   UserObservation(s). For N UserObservations, an Nx1 cell array is output
%   where each cell contains the geometry matrix for each discrete 
%   UserObservation.

% Number of Observations
numObj = length(obj);


% Preallocate Geometry Matrix
geometryMatrix{numObj, 1} = {};

for i = 1:numObj
    % build the G matrix in the ENU frame
    inview = obj(i).SatellitesInViewMask;  % need an in view mask
    geometryMatrix{i} = [obj(i).LOSenu(inview,:) ones(obj(i).NumSatellitesInView, 1)];
end

if (numObj == 1)
   geometryMatrix = geometryMatrix{1}; 
end

end