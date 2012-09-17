function nQueensPlotScatterChanges( titleString,... 
                                    xLabelString,... 
                                    yLabelString,...
                                    standardDeviations,...
                                    changes)
%{
    nQueensPlotScatterChanges: Function used to create scatter plots of data from the
    nQueens experiment.
    
    INPUT
    titleString = string containing a title
    xLabelString = string containing the x axis label
    yLabelString = string containing the y axis label                             
    standardDeviations = cell array of stds from all runs
    changes = amount of all changes (either from mutation or crossover)
%}
% AUTHOR: PHELAN VENDEVILLE
    
    figure; 
    hold on;

    for i = 1:length(changes)
        M = changes{1,i};
        S = standardDeviations{1,i};
        S = S(ones(50,1), :);
        keep = ~isnan(M(:));
        M = M(keep);
        S = S(keep);
        goodchanges = M > 0;
        badchanges = ~goodchanges;
        plot(S(goodchanges), M(goodchanges), 'b*'); hold on; plot(S(badchanges), M(badchanges), 'ro');
    end
    
    % add a horizontal line at y = 0
    xlim=get(gca,'xlim'); % get row vector with limits of the x-axis plotted [minx maxx]
    plot(xlim,[0 0],'k--'); 
    
    set(gca,'Fontsize',12);
    title(titleString)
    xlabel(xLabelString)
    ylabel(yLabelString)
    legend('good changes','bad changes','Location','NorthOutside')
    
end

