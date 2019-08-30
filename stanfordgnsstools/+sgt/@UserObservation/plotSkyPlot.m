function plotSkyPlot(obj)
% plotSkyPlot  Plot the skyplot for a set of user observations (obj)
%
%   sgt.UserObservation.plotSkyPlot(obj) plots the skyplot for a user using
%   the specified satellite positions. If a single satellite position is
%   specified, it shows an instantaneous skyplot. If more than one 
%   satellite position object is input, the skyplot will show a trace of 
%   the satellite motion through the sky.
%
%   See Also: sgt.UserObservations, sgt.Satellite, sgt.SatellitePosition,
%   sgt.Satellite.getPosition,

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

figure; polarscatter(NaN, NaN); hold on; sz = 75; pax = gca; 
pax.ThetaDir = 'clockwise'; pax.ThetaZeroLocation = 'top'; pax.RTick = [0, 20, 40, 60, 80];
pax.RTickLabel = {'90'; '70'; '50'; '30'; '10'};
prn = obj(1).SatellitePRN';
for i = 1:length(obj)  
    % Plot the satellite positions on a polar plot
    prnInView = prn(obj(i).SatellitesInViewMask);
    svInView = obj(i).SatellitesInViewMask;
    polarscatter(obj(i).AzimuthAngles(svInView), 90 - obj(i).ElevationAngles(svInView).*180/pi, sz, prnInView, 'filled');
    
    % Text to be added next to each point
    if length(obj) == 1
        textStr = cellstr(strcat('PRN ', num2str(prnInView)));
        dx = 0*pi/180; dy = 10;
        text(obj(i).AzimuthAngles(svInView)+dx, 90 - obj(i).ElevationAngles(svInView).*180/pi+dy, textStr)
    end   
end
rlim([0 90])

% Plot the elevation mask
polarplot(linspace(0,2*pi,100), 90 - obj(1).ElevationMask*180/pi.*ones(100,1), 'b--')

end