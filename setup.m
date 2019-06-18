% setup file
% Author: Edward J. Xu
% Date: 190615
% ######################################################################################################################
% cd ~/Documents/GitHub/StochasticSim
% pwd
addpath('~/Documents/GitHub/StochasticSim/functions')  % ###############################################################
addpath('~/Documents/GitHub/StochasticSim/exercises')  % ###############################################################
addpath('~/Documents/GitHub/StochasticSim/data')  % ###############################################################

% ######################################################################################################################
% Exercise 4: Discrete Event Simulation
% nServer = 10;
% nCustomer = 11000;
% nEvent = nCustomer;
% nSim = 100;
% nStable = 1000;
% clockSimZero = 0;
% mu = 1;
% lambda = 8;
% tabYy = doExercise_4(nServer, nEvent, nSim, nStable, clockSimZero, mu, lambda);
% ######################################################################################################################
% Exercise 6a:
% m = 10;
% nSample = 20000;
% lambda = 8;
% mu = 1;
% aCap = lambda / mu;
% doExercise_6a(m, nSample, aCap);
% ######################################################################################################################
% Exercise 6b:
m = 10;
nRow = 6;
nSample = 100000;
aCap_1 = 4;
aCap_2 = 4;
whiMethod = 2;
[matCount, matProb] = doExercise_6b(m, nRow, nSample, aCap_1, aCap_2, whiMethod);
vecNumObsClass = zeros((m + 1)^2, 1);
vecExpect = zeros((m + 1)^2, 1);
for i = 1:(m + 1)^2
    vecNumObsClass(i) = matCount(i);
    vecExpect(i) = matProb(i) * nSample;
end
vecNumObsClass = vecNumObsClass(vecNumObsClass ~= 0);
vecExpect = vecExpect(vecExpect ~= 0);
[prob] = testChiSquare(vecNumObsClass, vecExpect);
% ######################################################################################################################
% Exercise 7: Anealing Simulation to Solve TSM Problem Mat-Heuristically
% nSample = 10000;
% startPosition = 1;
% tempMax = 50;
% coefDecay = 0.5;
% coefStretch = 0.00001;
% strFigName = '7/8';
% seedInitial = 100;
% doExercise_7(nSample, startPosition, tempMax, coefDecay, strFigName, seedInitial, coefStretch);
% ######################################################################################################################
% Exercise 8: Bootstrap
% beta = 1;
% k = 2.05;
% nSet = 100;
% nObs = 10000;
% seedObs = 99;
% doExercise_8(beta, k, nSet, nObs, seedObs);
