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

%% back to home directory
cd(homedir)
