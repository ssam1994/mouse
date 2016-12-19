%**********************************************
%Store data for a single session in a struct
%**********************************************
function data = LoadSessionData(SessionDataFolder, SessionFileName)
%Plot results for 2AFC from Bpod.
load([SessionDataFolder SessionFileName])

%Define new variables for Session Data Fields
TrialTypes = SessionData.TrialTypes;
nTrials = SessionData.nTrials;
RawEvents = SessionData.RawEvents;
RawData = SessionData.RawData;
TrialStartTimestamp = SessionData.TrialStartTimestamp;
%Settings = SessionData.Settings;

%Get timestamps of reward times
RewardTimes = zeros(nTrials);
TrialTimeouts = zeros(1, nTrials);
for i = 1:nTrials
    TrialStates = RawEvents.Trial{1, i}.States;
    LeftReward = TrialStates.LeftReward;
    RightReward = TrialStates.RightReward;
    
    %remove NaN values
    LeftReward(isnan(LeftReward)) = 0;
    RightReward(isnan(RightReward)) = 0;
    
    %Add reward time for left or right to RewardTimes
    if LeftReward(1) > 0
        RewardTimes(i) = LeftReward(1);
    end
    if RightReward(1) > 0
        RewardTimes(i) = RightReward(1);
    end
    timeouts = RawEvents.Trial{1, i}.States.Timeout;
    timeouts(isnan(timeouts)) = [];
    TrialTimeouts(i) = length(timeouts);
end
TotalRewards = length(RewardTimes(RewardTimes > 0));
data = struct('SessionName', SessionFileName, ...
    'TotalRewards', TotalRewards, ...
    'TrialTimeouts', TrialTimeouts, ...
    'TrialTypes', TrialTypes, ...
    'nTrials', nTrials, ...
    'RawEvents', RawEvents, ...
    'RawData', RawData, ...
    'TrialStartTimestamp', TrialStartTimestamp);
end