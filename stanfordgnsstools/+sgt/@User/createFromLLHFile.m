function usrs = createFromLLHFile(llhfile, polyfile)
% createFromLLHFile     create a set of users from a file specifying IDs
% and LLH coordinates
%
%   TODO: describe file format
%
%   usrs = sgt.Users.createFromLLHFile(filename) create a set of
%   users from the LLH information in the file.
%

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% if a polygon file was provided for the bounds for the user, load in the
% polygon vertices to be able to determine the bounds for the polygon
if nargin < 2
    poly = [];
else
    poly = load(polyfile);
end

% load the data into a matrix containing the data from the file
data = load(llhfile);

% split the needed elements given the known structure to the file type
uid = data(:,1);
llh = data(:,2:4);

% create an array of users at the given LLH coordinates with the provided
% IDs and polygon information
usrs = sgt.User(llh, 'ID', uid, 'Polygon', poly);

% NOTE: MAAST needs some metadata on whether or not they are in mexico

% TODO: need to decide where this information would get stored...
% TODO: maybe need to split from the generic user and create a more MAAST
% specific user...