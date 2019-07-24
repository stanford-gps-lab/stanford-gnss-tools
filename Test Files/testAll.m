% Test all
clear; close all; clc;

%% Record home directory
homedir = pwd;

%% Go into test directory
testdir = [pwd, '\testScripts'];
cd(testdir)

%% Test sgt
testSatellite();

%% back to home directory
cd(homedir)