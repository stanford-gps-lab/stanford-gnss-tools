classdef Satellite < matlab.mixin.Copyable
% Satellite     an almanac based representation of a satellite in orbit.
%
%   satellite = sgt.Satellite(prn, eccentricity, toa, inclination, 
%   rateOfRightAscension, sqrta, raan, argumentOfPerigee, meanAnomaly, af0, 
%   af1, varargin) create a satellite, or a list of satellites
%   from the specified almanac parameters.  Each parameter can
%   either be a scalar or a column vector of length N for
%   creating a list of N satellites.  If creating an array of
%   satellites, all the inputs must be column vectors of the
%   same length.
%
%   varargin arguments:
%
%   See Also: sgt.Satellite.fromAlmMatrix,
%   sgt.Satellite.fromYuma

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of stanford-gnss-tools which is released under the 
%   MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/maast

    % the almanac properties -> can only be set in the constructor
    properties(SetAccess = immutable)
        % PRN - the satellite PRN code
        PRN
        
        % Eccentricity - the eccentricity
        Eccentricity
        
        % TOA - time of applicability for these parameters in [sec]
        TOA
        
        % Inclination - inclination of the orbit in [rad]
        Inclination
        
        % RateOfRightAscension - the rate of right ascension (Omega dot) in
        % [rad/sec]
        RateOfRightAscension
        
        % SqrtA - square root of the semi-major axis (a) in [m^(1/2)]
        SqrtA
        
        % RightAscension - right ascension at the time of applicability
        % (Omega_0) in [rad]
        RAAN
        
        % ArgumentOfPerigee - argume of perigee (omega) in [rad]
        ArgumentOfPerigee
        
        % MeanAnomaly - the mean anomaly (M) in [rad]
        MeanAnomaly
        
        % AF0 - clock bias [sec]
        AF0
        
        % AF1 - clock drift [sec/sec]
        AF1
    end

    % the derived properties
    properties (Dependent, SetAccess = protected)
        % Period - the orbital period of the satellite in [sec]
        Period
        
        % the mean motion of the satellite in [1/sec]
        n
    end

    % Constructor
    methods

        function obj = Satellite(prn, eccentricity, toa, inclination,...
                rateOfRightAscension, sqrta, raan, argumentOfPerigee,...
                meanAnomaly, af0, af1, varargin)
            
            % need to allow for an empty constructor for list creation
            if nargin == 0
                obj.PRN = NaN;
                return;
            end
            
            % make sure there are enough inputs
            if nargin < 11
                error('not enough input parameters');
            end

            Nsats = length(prn);

            % create a list of satellites given the number of satellites
            obj(Nsats) = sgt.Satellite();

            % convert each row of information to satellite data
            for i = 1:Nsats
                obj(i).PRN = prn(i);
                obj(i).Eccentricity = eccentricity(i);
                obj(i).TOA = toa(i);
                obj(i).Inclination = inclination(i);
                obj(i).RateOfRightAscension = rateOfRightAscension(i);
                obj(i).SqrtA = sqrta(i);
                obj(i).RAAN = raan(i);
                obj(i).ArgumentOfPerigee = argumentOfPerigee(i);
                obj(i).MeanAnomaly = meanAnomaly(i);
                obj(i).AF0 = af0(i);
                obj(i).AF1 = af1(i);
            end
        end

        % define the dependent property 
        
        function period = get.Period(obj)
            period = NaN;
        end

        function n = get.n(obj)
            n = NaN;
        end

    end

    % non-static methods
    methods
        % Get Position in ECEF at specified time
        position = getPosition(obj, time, frame)

    end

    % static methods
    methods (Static)
        satellite = fromAlmMatrix(alm)
        satellite = fromYuma(filename)
    end

end