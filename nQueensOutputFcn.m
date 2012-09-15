function [state,options,optchanged] = nQueensOutputFcn(options,state,flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GAOUTPUTFCN is designed to store information used in plotting tools.
%
% If you specify this as the custom output function, then this function is automatically 
% called from the GAtoolbox every iteration, to maintain running statistics
% for later output/plotting.  Then, after the end of the run, you can call
% this function once more from the command window WITH NO INPUT ARGUMENTS, to retrieve the
% generational statistics, as follows:
%   >> history = gaoutputfcn; % do NOT provide any input arguments
%
% 
% OPTIONAL INPUT ARGUMENTS (USED WHEN CALLED FROM WITHIN GA TOOLBOX):
%   OPTIONS: A structure containing the current GA toolbox options
%   STATE: A structure containing information about the current generation
%   of the optimization:
%             Population: Population in the current generation
%                  Score: Scores of the current population
%             Generation: Current generation number
%              StartTime: Time when GA started 
%               StopFlag: String containing the reason for stopping
%              Selection: Indices of individuals selected for elite,
%                         crossover and mutation
%            Expectation: Expectation for selection of individuals
%                   Best: Vector containing the best score in each generation
%        LastImprovement: Generation at which the last improvement in
%                         fitness value occurred
%    LastImprovementTime: Time at which last improvement occurred
%
%   FLAG: Current state in which OutPutFcn is called. Possible values are:
%         init: initialization state 
%         iter: iteration state
%         done: final state
%
% OUTPUT ARGUMENTS, WHEN CALLED WITH INPUT ARGUMENTS (FROM WITHIN GA TOOLBOX):
%   OPTIONS and STATE are returned unchanged
%   OPTCHANGED is always false.
%   (NOTE: these output arguments are required for compatibility with the
%   toolbox, even though we know we are never changing them inside this
%   function)
% 
% OUTPUT ARGUMENT, WHEN CALLED WITHOUT INPUT ARGUMENTS (I.E., AFTER TERMINATION OF GA RUN):
%   STATE: Structure containing information about the state of the
%          optimization with respect to each generation, with each row 
%          corresponding to a generation; here, 
%               m is the maximum number of generations specified (if terminated before
%                   then by another stopping criteria, data structures are padded
%                   with NaN flags)
%               n is the number of decision variables in each individual
%
%          .BestScore - mx1: fitness of the best individuals
%          .BestIndividual - mxn: rows are the best individuals
%          .WorstScore - mx1: fitness of the worst individuals
%          .WorstIndividual - mxn: rows are the worst indiviuals
%          .AvgScore - mean population fitness
%          .StandardDev - standard deviation of fitness
%          .LastImprovement: Generation at which the last improvement in
%                         fitness value occurred

% AUTHORS: Maggie Eppstein and Joshua L. Payne
% MODIFIED 15SEP2012: Phelan Vendeville
%   Added code to record stats about initial configuration. Removed some
%   code unnecessary for current experiement. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

persistent history % save generational history in this structure
optchanged = false; % we never change the options in this implementation of gaoutputfcn

persistent initialAverage
persistent initialStd

if nargin>0 % if called from GA toolbox (i.e., with input arguments)
    switch flag
        case 'init'
            history=[]; %erase history from previous run, if any exists
            
            %min(state.Score)%best fitness of initial population
            %max(state.Score)%worst fitness of initial population
            initialAverage = mean(state.Score);%average fitness ""
            initialStd = std(state.Score);%standard deviation of fitness ""
            
        case 'iter'            
            % save statistics for the current generation
            %[history.BestScore(state.Generation), BestIndex] = min(state.Score); %best fitness
            %history.BestIndividual(state.Generation,:) = state.Population(BestIndex,:);%best guy
            %[history.WorstScore(state.Generation), WorstIndex] = max(state.Score);%worst fitness
            %history.WorstIndividual(state.Generation,:) = state.Population(WorstIndex,:);%worst guy
            history.AvgScore(state.Generation) = mean(state.Score);% average fitness
            history.StandardDev(state.Generation) = std(state.Score);% standard deviation of fitness
           
        case 'done'
            history.LastImprovement=state.LastImprovement;
            
            %Add the initial values to the beginning of the right vector
            %Note that this will give you generations+1 values.
            history.AvgScore = [initialAverage history.AvgScore];
            history.StandardDev = [initialStd history.StandardDev];

        otherwise
            disp('WARNING: called gaoutputfcn with invalid flag!  Call ignored.');
    end
    
else % if called by user (i.e., with no input arguments) 
    state=history; % return final history through the first output argument
    if nargout > 1
        disp('WARNING: only the first input argument is meaningful!');
        options=[]; % avoid crashing by returning a placeholder
    end
        
end