function [CPTvalue]  = CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)
%%%%Function calculates the CPT value of a prospect according to the 
%%%%prescribed CPT parameter (i.e., delta thru r)

%%%%Inputs outcomevals and outcomeprobs should be row vectors
%%%%Remaining inputs are scalars

%%%% The code utilizes the original CPT functions from Kahneman and Tversky

%%The outcomes and probabilities are sorted in ascending order
numoutcomes=size(outcomevals,2); 
refadj_outcomevals = outcomevals - r;
[sortVals,ind] = sort(refadj_outcomevals);
sortprob = outcomeprobs(ind); 
    
    
%% The decision weights are calculated
%%% Each prob sum in the appropriate decision weight formula is stored
for k=numoutcomes:-1:1 %First for losses
   if sortVals(k)<0 && k>1  %Conditions if T: Loss & not 1st ranked outcome
       wminus(k,1) = sum(sortprob(1:k));
       wminus(k,2) = sum(sortprob(1:k))-sortprob(k); 
   end
   
   if sortVals(k)<0 && k<=1 %Conditions if T: Loss & 1st ranked outcome
       wminus(k,1) = sortprob(k);
       wminus(k,2) = 0;
   end 
end  
    
for k=1:numoutcomes %Second for gains
   if sortVals(k)>=0 && k<numoutcomes
       wplus(k,1) = sum(sortprob(k:numoutcomes));
       wplus(k,2) = sum(sortprob(k:numoutcomes))-sortprob(k);
   end
   if sortVals(k)>=0 && k>=numoutcomes
       wplus(k,1) = sortprob(k);
       wplus(k,2) = 0;
   end
end
    
%%% Actual Decision Weights are caclulated with Kahneman and Tversky func
weights = zeros(1,numoutcomes); 
for k=1:numoutcomes
   if sortVals(k) < 0
       weights(k)= (wminus(k,1)^delta) / (( wminus(k,1)^delta +(1-wminus(k,1))^delta )^(1/delta)) ...
          - (wminus(k,2)^delta) / (( wminus(k,2)^delta +(1-wminus(k,2))^delta )^(1/delta));
   else 
      weights(k)= (wplus(k,1)^gamma) / (( wplus(k,1)^gamma +(1-wplus(k,1))^gamma )^(1/gamma)) ...
           - (wplus(k,2)^gamma) / (( wplus(k,2)^gamma +(1-wplus(k,2))^gamma )^(1/gamma));
   end
end

%%Alternative functional form using Prelec's PW function
%%weights(k)  = exp(-(-log(wminus(k,1)))^sigma(i))   -    exp(-(-log(wminus(k,2)))^sigma(i));
%%weights(k) = exp(-(-log(wplus(k,1)))^sigma(i))   -    exp(-(-log(wplus(k,2)))^sigma(i));

for k=1:numoutcomes
   if sortVals(k) < 0
       utility(k) = -lambda*(-sortVals(k))^beta;
   else 
        utility(k) = sortVals(k)^alpha;
   end
end

%% Calculate the prospect value
CPTvalue = sum(weights.*utility);
    
    
end
