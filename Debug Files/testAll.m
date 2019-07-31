% Test all
clear; close all; clc;

%% Get test file names to be run

testDir = [pwd, '\debugScripts'];
testList = dir(fullfile(testDir, '*.m'));

% Record command prompt
delete testResults.test
diary on
diary testResults.test

%% Test sgt
for i = 1:length(testList)
   run(fullfile(testDir, testList(i).name)); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% If test passes, then the command prompt will be clear %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diary off


