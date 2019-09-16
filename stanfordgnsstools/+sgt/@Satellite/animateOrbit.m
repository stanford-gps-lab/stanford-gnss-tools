function F = animateOrbit(obj, time, varargin)
% Plots the orbits over a series of time stamps and creates an animation
% from them. return the handle of the animation object.

% time must be a vector with more than one element
if (length(time) == 1)
   obj.plotOrbit(time, varargin{:});
   F = [];
   return;
end

% Plot Orbits and add to animation
figure('units','normalized','outerposition',[0 0 1 1]);
F(length(time)) = struct('cdata',[],'colormap',[]);
for i = 1:length(time)
    cla reset;
    obj.plotOrbit(time(i), varargin{:});
    set(gca,'Color','k')
    drawnow
    F(i) = getframe(gcf);
end

% % Write video
% writerObj = VideoWriter('myVideo', profile);
end