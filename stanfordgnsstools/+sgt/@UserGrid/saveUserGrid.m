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

% Edit file name
newFileName = [fileName, '.userGrid'];

% Create formatSpec
formatSpec = '%13.8f\t %13.8f\t %13.8f\r';

% Parse varargin
if nargin > 2
    res = parseInput(varargin{:});
    
    % add path to file name
    if (~isempty(res.Path))
        newFileName = [res.Path, '\', newFileName];
        if (exist(res.Path, 'dir') ~= 7)
           mkdir(res.Path); 
        end
    end
    
end

% Open file
fileID = fopen(newFileName, 'w+');
% Print data to file
fprintf(fileID, formatSpec, obj.GridPositionLLH');

% Close file
fclose(fileID);

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

