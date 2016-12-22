%http://peterscarfe.com/accuratetimingdemo.html

% Clear the workspace and the screen
close all;
clear all;
sca

matvars = load('images.mat');

imageNames = sort(fieldnames(matvars));

% Here we call some default settings for setting up Psychtoolbox
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = 1;%max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);

[xCenter, yCenter] = RectCenter(windowRect);

firstImage = matvars.(imageNames{1});
theRect = [0 0 334 223];
% Get the size of the image
[s1, s2, s3] = size(firstImage);
% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);
% Retreive the maximum priority number
topPriorityLevel = MaxPriority(window);

numSecs = 1;
numFrames = length(imageNames);
waitframes = 1;
Priority(topPriorityLevel);
vbl = Screen('Flip', window);
for frame = 1:numFrames
    theImage =  matvars.(imageNames{frame});
    % Make the image into a texture
    imageTexture = Screen('MakeTexture', window, theImage);

    Screen('FillRect', window, grey);
    centeredRect = CenterRectOnPointd(theRect, xCenter, yCenter);
    Screen('DrawTexture', window, imageTexture, [], centeredRect);

    % Tell PTB no more drawing commands will be issued until the next flip
    Screen('DrawingFinished', window);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
Priority(0);

% Clear the screen.
close all;
clear all;
sca;