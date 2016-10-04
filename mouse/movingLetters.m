function [abortflag] = surfteststim

answerStr = inputdlg('How many letters to present?','Input',1,{'1'});
answerNum = str2num(answerStr{1});
currentLetter = 'X';
diary('errors.txt')

% Clear the workspace and the screen
close all;
clearvars;
sca

% Get the size of the on screen window in pixels
Screen('Preference','SkipSyncTests', 1); %take this away if possible
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'))
window = Screen('OpenWindow',screenid)
[screenWidth, screenHeight] = Screen('WindowSize', window);

% Set text size
Screen('TextSize', window, 90)

% Set number of letters to show
numLetters = 10;
letters = ['X' 'H'];

% Function to use for button press events
KbName('UnifyKeyNames');

% Monitor refresh interval
ifi = Screen('GetFlipInterval', window);

% Where the letter starts and ends (x coord)
startX = width * .1;
endX = width * .9;
spe = 10;

% How many letters have been displayed
letterCount = 0;
abortflag = false;

% Background and letter colors
white = [255 255 255];
black = [0 0 0];
gray = black+white/2;

framerate = 1/ifi;
Screen(window, 'FillRect', gray, [0 0 width height])
%Screen('Flip', window);

waitingForOnset = 1;
waitingForExit = 1


% Present stimulus if space bar pressed, exit if '1' key pressed

for i = 0:3 %while waitingForExit
    i
    for j = 0:3 %while waitingForOnset
        [keyIsDown1, secs, keyCode1] = KbCheck;
        if keyIsDown1 && keyCode1(KbName('space'))
            fprintf('registered space event')
            break;
        elseif keyIsDown1 && keyCode1(KbName('1!'))
            waitingForExit = 0;
            Screen('CloseAll');
            break;
        end
        j
    end
    
    for k = 1:20
        textPosX = spe;
        textPosY = screenHeight./2;
        if (letterCount < numLetters && textPosX < endX)
            % Draw the text to the screen
            DrawFormattedText(window, currentLetter, textPosX,...
                textPosY, [1 0 0]);
            vbl = Screen('Flip', window,[],1);
            spe = spe + speed;
        end
        k
    end
    waitingForExit=1;
    rep = 0;
    spe = 0;
    [keyIsDown1, secs, keyCode1] = KbCheck;
    if keyIsDown1 && keyCode1(KbName('1!'))
        abortflag=true;
        break;
        Screen('CloseAll');
    end

Screen('CloseAll');
end

% Clear the screen
sca;
close all;
clear all;
end