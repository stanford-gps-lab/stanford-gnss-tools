classdef EarthConstants
% EarthConstants 	a set of constant values related to the Earth.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

	properties (Constant)

		R = 6.378137e6;        	% equitorial radius according to WGS84 [m]
		mu = 3.986005e14;      	% Gravitational Parameter (mu = G*M_earth) [m^3/s^2]
		omega = 7.2921151467e-5; 	% mean angular velocity [rad/s]
		J_2 = 1.0826300e-3;        	% second zonal harmonic [-]
        e = 0.0818191908425;    % eccentricity
% 		E2 = 0.006694385000;      	% eccentricity^ 2[-]
        e2 = 0.0818191908425^2;     % eccentricity^2
        f = 1.0/298.257223563;      % f - Earth's flattening constant

        SiderealDay = 2*pi / sgt.constants.EarthConstants.omega;   % sidereal day in [seconds]
	end



end