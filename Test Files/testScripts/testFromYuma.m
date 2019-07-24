function testFromYuma()
disp('-----------------')
disp('Testing fromYuma.m')
disp('-----------------')

%% Test yuma file
sgt.Satellite.fromYuma('current.alm')
