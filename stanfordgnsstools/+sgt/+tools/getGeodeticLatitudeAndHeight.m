function varargout = getGeodeticLatitudeAndHeight(posECEF)
% This function finds the geodetic latitude of a point in ECEF. It does so
% using the Heikkinen Closed-Form Exact Solution found in Appendix C.2.2 in
% Groves, 2nd ed. posECEF should be a 3 element array in [m].
%
% varargout:
% if nargout == 1: varargout = geodeticLatitude
% if nargout == 2: varargout = [geodeticLatitude, geodeticHeight]

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% check correct input dimensions
[s1, s2] = size(posECEF);
if (s1 ~= 3) && (s2 ~= 3)
    error('Wrong input dimensions to getGeodeticLatitudeAndHeight.')
elseif (s1 ~= 3) && (s2 == 3)
    % ECEF position is passed as row vectors
    flipDim = true;
    posECEF = posECEF';
else
    flipDim = false;
end

% prepare some computations
e2R = sgt.constants.EarthConstants.e2 * sgt.constants.EarthConstants.R;
posECEF2 = posECEF.^2;

% C.18
Betaebe = sqrt(posECEF2(1, :) + posECEF2(2, :));

% C.19
F = 54 * (1 - sgt.constants.EarthConstants.e2) ...
       * sgt.constants.EarthConstants.R^2 ...
       * posECEF2(3, :);

% C.20
G = Betaebe.^2 ...
    + (1 - sgt.constants.EarthConstants.e2) * posECEF2(3, :) ...
    - e2R^2;

% C.21
C = sgt.constants.EarthConstants.e2^2 * F .* Betaebe.^2 ./ G.^3;

% C.22
S = nthroot(1 + C + sqrt(C.^2 + 2*C), 3);

% C.23
P = F ./ (3 * (S + 1./S + 1).^2 .* G.^2);

% C.24
Q = sqrt(1 + 2 * sgt.constants.EarthConstants.e2^2 * P);

% C.25
T = sqrt(sgt.constants.EarthConstants.R^2 / 2 * (1 + 1./Q) ...
        - P .* (1 - sgt.constants.EarthConstants.e2) .* posECEF2(3, :) ./ Q ./ (1 + Q) ...
        - P .* Betaebe.^2 / 2) ...
    - P .* sgt.constants.EarthConstants.e2 .* Betaebe ./ (1 + Q);

% C.26
V = sqrt((Betaebe - sgt.constants.EarthConstants.e2 * T).^2 ...
        + (1 - sgt.constants.EarthConstants.e2) * posECEF2(3, :));

% C.27 - find geodeticLatitude in degrees
geodeticLatitude = atan2( ...
    (1 + e2R ./ V) .* posECEF(3, :), ...
    Betaebe) * 180/pi;

% revert dimensions to input dimensions if necessary
if flipDim
    geodeticLatitude = geodeticLatitude';
end

if (nargout < 2)
    varargout{1} = geodeticLatitude;
    return;
elseif (nargout == 2)
    % C.28 - find geodeticHeight in meters
    geodeticHeight = (1 - (1 - sgt.constants.EarthConstants.e2) * sgt.constants.EarthConstants.R ./ V) ...
        .* sqrt((Betaebe - sgt.constants.EarthConstants.e2 .* T).^2 + posECEF2(3, :));
    
    % revert dimensions to input dimensions if necessary
    if flipDim
        geodeticHeight = geodeticHeight';
    end

    varargout{1} = geodeticLatitude;
    varargout{2} = geodeticHeight;
    return;
else
   error('Wrong number of output arguments') 
end

end
