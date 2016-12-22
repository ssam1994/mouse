pathName = '/Users/Sarah/Documents/First-Year/doris-rotation/git/';
addpath(pathName);
numMice = 3;
yData = cell(1, numMice);
MouseMatrix = cell(1, numMice);
legendStrings = repmat({''}, 1, numMice*2);
colors = 'rgbkmcyw';
%Plot proportion correct over time
figure( 'Name', 'Proportion correct choices over sessions' ); 
grid on
for i = 1:numMice
    [SessionMatrix, yout] = LoadMouseSessions([pathName 'M' num2str(i) '/InitiateTrial/Session Data/']);
    MouseMatrix{1, i} = SessionMatrix;
    %yData{1, i} = yout;
    xout = 1:length(SessionMatrix);
    
    ft = fittype('a*exp(b*x)', 'independent', 'x', 'dependent', 'y');
    %ft = fittype('-1*a*exp(-1*b*x)', 'independent', 'x', 'dependent', 'y');
    opts = fitoptions(ft);
    opts.Display = 'Off';
    opts.Lower = [-Inf 0];
    opts.StartPoint = [max(xout)*0.5 max(yout)*0.5];
    opts.Upper = [Inf 1];
    [fitresult, gof] = fit(xout(:), yout, ft, opts);
    plot(fitresult, colors(i), xout(:), yout, [colors(i) 'o']);
    legendStrings{2*i-1} = ['M' num2str(i)];
    legendStrings{2*i} = 'exp fit';
    hold on
end
xlabel('Session Number', 'FontSize', 25);    
ylabel('Fraction of responses correct', 'FontSize', 25);
xlim([0.9, max(xout)+0.1]);
ylim([0, 1]);
set(gca,'FontSize',20);
legend(legendStrings, 'Location', 'NorthEastOutside');

saveas(gcf,'/Users/Sarah/Documents/First-Year/doris-rotation/initiate-trial-plot.png')