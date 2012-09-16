%{
    SCRIPT FILE TO CALL GATOOLBOX FROM COMMAND WINDOW (TO SOLVE nQueensFitness)
    Added code for bookkeeping
    AUTHOR: PHELAN VENDEVILLE
%} 

%master variables to store data from all 10 runs (stored in cells)
master_Mchanges = cell(1,10);
master_Cchanges = cell(1,10);
%note that because we are recording initial values, each cell will contain
%   generations+1 values for the columns.
master_meanPopFitness = cell(1,10);
master_stdPopFitness = cell(1,10);

%experiment-specific variables
maxgens = 100;
numberOfQueens = 16;
popsize = 100;

%options for the ga options. These indicate a custom data type being used
options = gaoptimset('PopulationType', 'custom', 'PopInitRange', [1;numberOfQueens]);

% Specify options for the GA toolbox
myoptions=gaoptimset(options, 'CreationFcn', @nQueensPermutationProducer,...
                    'SelectionFcn',{@selectiontournament,3},... % Tournament size of 3 to pick best 1 of 3 as a parent
                    'CrossoverFcn',@nQueensCrossover,...
                    'MutationFcn', @nQueensMutate,...
                    'PopulationSize', popsize,...
                    'StallGenLimit', 100,...
                    'Vectorized','on',...
                    'EliteCount', 0,...
                    'FitnessLimit',0,...
                    'CrossoverFraction', .5,...
                    'OutputFcns',@nQueensOutputFcn,...
                    'Generations', maxgens);

%global bookeeping variables 
global Mchanges;
global Cchanges;

%{ 
   Run the GA on an 16 variable fitness function with the options you've set
   Perform this run 10 times, performing bookkeeping and updating master
   variables each iteration.
%}
for seed = 1:10
    rand('seed', seed);
    Mchanges = NaN(popsize/2, maxgens);%mutation changes
    Cchanges = NaN(popsize/2, maxgens);%crossover changes
    ga(@nQueensFitness, numberOfQueens, myoptions);
    genstats = nQueensOutputFcn;
    
    %update master variables
    master_Mchanges{1,seed} = Mchanges;
    master_Cchanges{1,seed} = Cchanges;
    master_meanPopFitness{1,seed} = genstats.AvgScore;
    master_stdPopFitness{1,seed} = genstats.StandardDev;
end

%{ *** perform plotting *** }%
%%%Plot of mean population fitness (y-axis) as a function of generations (x-axis), using different lines for the 10 different runs
nQueensPlotChanges('N-Queens mean pop. fitness vs generations', 'Generation', 'Mean population fitness',master_meanPopFitness) 

%%%plot of std of population fitness (y) vs generations (x), using different lines for the 10 different runs
nQueensPlotChanges('N-Queens STD pop. fitness vs generations', 'Generation', 'Standard Deviation of population fitness',master_stdPopFitness)

%%%plot of the mean fitness change caused by mutations(y-axis) as a function of generations (x-axis), using different lines for the 10 different runs
%calculate the mean change in fitness for every generation a mutation occurred.
averagesOfMutationRuns = cell(1,10);
for index = 1:length(master_Mchanges) %for each of the 10 runs
    element = master_Mchanges{1,index}; %grab the next cell
    storeAverages = NaN(1,100); %make a structure to hold the averages
    
    for i = 1:length(element) %for each of the 100 columns (generations)
        storeAverages(1,i) = mean(element(:,i)); %store the mean of each column
    end
    averagesOfMutationRuns{1, index} = storeAverages; %store all averages from that run
end

%plot these changes against the generation numbers
nQueensPlotChanges('Mean Fitness Change Caused by Mutations', 'Generation', 'Mean Fitness Change (by mutations)',averagesOfMutationRuns)

%%%plot of the mean fitness change caused by crossover(y) vs generations(x),using different lines for the 10 different runs
averagesOfCrossoverRuns = cell(1,10);
for index = 1:length(master_Cchanges) %for each of the 10 runs
    element = master_Cchanges{1,index}; %grab the next cell
    storeAverages = NaN(1,100); %make a structure to hold the averages
    
    for i = 1:length(element) %for each of the 100 columns (generations)
        storeAverages(1,i) = mean(element(:,i)); %store the mean of each column
    end
    averagesOfCrossoverRuns{1, index} = storeAverages; %store all averages from that run
end

%plot these changes against the generation numbers
nQueensPlotChanges('Mean Fitness Change Caused by Crossover', 'Generation', 'Mean Fitness Change (by crossover)',averagesOfCrossoverRuns)

%%%scatter plot of all fitness changes (both bad and good, from all 10 runs lumped together) caused by mutation (y) vs the corresponding standard deviation of the population before the mutation (x)
%get all of the initial stds (before mutation). These will be the x axis
stdsBeforeMutation = NaN(1,10);
for i = 1:length(master_stdPopFitness)
	elementStd = master_stdPopFitness{1,i}(1,1); %first element of each cell is the initial std
	stdsBeforeMutation(1,i) = elementStd;
end




%%%scatter plot of all fitness changes (both bad and good, from all 10 runs lumped together) caused by crossover (y) vs the corresponding standard deviation of the population before the crossover (x)