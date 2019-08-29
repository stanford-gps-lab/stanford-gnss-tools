classdef User < matlab.mixin.Copyable
    % User 	a model for a user at a specific location.
    %   A user is a container for a fixed location from which observations
    %   or frame transformations can take place.
    %
    %   user = sgt.User(posLLH, varargin) creates user(s) at the (lat, lon,
    %   alt) positions specified in posLLH.  posLLH should be an Nx3 matrix
    %   for the creation of N users with each row containing the (lat, lon,
    %   alt) of the user in [deg, deg, m]. For meta data concerning all
    %   users, see sgt.UserGrid.
    %
    %   See Also: sgt.UserGrid, sgt.UserGrid.createUserGrid,
    %   sgt.UserGrid.createFromLLHFile
    %
    %   varargin:
    %   -----
    %   ID - the ID of the user
    %   -----
    %   PolygonFile - specifies the name of a polyfile that bounds a
    %   geographic region. See sgt.tools.generatePolygon
    %   -----
    %   ElevationMask - Elevation mask of users [rad]. Default 5 degrees.
    
    % Copyright 2019 Stanford University GPS Laboratory
    %   This file is part of the Stanford GNSS Tools which is released
    %   under the MIT License. See `LICENSE.txt` for full license details.
    %   Questions and comments should be directed to the project at:
    %   https://github.com/stanford-gps-lab/stanford-gnss-tools
    
    properties
        % ID - the ID of the user
        ID
        
        % PositionLLH - LLH position of the user on the world latitude and
        % longitude are defined in [deg deg m]. N users are defined
        % by an Nx3 matrix.
        PositionLLH
        
        % PositionECEF - ECEF position of the user on the world in [m]. N
        % users are defined by an Nx3 matrix.
        PositionECEF
        
        % ECEF2ENU - the rotation matrix from ECEF to ENU for this user
        ECEF2ENU
        
        % ElevationMask - elevation mask for which to consider satellites
        % in view in [rad]
        ElevationMask = 5 * pi/180
        
        % InBound - true if the user is within a specified polygon if the
        % user was created with a polygon bound, this will be flagged true
        % if the user is within the bound and false otherwise.  If no
        % polygon bound was provided InBound will default to false
        InBound = false
        
    end
    
    % Constructor
    methods
        
        function obj = User(posLLH, varargin)
            % if no arguments, default to all zero
            if nargin == 0
                obj.ID = 1;
                obj.PositionLLH = [37.427127, -122.173243, 17]';     % Stanford GPS Lab Location
                obj.PositionECEF = [sgt.tools.llh2ecef(obj.PositionLLH')]';
                obj.ECEF2ENU = sgt.tools.ecef2enu(obj.PositionLLH);
                return;
            end
            
            if nargin > 1
                % Parse varargin
                res = parsesgtUserInput(varargin{:});
            end
            
            % get the number of users
            [Nusers, numCoord] = size(posLLH);
            
            % Make sure posLLH is a row vector
            if (numCoord ~= 3)
                posLLH = posLLH';
                [Nusers, numCoord] = size(posLLH);
                if (numCoord ~= 3)
                    error('Wrong number of elements for posLLH')
                    % This will not catch a user inputting a 3x3 matrix
                    % with posLLH as column vectors.
                end
            end
            
            % Shift longitude
            posLLH(:,2) = sgt.tools.lonShift(posLLH(:,2));
            
            % Convert the LLH positions to ECEF positions
            posECEF = sgt.tools.llh2ecef(posLLH);
            
            % set user IDs
            ids = 1:Nusers;
            if (exist('res', 'var') == 1) && (isfield(res, 'ID') == 1) && ~isempty(res.ID)
                ids = res.ID;
                
                % Check for varargin errors
                checksgtUserInputs(res, Nusers)
            end
            
            % check which points are within the polygon
            inBnds = false(Nusers,1);
            if (exist('res', 'var') == 1) && isfield(res, 'PolygonFile') && ~isempty(res.PolygonFile)
                polygon = sgt.tools.generatePolygon(res.PolygonFile);
                polycheck = inpolygon(posLLH(:,2), posLLH(:,1), polygon.Vertices(:,1), polygon.Vertices(:,2));
                inBnds = (polycheck > 0);  % inpolygon returns 0.5 in some versions of MATLAB
            end
            
            % expand the elevation mask if only a single value
            if (exist('res', 'var') == 1) && isfield(res, 'ElevationMask') && ~isempty(res.ElevationMask)
                if length(res.ElevationMask) == 1
                    elMask = res.ElevationMask * ones(Nusers,1);
                elseif length(res.ElevationMask) == Nusers
                    elMask = res.ElevationMask;
                else
                    error('Number of elevation masks specified does not match the number of users')
                end
            else
                elMask = obj(1).ElevationMask * ones(Nusers, 1);
            end
            
            % create the user object for each site
            for i = 1:Nusers
                % directly just save the LLH and the ECEF positions to the
                % user object
                obj(i).ID = ids(i);
                obj(i).PositionLLH = posLLH(i,:)';
                obj(i).PositionECEF = posECEF(i,:)';
                obj(i).InBound = inBnds(i);
                obj(i).ElevationMask = elMask(i);
                
                % precompute the matrix for the rotation from ECEF to ENU
                obj(i).ECEF2ENU = sgt.tools.ecef2enu(obj(i).PositionLLH);
            end
        end
    end
    
    % Protected Methods
    methods (Access = protected)
       res = parsesgtUserInput(varargin)
       checksgtUserInputs(res, Nusers)
    end
end

% Parse varargin
function res = parsesgtUserInput(varargin)
% Initialize parser
parser = inputParser;

% ID
validIDFn = @(x) (isnumeric(x));
parser.addParameter('ID', [], validIDFn);

% Polygon
validPolygonFileFn = @(x) (ischar(x));
parser.addParameter('PolygonFile', [], validPolygonFileFn);

% ElevationMask
validElevationMaskFn = @(x) (isnumeric(x)) & all((abs(x) < 90*pi/180));
parser.addParameter('ElevationMask', 5*pi/180, validElevationMaskFn);

% Varargins that may be passed through UserGrid
parser.addParameter('GridName', []);

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end

% Check inputs
function checksgtUserInputs(res, Nusers)
% Check that the number of IDs is the same as the number of users.
if (numel(res.ID) ~= Nusers) && (numel(res.ID) > 1)
    error('Number of varargin inputs larger than the number of satellites specified.')
end

end









