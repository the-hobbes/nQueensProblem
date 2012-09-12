function pop = nQueensPermutationProducer( nvars,FitnessFcn,options )
%nQueensPermutationProducer creates a permutation vector for use in n
%queens problem
%   Creates a population of vectors each containing a random permutation of numbers from 1 to
%   length (non repeating), representing the n queens on thier places in a
%   chessboard.
%   NVARS = number of variables in the problem
%   FitnessFcn = the fitness function   
%   options = ga options
%
% AUTHOR: PHELAN VENDEVILLE
    
    totalPopSize = sum(options.PopulationSize);
    n = nvars;
    pop = cell(totalPopSize,1);
    for i = 1:totalPopSize
        pop{i} = randperm(n);
    end
    
    %length = 8
    %genome = randperm(length)
end