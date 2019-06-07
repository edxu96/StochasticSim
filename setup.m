% setup file for exercises in stochastic simulation
% by Edward J. Xu and Sanaz
% 190606
% ######################################################################################################################
% cd Documents/GitHub/StochasticSim
% pwd
% ######################################################################################################################
addpath("/Users/fengguangjie/Documents/GitHub/StochasticSim")
% %
% mCap = 10000;
% a    = 24298;
% c    = 99991;
% x0   = 199017;
% mCap = 16;
% a    = 5;
% c    = 1;
% x0   = 3;
% vecRanNum = testRngLcg(mCap, a, c, x0, 'figHistRNG.png');
% vecRanNumNorm  = vecRanNum / mCap;
vecRanNumNorm_2 = rand(10000, 1);
% [vecX, vecProbClass] = distGeoPDF(vecRanNumNorm_2, 0.25, 100, 'figHistGeoPDF.png');
% vecX_dice = distDicePDF(vecRanNumNorm_2, 6, 'figHistDice.png');
[ vecX, vecProbClass ] = distCrudePDF(vecRanNumNorm_2, [0 0.1 0.3 0.6 1], 'figHistCrudePDF.png');  % [0:0.1:1]
