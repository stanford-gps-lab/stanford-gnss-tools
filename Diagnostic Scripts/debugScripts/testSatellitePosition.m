function testSatellitePosition()
fprintf('Testing sgt.SatellitePosition: ')

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released
%   under the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

testResults = [];
%% Define test parameters
alm = 'current.alm';

satellite = sgt.Satellite.fromYuma(alm);
time = 0:300:600;

%% Test 1 - Constructor - ECEF
% try
%     tempSatellitePosition = satellite.getPosition(time);
%     pos = tempSatellitePosition
% catch
%    testResults(1) = 1; 
% end

%% Display test results
if any(testResults)
    fprintf('---Failed---\n')
    testResults = find(testResults);
    for i = 1:length(testResults)
        fprintf(['test', num2str(testResults(i)), ' failed\n'])
    end
else
    fprintf('Passed\n')
end