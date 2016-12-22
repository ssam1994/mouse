%**********************************************
%Store data for each session in a single struct
%**********************************************
function [SessionMatrix, yData] = LoadMouseSessions(SessionDataPath)
%Change directory to correcy folder
SessionDataFolder = SessionDataPath;
s = what(SessionDataFolder);
matfiles = s.mat;

%Initialize variables to store session data
numSessions = numel(matfiles);
emptySession = struct('SessionName', 0, ...
    'TotalRewards', 0, ...
    'TrialTimeouts', 0, ...
    'TrialTypes', 0, ...
    'nTrials', 0, ...
    'RawEvents', 0, ...
    'RawData', 0, ...
    'TrialStartTimestamp', 0);
SessionMatrix = repmat(emptySession, numSessions, 1);
yData = zeros(numSessions, 1);
MedianTimeouts = zeros(numSessions, 1);

%Fill struct SessionMatrix with data from each session
for i = 1:numSessions
    fileString = char(matfiles(i));
    SessionData = LoadSessionData(SessionDataFolder, fileString);
    SessionMatrix(i) = SessionData;
    %yData is proportion correct guesses
    yData(i) = SessionData.TotalRewards / (SessionData.nTrials + sum(SessionData.TrialTimeouts));
    MedianTimeouts(i) = median(SessionData.TrialTimeouts);
end
end