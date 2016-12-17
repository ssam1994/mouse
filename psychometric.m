clear all

%Store data for each session in a single struct
SessionDataFolder = char('C:\Bpod\Data\M1\InitiateTrial\Session Data\');
s = what(SessionDataFolder); %change dir for your directory name 
matfiles = s.mat;
numSessions = numel(matfiles);
emptySession = struct('SessionName', 0, ...
    'TotalCorrect', 0, ...
    'TrialTypes', 0, ...
    'nTrials', 0, ...
    'RawEvents', 0, ...
    'RawData', 0, ...
    'TrialStartTimestamp', 0);
SessionMatrix = repmat(emptySession, numSessions, 1);
ydata = zeros(numSessions, 1);
for i = 1:numSessions
    pIndex = find(char(matfiles(i))=='.', 1) - 1;
    fileString = char(matfiles(i));
    SessionData = LoadSessionData(SessionDataFolder, fileString);
    SessionMatrix(i) = SessionData;
    ydata(i) = SessionData.TotalCorrect / SessionData.nTrials;
end

%Plot psychometric curve for correctness over sessions
x = 1:0.1:numSessions;
alpha = (numSessions+1)/2;
beta = 0.3;
plot(x,1./(1+exp(-(x-alpha)./beta)), 'k-')
title('Curve for Mouse X over Time');
xlabel('Session #');
ylabel('Fraction of Correct Choices');
hold on
plot(ydata, 'bo');
