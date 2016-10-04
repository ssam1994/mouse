function [abortflag] = surfteststim
stimlength = 10;
Screen('Preference','SkipSyncTests', 1); %take this away if possible
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'));
window = Screen('OpenWindow',screenid);

[width, height]=Screen('WindowSize',screenid);
duration = 10;
onsetdelay = 1;
isi = 1;
ifi = Screen('GetFlipInterval', window);

minradius = 0.44; % in cm
maxradius = 4.47; % in cm
speed = (maxradius - minradius)*4; %in cm per second
rep = 0;
abortflag = false;

white = [255 255 255];
black = [0 0 0];
gray = black+white/2;
colors = [black; white];

ini = round((minradius * width)/48); % converting min radius in cm to pixels
maxradius = round((maxradius * width)/48);
framerate = 1/ifi;
speed = round(((speed *width)/48)/framerate);
spe = ini;

Screen(window, 'FillRect', gray, [0 0 width height]); 
%might need to move this to the beginning so screen is gray until triggered
Screen('Flip', window);
%WaitSecs(onsetdelay);

x = 1;
y=1;
z= 1;
while y
while x
    [keyIsDown1, secs, keyCode1] = KbCheck;
    if keyIsDown1 && keyCode1(KbName('PrintScreen'))
        %x = 0;111
        break;
    elseif keyIsDown1 && keyCode1(KbName('1!'))
        y=0;
        Screen('CloseAll');
        break;
    end
end
for k = 1:20000;
    pos = [width./2 height./2];
    col = black;%white 
        if (rep < stimlength && spe < maxradius)
        Screen('FillOval', window, col, [pos-ini-spe pos+ini+spe]);
        vbl = Screen('Flip', window,[],1);
        spe = spe + speed;
        elseif spe>= maxradius;
            rep = rep +1;
        WaitSecs(.25);
        Screen(window, 'FillRect', gray, [0 0 width height]);
        Screen('Flip', window);
        WaitSecs(.5);
        spe = ini;
        end

end 
    %% abort when "1" key is hit
 
x=1;
rep = 0;
spe = ini;
   [keyIsDown1, secs, keyCode1] = KbCheck;
    if keyIsDown1 && keyCode1(KbName('!'))
        abortflag=true;1
        break;
       Screen('CloseAll'); 
    end
end
Screen('CloseAll');
end
