classdef UserObservation < matlab.mixin.Copyable
    % UserObservation   an container for an observation for a user.
    %   An observation ties a User and Satellites together at a specific
    %   time and provides data on the relationship between those two group.
    %   Allows for later querying of satellites in view, etc.
    %
    %   obs = sgt.UserObservation(user, satPos) creates an observation
    %   for a given user and an array of satellite positions (satPos).
    %   satPos must be a SxT matrix of SatellitePosition objects.  The
    %   resulting obs array will be a 1xT array of UserObservation objects
    %   for each time step.
    %
    % See Also: sgt.User, sgt.SatellitePosition
    
    % Copyright 2019 Stanford University GPS Laboratory
    %   This file is part of the Stanford GNSS Tools which is released
    %   under the MIT License. See `LICENSE.txt` for full license details.
    %   Questions and comments should be directed to the project at:
    %   https://github.com/stanford-gps-lab/stanford-gnss-tools
    
    % Protected Properties
    properties (SetAccess = protected)
        % UserID - the user for this observation
        UserID
        
        % SatellitePRN - PRN list of the satellites for this observation
        SatellitePRN
        
        % t - Time at which the userObservation is recorded
        t

        % LOSecef - the ECEF line of sight vectors
        %   this is a Sx3 matrix containing the LOS unit vector in the ECEF
        %   frame to each of the S satellites as rows
        LOSecef
        
        % LOSenu - the ENU line of sight vectors
        %   this is a Sx3 matrix containing the LOS unit vector in the ENU
        %   frame to each of the S satellites as rows
        LOSenu
        
        % EleveationMask - elevation mask angle for the user.
        ElevationMask
        
        % SatellitesInViewMask - mask for which satellites are in view
        %   a logical array of length S indicating which satellite
        %   positions contain a satellite that it is view of the user
        SatellitesInViewMask
        
        % ElevationAngles - the elevation angles to the satellites in view
        % as a column vector of length Sinview
        ElevationAngles
        
        % AzimuthAngles - the azimuth angles to the satellites in view as a
        % column vector of length Sinview
        AzimuthAngles
        
        % NumSatellitesInView - the number of satellites in view
        NumSatellitesInView
        
        % Range - the range to each of the satellites in view as a column
        % vector of length Sinview
        Range
    end
    
    % Constructor
    methods
        function obj = UserObservation(user, satellitePosition)
            
            % handle the empty constructor for vector creation
            if nargin == 0
                return;
            end
            
            % NOTE: satPos is a SatellitePosition object which will return
            % a 1xT array of observations
            [~, T] = size(satellitePosition);
            
            for i = 1:T
                obj(i).t = satellitePosition(1,i).t;
                
                % run the math to populate all of the properties that are a
                % function of the user and the satellite positions
                obj(i).calculateObservationData(user, satellitePosition(:,i));
            end
            
            % Set properties
            [obj.UserID] = deal(user.ID);
            [obj.SatellitePRN] = deal([satellitePosition(:,1).SatellitePRN]);
            [obj.ElevationMask] = deal(user.ElevationMask);
        end
    end
    
    % Public Methods
    methods
        geometryMatrix = getGeometryMatrix(obj)
        gdop = getGDOP(obj)
        pdop = getPDOP(obj)
        tdop = getTDOP(obj)
        hdop = getHDOP(obj)
        vdop = getVDOP(obj)
        plotSkyPlot(obj)
        riseTime = calculateRiseTime(obj, user, satellite);
    end
    
    % Protected Methods
    methods (Access = protected)
        calculateObservationData(obj, user, satellitePosition)
    end
end









