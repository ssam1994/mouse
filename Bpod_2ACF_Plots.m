numMice = 3;
yData = cell(1, numMice);
MouseMatrix = cell(1, numMice);

%Plot proportion correct over time
figure( 'Name', 'Proportion correct choices over sessions' ); 
xlabel( 'Session Number' );    
ylabel( 'Probability of correct response' );    
grid on
for i = 1:numMice
    mouseID = ['M' num2str(i)];
    [out1, out2] = LoadMouseSessions('C:\git\mouse\', mouseID, '\PokeXPTB_FL');
    MouseMatrix{1, i} = out1;
    yData{1, i} = out2;
    plot(1:length(SessionMatrix), out2, 'o');
    hold on
end

%Fit psychometric curve
% ft = fittype( '1./(1+exp(-(x-alpha)/beta))', 'independent', 'x', 'dependent', 'y' );
% opts = fitoptions( ft );    
% opts.Display = 'Off';    
% opts.Lower = [-Inf 0];    
% opts.StartPoint = [0.5 0.3];    
% opts.Upper = [Inf 1];
% [fitresult, gof] = fit( xData, yData, ft, opts );

%Plot fitted curve
%http://davehunter.wp.st-andrews.ac.uk/2015/04/12/fitting-a-psychometric-function/
% figure( 'Name', 'Psychophysical function fitting' );    
% h = plot( fitresult, xData, yData );    
% legend( h, 'responses vs. sample positions', 'fit', 'Location', 'NorthEast' );      
% xlabel( 'Session Number' );    
% ylabel( 'Probability of correct response' );    
% grid on  
