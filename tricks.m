% for those of you less familiar with Matlab and how to vectorize code (to
% avoid the need for explicit loops and branches), the following code
% snippet contains some useful examples.

% first I’ll just create some fake data
nmutants=20; % number of children created by mutation each generation
maxgens=100; % max number of generations by GA
gensolved=30; % number of generations the GA actually ran

%make up fake changes in fitness
M=NaN(nmutants,maxgens); % preallocate matrix of NaNs
M(:,1:gensolved)=randn(nmutants,gensolved); % fill in the first gensolved generations with fake data

%make up fake standard deviations similarly
S=NaN(1,maxgens);
S(1:gensolved)=rand(1,gensolved)*3; 

% now I’ll demonstrate some vectorizing tricks
S=S(ones(nmutants,1),:); % replicate the first row to make S the same size as M
keep=~isnan(M(:)); % indices of non-NaN values in M accessed in column major order

M=M(keep); % column vector of all values extracted from M
S=S(keep); % column vector of corresponding standard deviations

% let's plot all good changes in blue and bad ones in red
goodchanges=M>0; % assuming you did Oldfitness - Newfitness and we're minimizing
badchanges=~goodchanges;
plot(S(goodchanges),M(goodchanges),'b*'); % scatter plot of M (y-axis) vs S (x-axis)
hold on % allows me to add something to the figure later
plot(S(badchanges),M(badchanges),'ro');

% let's add a horizontal line at y = 0
xlim=get(gca,'xlim'); % get row vector with limits of the x-axis plotted [minx maxx]
plot(xlim,[0 0],'k--'); 
hold off

% now label the plot
set(gca,'Fontsize',12); % keep Maggie's eyes happy :-)
xlabel('Standard Deviation of Population Fitness')
ylabel('Change in fitness due to Mutation')
title('Maggie Eppstein''s fake data plot')
legend('good changes','bad changes','Location','NorthOutside')
figure(gcf) % make sure figure window is in the foreground

