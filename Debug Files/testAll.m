% Test all
clear; close all; clc;

%% Record home directory
homedir = pwd;

%% Go into test directory

testdir = [pwd, '\debugScripts'];
% Record command prompt
delete testResults.test
diary on
diary testResults.test
cd(testdir)

%% Test sgt
testSatellite();
testFromYuma();
testFromAlmMatrix();
testUser();
testGeneratePolygon();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% If test passes, then the command prompt will be clear %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% back to home directory
cd(homedir)
diary off


