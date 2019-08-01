function saveUserGrid(obj, fileName, varargin)
% saveUserGrid(fileName, varargin) saves the UserGrid locations in LLH 
% format to a file by the name of [filename].userGrid.
%
% varargin:
% -----
% 'Path' - sets the file path for where the userGrid is saved

% Copyright 2019 Stanford University GPS Laboratory
%   This file is part of the Stanford GNSS Tools which is released under 
%   the MIT License. See `LICENSE.txt` for full license details.
%   Questions and comments should be directed to the project at:
%   https://github.com/stanford-gps-lab/stanford-gnss-tools

% Handle empty call
if nargin < 2
   return; 
end

% Open file
newFileName = [fileName, '.userGrid'];
fildID = fopen(newFileName);

% Create formatSpec
formatSpec = '%f %f %f';

% Parse varargin
if nargin > 2
    res = parseInput(varargin{:});
    
    
    
else
    % Print data to file
    fprintf(fileID, formatSpec, GridPositionLLH)
end




end

% Parse varargin
function res = parseInput(varargin)
% Initialize parser
parser = inputParser;

% Path
validPathFn = @(x) (ischar(x));
parser.addParameter('Path', [], validPathFn)


% Run parser and set results
parser.parse(varargin{:})
res = parser.Results;

end

