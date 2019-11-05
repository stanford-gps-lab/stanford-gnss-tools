classdef UniversalConstants
% UniversalConstants     Universal constants defined in WGS84

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools
    
    properties (Constant)
        % pi - as specified in IS-GPS-200H
        pi = 3.1415926535898;
        
        % c - [m/s] speed of light as specified in IS-GPS-200H
        c = 2.99792458e8;
        
        % ft2m - Conversion factor multiplied with ft to convert to meters.
        % Derived from 'distdim' MATLAB function.
        ft2m = 0.304800609601219;
    end
end