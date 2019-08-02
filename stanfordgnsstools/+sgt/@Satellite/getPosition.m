function satellitePosition = getPosition(obj, time, frame)
% getPosition   get the SatellitePosition of the satellite for a given time
%   compute the SatellitePosition of the satellite from the alamanac data
%   that defines the orbit of the satellite for a given time or a set of
%   times provided. The reference frame is by default ECEF, but can be
%   specified as an input.
%
%   satellitePosition = getPosition(satellite, time, frame) computes the
%   SatellitePosition of a satellite (or an array of satellites) at the
%   time(s) provided. For an array of S satellites and T times, the
%   resulting position matrix will be an Sx3xT cell matrix of satellite
%   positions defined as SatellitePosition. Each satellite at each time
%   contains an array which will be [X; Y; Z] for 'ECEF' and
%   [Latitude; Longitude; Altitude] for 'LLH'.
%   Current frames supported are: 'ECEF', 'LLH'   
%
% See also: sgt.SatellitePosition

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Set frame if frame not specified
if nargin < 3
    frame = 'ECEF';
end

% Get constants needed
CONST_MU_E = sgt.constants.EarthConstants.mu;
CONST_OMEGA_E = sgt.constants.EarthConstants.omega;

%
% Setup
%

% make sure time is as a row vector
if ~isrow(time)
    time = time';
end

% figure out how many satellites and how much time
S = length(obj);
T = length(time);

% extract and expand satellite properties that will be needed
sqrt_a = [obj(:).SqrtA]';
axis = repmat(sqrt_a.^2, 1, T);
toa = repmat([obj(:).TOA]', 1, T);
eccentricity = repmat([obj(:).Eccentricity]', 1, T);
meanAnomaly = repmat([obj(:).MeanAnomaly]', 1, T);
argumentOfPerigee = repmat([obj(:).ArgumentOfPerigee]', 1, T);
inclination = repmat([obj(:).Inclination]', 1, T);
rora = repmat([obj(:).RateOfRightAscension]', 1, T);
raan = repmat([obj(:).RAAN]', 1, T);

% expand the time vector
time = repmat(time, S, 1);

%
% Computation
%

% Compute mean motion
n0 = sqrt(CONST_MU_E ./ axis.^3);  % dim: SxT

% Modification (for ICD-100)
Tk = time - toa;  % dim: SxT

% Compute mean anomaly
Mk = meanAnomaly + n0.*Tk;  % dim: SxT

% Compute eccentric anomaly
E0 = Mk + 100;  % dim: SxT
Ek = Mk;
i = 1;
while (abs(Ek-E0) > 1e-12 & i < 250)
    E0 = Ek;
    Ek = Mk + eccentricity.*sin(E0);
    i = i + 1;
end

cosEk = cos(Ek);
sinEk = sin(Ek);


% c1 = 1 - eccen .* cos_Ek;
% Ek_dot = n0./c1;

% Compute true anomaly
c2 = sqrt(1 - eccentricity.^2);
vk = atan2(c2.*sinEk, cosEk-eccentricity);  % dim: SxT
% vk_dot = Ek_dot.*c2./c1;

% Compute argument of latitude
phik = vk + argumentOfPerigee;  % dim: SxT

% Compute corrected argument of latitude
uk = phik;  % dim: SxT
% uk_dot = vk_dot;

% Compute corrected radius
rk = axis.*(1 - eccentricity.*cosEk);  % dim: SxT
% rk_dot = axis.*eccen.*Ek_dot.*sin_Ek;

% Compute corrected inclination
ik = inclination;  % dim: SxT

cosuk = cos(uk);
sinuk = sin(uk);

% Compute position in orbital plane
xkOrbital = rk.*cosuk;  % dim: SxT
% xxk_dot = rk_dot.*cos_uk - uk_dot.*rk.*sin_uk;

ykOrbital = rk.*sinuk;  % dim: SxT
% yyk_dot = rk_dot.*sin_uk + uk_dot.*rk.*cos_uk;

% Compute corrected longitude of ascending node
Omegakdot = rora - CONST_OMEGA_E;
Omegak = raan + Omegakdot.*Tk - CONST_OMEGA_E * mod(toa, 604800);

cosOmegak = cos(Omegak);
sinOmegak = sin(Omegak);
cosik = cos(ik);
sinik = sin(ik);

% build the position matrix to output the data
pos = zeros(S, 3, T);

% populate the X, Y, Z information to create the Sx3xT matrix needed for
% the SatellitePosition constructor
pos(:,1,:) = xkOrbital.*cosOmegak - ykOrbital.*cosik.*sinOmegak;
pos(:,2,:) = xkOrbital.*sinOmegak + ykOrbital.*cosik.*cosOmegak;
pos(:,3,:) = ykOrbital.*sinik;

% create the satellite position matrix
% NOTE: need to squeeze the posecef matrix to remove any singleton
% dimensions since that's how the constructor for SatellitePosition is
% built
satellitePosition = sgt.SatellitePosition(obj, time(1,:), lower(frame), squeeze(pos));





% original code for creating the position vector:
%sv_xyz = [xxk.*cosO - yyk.*cosi.*sinO, xxk.*sinO + yyk.*cosi.*cosO, yyk.*sini];

% TODO: at the moment don't need any velocity information
%sv_xyz_dot=[xxk_dot.*cosO - Omegak_dot.*xxk.*sinO-...
%            yyk_dot.*cosi.*sinO - Omegak_dot.*yyk.*cosi.*cosO, ...
%            xxk_dot.*sinO + Omegak_dot.*xxk.*cosO+...
%            yyk_dot.*cosi.*cosO - Omegak_dot.*yyk.*cosi.*sinO, ...
%            yyk_dot.*sini];