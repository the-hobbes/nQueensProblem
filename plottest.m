M = master_Mchanges{1,1};
S = master_stdPopFitness{1,1};
S = S(ones(50,1), :);
keep = ~isnan(M(:));
M = M(keep);
S = S(keep);
goodchanges = M > 0;
badchanges = ~goodchanges;
plot(S(goodchanges), M(goodchanges), 'b*'); hold on; plot(S(badchanges), M(badchanges), 'ro');