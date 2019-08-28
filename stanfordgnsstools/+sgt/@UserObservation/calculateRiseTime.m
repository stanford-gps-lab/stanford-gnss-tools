function [] = calculateRiseTime(obj)
% Calculate the time at which satellites rise above the horizon for this
% user.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Number of objects
numObj = length(obj);

% Number of satellites
numSats = length(obj(1).SatellitesInViewMask);

% Get unique vector of times and include times before simulation start
tempTime = [obj.SatellitePosition];
tempTime = unique([tempTime.t]');
if (length(tempTime) > 1)
    tempTimeDiff = tempTime(end) - tempTime(end-1);     % Assumes evenly distributed time array
else
    tempTimeDiff = 300;  % If one time is input, set a time difference for calculations
end
time = tempTime(1)-12000:tempTimeDiff:tempTime(end)-1;    % Full time vector
timeLength = length(time);  % Length of time array

% Calculate Satellite Positions over extended time
satellite = [obj(1).SatellitePosition.Satellite];
satellitePosition = satellite.getPosition(time);

% Preallocate
[S, ~] = size(satellitePosition);
elevationAngleMat = NaN(S, timeLength);

% Get elevation angles over extended time
for i = 1:timeLength
    satellitePositionMat = [satellitePosition(:,i).ECEF];
    losecef = satellitePositionMat - repmat(obj(1).User.PositionECEF, 1, S);
    r = vecnorm(losecef);
    losecef = losecef ./ repmat(r, 3, 1);
    losenu = obj(1).User.ECEF2ENU * losecef;
    elevationAngleMat(:,i) = asin(losenu(3,:)');
end

% Get user elevation mask
elevationMask = obj(1).User.ElevationMask;

% Preallocate
indRise = cell(numSats, 1);
riseTime = cell(numSats, 1);

% Find rise time for each satellite
for i = 1:numSats
    % Find index when satellites first viewed above the elevation mask
    indRise{i} = [];
    tempElevationAngleArray = elevationAngleMat(i,:);
    indRise{i} = find(tempElevationAngleArray(2:end) > elevationMask &...
        tempElevationAngleArray(1:end-1) < elevationMask) + 1;

    % Find time at which the satellites rise above the horizon using a
    % quadratic fit
    
    % Number of rise times
    numRiseTimes = length(indRise{i});
    
    % Preallocate obj.RiseTime
    riseTime{i} = NaN(numRiseTimes, 1);
    
    % Temporary storage for Rise indexes
    tempIndRise = indRise{i};
    
    for j = 1:numRiseTimes
        % Find difference between current elevation angle and elevation
        % mask
        diffCurrent = abs(tempElevationAngleArray(tempIndRise(j)) - elevationMask);
        
        % Find difference between previous elevation angle and elevation
        % mask
        diffPrevious = abs(tempElevationAngleArray(tempIndRise(j)-1) - elevationMask);
        
        if (tempIndRise(j) == length(tempElevationAngleArray)) || ((diffPrevious < diffCurrent) && (tempIndRise(j) > 2))   % Conditional statement for end time or if previous alevation angle is closer to the elevation mask than current elevation angle (better for accuracy)
            riseTime{i}(j) = ceil(quadfit(...
                elevationMask,...
                [time(tempIndRise(j)-2), time(tempIndRise(j)-1), time(tempIndRise(j))],...
                [tempElevationAngleArray(tempIndRise(j)-2), tempElevationAngleArray(tempIndRise(j)-1),tempElevationAngleArray(tempIndRise(j))]));
        else
            riseTime{i}(j) = ceil(quadfit(...
                elevationMask,...
                [time(tempIndRise(j)-1), time(tempIndRise(j)), time(tempIndRise(j)+1)],...
                [tempElevationAngleArray(tempIndRise(j)-1), tempElevationAngleArray(tempIndRise(j)),tempElevationAngleArray(tempIndRise(j)+1)]));
        end
        
    end
end

% Temporary
for i = 1:numObj
    obj(i).RiseTime = riseTime;
end
end

function x0 = quadfit(y0,x,y)
% interpolates 3 points in (x,y) quadratically to get fourth point x0 given y0
% Two possible answers.  The one with a positive slope is returned.

mu=mean(x);
x=x(:) - mu;
y=y(:);
a = inv([x.*x x ones(3,1)])*y;
if a(1)==0
    x0 = (y0-a(3))/a(2) + mu;
else
    x0_1 = (-a(2)+sqrt(a(2)*a(2)-4*a(1)*(a(3)-y0)))/2/a(1);
    x0_2 = -a(2)/a(1)-x0_1;
    if a(1)>0
        x0 = max(x0_1,x0_2) + mu;
    else
        x0 = min(x0_1,x0_2) + mu;
    end
end
end
