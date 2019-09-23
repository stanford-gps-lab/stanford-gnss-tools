function skewSym = vec2skewSym(vec)
% This function takes in a rotation rate vector and creates a skew matrix.

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