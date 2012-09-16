function nQueensPlotChanges(  titleString,... 
                                xLabelString,... 
                                yLabelString,...
                                dataToPlot)
%{
    nQueensPlotChanges: Function used to create plots of data from the
    nQueens experiment.
    
    INPUT
    titleString = string containing a title
    xLabelString = string containing the x axis label
    yLabelString = string containing the y axis label                             
    dataToPlot = cell array of data to plot                                          
%}
% AUTHOR: PHELAN VENDEVILLE

    cc=hsv(12);
    figure; 
    hold on;
    for i=1:10
        plot( dataToPlot{1,i},'color',cc(i,:),'LineWidth',1);
    end
    set(gca,'Fontsize',12);
    title(titleString)
    xlabel(xLabelString)
    ylabel(yLabelString)
    legend('Run 1', 'Run 2', 'Run 3', 'Run 4', 'Run 5', 'Run 6', 'Run 7', 'Run 8', 'Run 9', 'Run 10')
end

