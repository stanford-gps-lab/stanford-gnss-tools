function plotSkyPlot(obj, satellites, time)
% plotSkyPlot  Plot the skyplot for a User (obj) using specified
%   satellites (satellites) at one or multiple times (time).
%
%   sgt.User.plotSkyPlot(obj, satellites, time) plots the
%   skyplot for a user using the specified satellites. If a single time is
%   specified, it shows an instantaneous skyplot. If more than one time is
%   shown, the skyplot will show a trace of the satellite motion through
%   the sky.
%
%   See Also: sgt.User, sgt.Satellite, sgt.SatellitePosition,
%   sgt.Satellite.getPosition, sgt.UserObservation

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

figure; polarscatter(NaN, NaN); hold on; sz = 75; pax = gca; pax.ThetaDir = 'clockwise'; pax.ThetaZeroLocation = 'top';
for i = 1:length(time)
    
    % Get satellitePositions at the times specified in time.
    satellitePositions = satellites.getPosition(time(i), 'ECEF');
    
    % Get user observations from this information
    userObservation = sgt.UserObservation(obj, satellitePositions);
    
    % Plot the satellite positions on a polar plot
    prnInView = find(userObservation.SatellitesInViewMask ~= 0); % Sets the colors of the satellites
    polarscatter(userObservation.AzimuthAngles, 90 - userObservation.ElevationAngles.*180/pi, sz, prnInView, 'filled');
    
    % Text to be added next to each point
    if length(time) == 1
        textStr = cellstr(strcat('PRN ', num2str(prnInView)));
        dx = 0*pi/180; dy = 15;
        text(userObservation.AzimuthAngles+dx, 90 - userObservation.ElevationAngles.*180/pi+dy, textStr)
    end
    
    rlim([0 90])
end

end