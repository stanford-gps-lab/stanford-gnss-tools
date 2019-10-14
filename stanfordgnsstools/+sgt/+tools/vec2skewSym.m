function skewSym = vec2skewSym(vec)
% This function takes in a rotation rate vector and creates a skew matrix.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Check inputs
if (length(vec) ~= 3)
    error('vector of improper length')
end

% Preallocate
skewSym = zeros(3);

% Allocate terms
skewSym(1,2) = -vec(3);
skewSym(1,3) = vec(2);
skewSym(2,1) = vec(3);
skewSym(2,3) = -vec(1);
skewSym(3,1) = -vec(2);
skewSym(3,2) = vec(1);
end