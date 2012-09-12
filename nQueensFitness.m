function fitness = nQueensFitness( cellIn )
%nQueensFitness, a function used to determine the fitness of a vector of
%numbers representing the placement of n-queens on a chessboard
%   Condition: no two queens can check each other
%   Higher fitness means a fewer collisions, thus the higher the fitness
%   the lower the fitness actually is.
% AUTHOR: PHELAN VENDEVILLE
    vectorOfQueens = cellIn{1,1};
    
    collisionVector = NaN(1, length(vectorOfQueens) * 2); %preallocate vector
    
    i = 1:length(vectorOfQueens); %all columns in vectorOfQueens
    diff = length(collisionVector) - length(vectorOfQueens); %difference between them
    k = diff+1:length(collisionVector); %all columns beyond the end of vectorOfQueens that collisionVector possesses
    
    collisionVector(1, i) = vectorOfQueens(1, i) + i; %add column to value of row
    collisionVector(1, k) = vectorOfQueens(1, i) - i; %subtract column from value of row
    
    %find the unique values in the vector of collisions (each side)
    %we operate on each side independently because values that occur in both do not
    %   indicate a collision in and of themselves (only duplicate values
    %   occuring on the same side do).
    %
    % TODO: modularize this into a single function
    
    left = 1:length(collisionVector)/2;
    right = (length(collisionVector)/2) + 1: length(collisionVector);
    uleft = unique(collisionVector(left));
    uright = unique(collisionVector(right));
    
    %count the values on each side of collisionVector that fall between the elements in the unique vectors
    hleft = histc(collisionVector(left), uleft);
    hright = histc(collisionVector(right), uright);
    
    %get indicies of all values of h that are greater than 1 (indicating collisions)
    sigleft = hleft > 1;
    sigright = hright > 1;
    
    %the sum of all of those values greater than 1
    rawleft = sum(hleft(:,sigleft));
    rawright = sum(hright(:,sigright));
    
    %need at least two to collide, so take the ceiling of half the total raw collisions
    totalleft = ceil(rawleft/2);
    totalright = ceil(rawright/2);
    
    fitness = totalleft + totalright;    
end