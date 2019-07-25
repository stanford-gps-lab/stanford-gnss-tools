% Test all
clear; close all; clc;

%% Record home directory
homedir = pwd;

%% Go into test directory
testdir = [pwd, '\debugScripts'];
cd(testdir)

%% Test sgt
testSatellite();
testFromYuma();
testFromAlmMatrix();
testUser();

%% back to home directory
cd(homedir)
