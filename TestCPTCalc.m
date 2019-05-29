%Double check code with Wakker(2003) results: "The Data of Levy and Levy
%(2002).... Peter Wakker (2003), Mgmt Science 49 (7)


alpha = 0.88;
beta= 0.88;
lambda= 2.25;
gamma= 0.61;    
delta = 0.69;   
r=0;

%Test 1
outcomevals =[-3000, 4500];
outcomeprobs = [0.5,0.5];
Val(1) =CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)

clear outcomevalues outcomeprobs

%Test 2
outcomevals =[-6000, 3000];
outcomeprobs = [0.25,0.75];
Val(2) =CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)

clear outcomevalues outcomeprobs

%Test 3 -- Does sorting break it
outcomevals =[3000, -6000];
outcomeprobs = [0.75,0.25];
Val(3) =CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)

clear outcomevalues outcomeprobs

%Test 4 -- Larger Prospects
outcomevals =[-1600,-200,1200,1600];
outcomeprobs = [0.25,0.25,0.25,0.25];
Val(4) =CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)

clear outcomevalues outcomeprobs

%Test 5 -- Larger Prospects
outcomevals =[-1000,-800,800,2000];
outcomeprobs = [0.25,0.25,0.25,0.25];
Val(5) =CalcCPT(outcomevals, outcomeprobs, gamma, delta, lambda, alpha, beta, r)

%%Correct Val should be [-483, -743, -743, -216, -138]
