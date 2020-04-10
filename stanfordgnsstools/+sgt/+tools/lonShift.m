function lonOut = lonShift(lonIn)
% lonShift  Shifts longitude from [0, 360) to [-180, 180) degrees.
%
%   sgt.tools.lonShift(lonIn) Shifts the array of Nx1 longitudes by 180 
%   degrees to be in the range -180-180. Input in [deg].

% Copyright 2001-2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% shift everything above 180 deg
lonOut = lonIn - 360 * (lonIn > 180);


end