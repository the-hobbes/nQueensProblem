function mutatedVector = nQueensMutate(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation)
% nQueensMutate, used to apply the swap mutation operator to a single
% parent to create a mutated child.
%   Picks a two indecies at random from the child, and swaps the
%   values contained within. 
%   Returns the mutated permutation 
% AUTHOR: PHELAN VENDEVILLE

% parents ? Row vector of parents chosen by the selection function
% options ? Options structure
% nvars ? Number of variables
% FitnessFcn ? Fitness function
% state ? Structure containing information about the current generation. The State Structure describes the fields of state.
% thisScore ? Vector of scores of the current population 
% thisPopulation ? Matrix of individuals in the current population
    
    %herp = thisPopulation(parents,:)
    
    rng shuffle;
    
    %i = randi([1,2]);
    targetParent = thisPopulation(parents(1,1), :); % grab the parent from cell array
    
    %pick two indecies at random to swap
    randPossibilities = randperm(length(targetParent));
    randIndecies = randPossibilities(1:2); 

    targetParent(:,[randIndecies(1,1),randIndecies(1,2)]) = targetParent(:,[randIndecies(1,2),randIndecies(1,1)]);
    mutatedVector = targetParent;

end