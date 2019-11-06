function euler = quat2Euler(quat)
% This function takes N quaternion vectors as an input (4xN) and outputs a
% (3xN) matrix of respective Euler angles. These are 1-2-3 Euler angles
% [rad].

% Flip quat to be 4xN
[r,c] = size(quat);
if (r == 4) % Nominal case
    N = c;
elseif (r ~= 4) && (c == 4)
    quat = quat';
    N = r;
else
    warning('improper quaternion format input')
end

% Preallocate euler angles
euler = zeros(3,N);

% Assign values to euler angles
euler(1,:) = atan2(2*(quat(1,:).*quat(2,:) + quat(3,:).*quat(4,:)),...
    1 - 2*quat(2,:).^2 - 2*quat(3,:).^2);
euler(2,:) = asin(2*(quat(1,:).*quat(3,:) - quat(2,:).*quat(4,:)));
euler(3,:) = atan2(2*(quat(1,:).*quat(4,:) + quat(2,:).*quat(3,:)),...
    1 - 2*quat(3,:).^2 - 2*quat(4,:).^2);
end