function testFromYuma()
disp('-----------------')
disp('Testing fromYuma.m')
disp('-----------------')

%% Test 1 - basic
try
    test1 = sgt.Satellite.fromYuma('current.alm');
    
    disp('test1 passed')
    
catch
    disp('test1 failed')
end

%% Test 2 - Incomplete Almanac
try
    test2 = sgt.Satellite.fromYuma('badCurrent.alm');
    
    disp('test2 failed')
catch
    disp('test2 passed')
end





