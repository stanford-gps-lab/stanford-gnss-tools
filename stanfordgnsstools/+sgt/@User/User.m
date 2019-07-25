classdef User < matlab.mixin.Copyable
% User 	a model for a user at a specific location.
%   A user is a container for a fixed location from which observations or
%   frame transformations can take place.
%
%   user = sgt.User(posLLH, varargin) creates user(s) at the (lat, lon, alt)
%   positions specified in posllh.  posllh should be an Nx3 matrix for the
%   creation of N users with each row containing the (lat, lon, alt) of the
%   user in [deg, deg, m].
%
%   varargin: 
%   ID - the ID of the user
%   Polygon - 
%   ElevationMask - Elevation mask of users. Default 5 degrees.         

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
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

		function obj = User(posllh, varargin)
            
            % if no arguments, default to all zero
            if nargin == 0
                obj.PositionLLH = zeros(3,1);
                obj.PositionECEF = zeros(3,1);
                obj.ECEF2ENU = zeros(3,3);
                return;
            end
            
            if nargin > 1
                % Parse varargin
                res = parseInput(varargin{:});
                
            end
            
            % NOTES: posllh right now has to be a matrix with N rows (for N
            % sites) where each row contains [lat lon alt] in [deg, deg, m]
            % for each of the sites.

            % get the number of users
            [Nusers, ~] = size(posllh);
            obj(Nusers) = sgt.User();

            % Record lat and lon of input positions in radians
            latRad = posllh(:,1)*pi/180;
            lonRad = posllh(:,2)*pi/180;

            % Convert the LLH positions to ECEF positions
            posECEF = sgt.tools.llh2ecef(posllh);
            
            % set user IDs
            ids = 1:Nusers;
            if (exist('res', 'var') == 1) && (isfield(res, 'ID') == 1) && ~isempty('res.ID')
                ids = res.ID;
                
                % Check for varargin errors
                checkInputs(res, Nusers)
            end
            
            % check which points are within the polygon
            inBnds = false(Nusers,1);
            if (exist('res.Polygon', 'var') == 1)
                poly = res.Polygon;
                polycheck = inpolygon(posllh(:,2), posllh(:,1), poly(:,2), poly(:,1));
                inBnds = (polycheck > 0);  % inpolygon returns 0.5 in some versions of MATLAB
            end
            
            % expand the elevation mask if only a single value
            if (exist('res.ElevationMask', 'var') == 1)
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
                obj(i).PositionLLH = posllh(i,:)';
                obj(i).PositionECEF = posECEF(i,:)';
                obj(i).InBound = inBnds(i);
                obj(i).ElevationMask = elMask(i);

                % precompute the matrix for the rotation from ECEF to ENU
                lat = latRad(i);
                lon = lonRad(i);
                obj(i).ECEF2ENU = [
                    -sin(lon)         ,  cos(lon)         , 0;
                    -sin(lat)*cos(lon), -sin(lat)*sin(lon), cos(lat);
                     cos(lat)*cos(lon),  cos(lat)*sin(lon), sin(lat)];
            end
           
        end

    end

    methods
        % TODO: make a helepr function for getting the user observations
%         obs = getUserObservations(obj)
        plot(obj)
    end

	methods (Static)
        % TODO: want constructors to make different grid types
%         objs = createUserGrid(numSites)
        usrs = createFromLLHFile(llhfile, polyfile)
        usrs = createUserGrid(polyfile, latstep, lonstep)
	end


end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% ID
validIDFn = @(x) (isnumeric(x));
parser.addParameter('ID', [], validIDFn);

% Polygon
parser.addParameter('Polygon', []);

% ElevationMask
parser.addParameter('ElevationMask', 5*pi/180);

% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end

% Check inputs
function checkInputs(res, Nusers)
% Check that the number of IDs is the same as the number of users.
if (numel(res.ID) ~= Nusers) && (numel(res.ID) > 1)
   error('Number of varargin inputs larger than the number of satellites specified.') 
end







end


