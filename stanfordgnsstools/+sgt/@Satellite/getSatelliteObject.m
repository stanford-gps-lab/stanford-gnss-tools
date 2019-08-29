function satelliteObject = getSatelliteObject(allSatelliteObjects, satellitePRN)
% This function retrieves the appropriate satellite object given an array
% of satellite objects and its PRN. This assumes you do not have any
% satellites with the same PRN.

% Find the satellite object with the given PRN
allSatPRNs = [allSatelliteObjects.PRN];
indSat = allSatPRNs == satellitePRN;
satelliteObject = allSatelliteObjects(indSat);
end