%SCRIPT FILE TO CALL GATOOLBOX FROM COMMAND WINDOW (TO SOLVE nQueensFitness)
%   Added code for bookkeeping
% AUTHOR: PHELAN VENDEVILLE

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

% Run the GA on an 16 variable fitness function with the options you've set
% Perform this run 10 times, performing bookkeeping and updating master
%   variables each iteration.
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

