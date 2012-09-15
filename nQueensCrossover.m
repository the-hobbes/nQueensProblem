function xoverKids = nQueensCrossover (parents, options, nvars, FitnessFcn, unused,thisPopulation)
%nQueensCrossover, a function used to create a child from two parent
% vectors.
%
%   Makes 1 child for every two parents (parents specified by indexes in "parents". These are then taken from "thisPopulation". 
%   Uses the "cut and crossfill" method of recombination to create one
%   child permutation vector from two parents.
% AUTHOR: PHELAN VENDEVILLE
% 
% parents ? Row vector of parents chosen by the selection function
% options ? options structure
% nvars ? Number of variables
% FitnessFcn ? Fitness function
% unused ? Placeholder not used
% thisPopulation ? Matrix representing the current population. The number of rows of the matrix is Population size and the number of columns is Number of variables.

% Cut and Crossfill:
%   1. Select a random position (the crossover point) from the vector.
%   2. Cut parent 1 into two segments after this position.
%   3. Copy the first segment of parent 1 into the child.
%   4. Scan parent 2 from left to right and fill the second segment of
%       the child with values from parent 2, skipping those that are already
%       contained in it. 
    
    %global variables to save bookkeeping information
    global Cchanges;
    %global generation to get the current generation
    global curGen; %this required making a change to gaunc.m on line 72 and 73
    
    % How many children to produce?
    nKids = length(parents)/2;
    
    % space to store the differences in fitness (bookkeeping)
    diffFitnesses = NaN(nKids, 1);
    
    % Allocate space for the kids
    xoverKids = zeros(nKids,nvars);
    
    % To move through the parents twice as fast as thekids are
    % being produced, a separate index for the parents is needed
    index = 1;
    
    for f = 1:nKids
        % get parents
        parent1 = thisPopulation(parents(index),:);
        index = index + 1;
        parent2 = thisPopulation(parents(index),:);
        index = index + 1;
        
        %find which parent is fitter
        fit_1 = nQueensFitness(parent1);
        fit_2 = nQueensFitness(parent2);
        mostFitParent = min(fit_1, fit_2);
        
        workingChild = NaN(1, length(parent1));

        %rng shuffle;
        randPossibilities = randperm(length(parent1));
        randPos = randPossibilities(1,1); %pick the random position

        segParent1 = parent1(1, 1:randPos); %cut parent1 into a segment

        i = 1:length(segParent1);
        workingChild(:, i) = segParent1(:,i); %copy parent1 segment into child

        j = 1: length(parent2);

        copyLocations = ismember(parent2(j), workingChild(j)); %the 0's are the locations of the items needed to be copied from parent2

        if sum(copyLocations) <= length(parent1) %if we have something to copy
            indecies = copyLocations == 0;
            %parent2(indecies); %actual values that need to be inserted into workingChild
            workingChild(isnan(workingChild)) = parent2(indecies);
        end
        
        % find difference between the most fit parent and the child produced
        diffFitness = mostFitParent - nQueensFitness(workingChild);
        % add it to the diffFitnesses tracker
        diffFitnesses(f, 1) = diffFitness;
    
        xoverKids(f,:) = workingChild;
    end
    
    %put the fitness changes in the global bookeeping mutation variable
    for j=1:length(diffFitnesses)
        Cchanges(j,curGen) = diffFitnesses(j,1);
    end
end