function obj = fromAlmMatrix(alm, varargin)
% fromAlmMatrix     compatibility function to create a satellite list from
% the `alm_param` matrix.
%   sats = sgt.Satellite.fromAlmMatrix(alm) creates a list of
%   Satellites with the almanac properties as defined in the alm matrix.
%   The alm matrix is defined as follows:
%    1    2    3    4     5    6       7       8          9     10  11
%   PRN ECCEN TOA INCLIN RORA SQRT_A R_ACEN ARG_PERIG MEAN_ANOM AF0 AF1
%    -    -   sec  rad    r/s m^(1/2) rad     rad        rad     s  s/s
%
%   provides compatibility with almanac handling for MAAST before v2
%
%   See Also: sgt.Satellite.fromYuma, sgt.Satellite

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

if nargin < 2
    % call the satellite constructor with each of the columns separated out
    obj = sgt.Satellite(alm(:,1), alm(:,2), alm(:,3), alm(:,4), ...
        alm(:,5), alm(:,6), alm(:,7), alm(:,8), ...
        alm(:,9), alm(:,10), alm(:,11));
else
    obj = sgt.Satellite(alm(:,1), alm(:,2), alm(:,3), alm(:,4), ...
        alm(:,5), alm(:,6), alm(:,7), alm(:,8), ...
        alm(:,9), alm(:,10), alm(:,11), varargin{:});
end

if nargin > 2
    res = parsefromAlmMatrixInput(varargin{:});
    
    if (exist('res', 'var')) && (isfield('res', 'Config')) && (isa(res.Config{1}, 'sgt.Config'))
        res.Config{1}.SatelliteMethodfromAlmMatrix = {'AlmMatrix', alm};
    end
end

end

% Parse varargin
function res = parsefromAlmMatrixInput(varargin)
% Initialize parser
parser = inputParser;

% Constellation
validConstellationFn = @(x) (ischar(x) || iscellstr(x)); %#ok<ISCLSTR>
parser.addParameter('Constellation', 'GPS', validConstellationFn)

% Config
validConfigFn = @(x) (isa(x, 'sgt.Config'));
parser.addParameter('Config', false, validConfigFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end
