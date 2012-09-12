function offspring = nQueensCrossover ( parent1, parent2)
%nQueensCrossover, a function used to create a child from two parent
%vectors
%   Uses the "cut and crossfill" method of recombination to create one
%   child permutation vector from two parents.
% AUTHOR: PHELAN VENDEVILLE

% Cut and Crossfill:
%   1. Select a random position (the crossover point) from the vector.
%   2. Cut parent 1 into two segments after this position.
%   3. Copy the first segment of parent 1 into the child.
%   4. Scan parent 2 from left to right and fill the second segment of
%       the child with values from parent 2, skipping those that are already
%       contained in it. 

    workingChild = NaN(1, length(parent1));

    rng shuffle;
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

    offspring = workingChild;
end