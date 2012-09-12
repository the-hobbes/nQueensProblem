function mutatedVector = nQueensMutate( vectorOfQueens )
%nQueensMutate, used to apply the swap mutation operator to a permutation
%vector
%   Picks a two indecies at random from vectorOfQueens, and swaps the
%   values contained within. 
%   Returns the mutated permutation vector 
% AUTHOR: PHELAN VENDEVILLE

    rng shuffle;

    randPossibilities = randperm(length(vectorOfQueens));
    randIndecies = randPossibilities(1:2);

    vectorOfQueens(:,[randIndecies(1,1),randIndecies(1,2)]) = vectorOfQueens(:,[randIndecies(1,2),randIndecies(1,1)]);
    mutatedVector = vectorOfQueens;

end

