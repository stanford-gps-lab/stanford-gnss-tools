classdef UserGrid < matlab.mixin.Copyable
% UserGrid  a model for a UserGrid containing meta data of all users.
%   A UserGrid is a container for a distribution of locations that users
%   occupy. A UserGrid will also contain all user objects as a property.
%
%   userGrid = sgt.UserGrid(posLLH, varargin) creates user(s) at the (lat 
%   [deg], lon [deg], alt [m]) positions specified in posLLH. posLLH should 
%   be an Nx3 matrix for the creation of N users. userGrid contains meta
%   data concerning the users that have been created.
%
%   See Also: sgt.User, sgt.UserGrid.createUserGrid,
%   sgt.UserGrid.createFromLLHFile
%
%   varargin:
%   -----
%   'GridName' - A character string that denotes the name of the user grid.
%   -----
%   'PolygonFile' - A polygon file that contains a list of [lat, lon] positions
%   that define a geographic region. This file will be converted into a
%   polyshape object and will be saved in the property 'Polygon'.

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

properties
    % GridName - Name given to the grid used. This property is used when
    % saving user grid information.
    GridName = [];
    
    % GridPositionLLH - LLH position of all users in the UserGrid. Defined
    % as [lat, lon, alt] in [deg, deg, m]. Will be an Nx3 matrix for N
    % users.
    GridPositionLLH
    
    % GridPositionECEF - ECEF position of all users in the UserGrid.
    % Defined as [x, y, z] in [m, m, m]. Will be an Nx3 matrix for N users.
    GridPositionECEF
    
    % Polygon - a polyshape object that defines a geographic boundary in
    % terms of a series of [lat, lon] positions.
    Polygon = [];
    
    % Users - a single user or group of user objects.
    Users
    
end

% Constructor
methods
    function obj = UserGrid(posLLH, varargin)
        
        % Handle empty constructor
        if nargin < 1
            obj.GridPositionLLH = [];
            obj.GridPositionECEF = [];
            obj.Users = [];
            return;
        end
        
        % Store user locations in GridPositionLLH
        obj.GridPositionLLH = posLLH;
        
        % Convert user LLH positions to ECEF and store in GridPositionECEF
        obj.GridPositionECEF = sgt.tools.llh2ecef(posLLH);
        
        % Create users from posLLH
        obj.Users = sgt.User(posLLH, varargin{:});
        
        % Parse and handle varargin
        if nargin > 1
            % Parse varargin inputs
            res = parseInput(varargin{:});
            
            % Store polygon
            if ~isempty(res.PolygonFile)
                obj.Polygon = sgt.tools.generatePolygon(res.PolygonFile);
            end
            
            % Store GridName
            if ~isempty(res.GridName)
                obj.GridName = res.GridName;
            end
        end
    end
    
end

methods
    % Method to plot users on Mercator projection
    
    % Method to plot users on a globe (perhaps just make a 'plot' function
    % with a varargin for Mercator?)
end

% Static Methods
methods (Static)
    userGrid = createFromLLHFile(llhfile, polyfile)
    userGrid = createUserGrid(varargin)
    
end
end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% Polygon
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn)

% GridName
validGridNameFn = @(x) (ischar(x));
parser.addParameter('GridName', [], validGridNameFn)

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end






