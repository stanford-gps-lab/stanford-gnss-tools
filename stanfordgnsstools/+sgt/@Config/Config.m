classdef Config < matlab.mixin.Copyable
    % Config     a container for test configuration input parameters.
    %
    %    sgt.Config() creates an object that will store configuration
    %    variables input to simulations. These inputs can be referenced in
    %    the future and can clarify the inputs used in past simulations.
    
    % Copyright 2019 Stanford University GPS Laboratory
    %   This file is part of the Stanford GNSS Tools which is released
    %   under the MIT License. See `LICENSE.txt` for full license details.
    %   Questions and comments should be directed to the project at:
    %   https://github.com/stanford-gps-lab/stanford-gnss-tools
    
    % Public Properties
    properties
        % Satellite - Inputs to constructor for sgt.Satellite
        Satellite
        
        % SatelliteMethodfromAlmMatrix - Inputs to static constructor
        % Satellite.fromAlmMatrix
        SatelliteMethodfromAlmMatrix
        
        
    end
end