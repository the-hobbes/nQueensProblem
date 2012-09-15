function mutatedVector = nQueensMutate(parents, options, GenomeLength, FitnessFcn, state, thisScore, thisPopulation)
% nQueensMutate, used to apply the swap mutation operator to a single
% parent to create a mutated child.
%
%   - Pulls all children specified by parents from thisPopulation.
%   - runs through each child, performing the following:
%      Picks a two indecies at random from the child, and swaps the
%      values contained within. 
%   - Records the change in fitness after each mutation
%   - Returns the mutated permutation 
% AUTHOR: PHELAN VENDEVILLE

% parents ? Row vector of parents chosen by the selection function
% options ? Options structure
% nvars ? Number of variables
% FitnessFcn ? Fitness function
% state ? Structure containing information about the current generation. The State Structure describes the fields of state.
% thisScore ? Vector of scores of the current population 
% thisPopulation ? Matrix of individuals in the current population
        
    global Mchanges;
    
    mutationChildren = thisPopulation(parents,:); %extract kids from current generation
    oldFitness = nQueensFitness(mutationChildren);%take fitnesses of all kids before mutation
    
    %run through each child
    for i = 1:length(mutationChildren(:,1));
        targetChild = mutationChildren(i, :);
        %pick two indecies at random to swap
        randPossibilities = randperm(GenomeLength);
        randIndecies = randPossibilities(1:2);
        %swap those indecies
        targetChild(:,[randIndecies(1,1),randIndecies(1,2)]) = targetChild(:,[randIndecies(1,2),randIndecies(1,1)]);
        %add to mutated kids
        mutationChildren(i, :) = targetChild;
    end
    
    %record changes in fitness
    newFitness = nQueensFitness(mutationChildren);%take fitnesses of all kids after mutation
    diffFitness = oldFitness - newFitness;%take difference between them
    %put the fitness changes in the global bookeeping mutation variable
    for j=1:length(diffFitness)
        Mchanges(j,state.Generation) = diffFitness(j,1);
    end
    
    mutatedVector = mutationChildren;

end