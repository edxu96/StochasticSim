% setup file for exercise 4
% Author: Edward J. Xu
% Date: 190612
% ######################################################################################################################


function doExercise_4()
    nServer = 10;
    nCustomer = 11000;
    nSim = 100;
    nStable = 1000;
    clockSimZero = 0;
    mu = 1;
    lambda = 8;
    fprintf("#### Begin #####################################################################");  % ####################
    [funcArrive, vecParaArrive] = getFunc("expArrive", mu, lambda);
    [funcServe, vecParaServe] = getFunc("expServe", mu, lambda);
    [bCap] = calErlangsFormula(8, 1, nServer);
    fprintf("Analysis: b = %f.\n", bCap);
    % 3,  Begin `nSim`-Times Simulations ###############################################################################
    tic
    nEvent = nCustomer;
    vecResultProbRaw = zeros(nSim, 1);
    vecResultProb = zeros(nSim, 1);
    vecY = zeros(nSim, 1);
    for i = 1:nSim
        [vecResultProbRaw(i), sState] = simDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, funcServe, ...
            vecParaArrive, vecParaServe);
        vecResultProb(i) = (sState(nEvent).nCustomerBlock - sState(nStable).nCustomerBlock) / (nEvent - nStable);
        vecY(i) = mean([sState.inteEvent]);
    end
    fprintf("Result from Simulation ---------------------------------------------------------");
    toc
    printResult(vecResultProb, var(vecResultProb));
    % Plot the Histogram of Simulated Time and Standard Distribution
    vecXStd_1 = [0.01:0.01:5];
    vecYStd_1 = exppdf(vecXStd_1, mu);
    [vecProbClass] = plotHist([sState.inteEvent], vecXStd_1, vecYStd_1, 30, '5.png', ...
        "Histogram of Simulated Length of Arrival Interval and Exponential Distribution", 'Histogram of LAI');
    vecXStd_2 = [0.01:1:40];
    vecYStd_2 = exppdf(vecXStd_2, lambda);
    [vecProbClass] = plotHist([sState.timeServe], vecXStd_2, vecYStd_2, 30, '6.png', ...
        "Histogram of Simulated Serving Time and Exponential Distribution", 'Histogram of Serving Time');
    fprintf("Result from Simulation and Control Variate -------------------------------------");
    expectY = 1;
    vecX = vecResultProb;
    vecZ = zeros(nSim, 1);
    covXY = cov(vecX, vecY);
    varXY = covXY(1, 2);
    c = - varXY / var(vecY);
    for i = 1:nSim
        vecZ(i) = vecX(i) + c * (vecY(i) - expectY);
    end
    varianceZ = var(vecX) - varXY^2 / var(vecY);  % The calculation is a bit different. ???
    printResult(vecZ, varianceZ);
    fprintf("#### End #######################################################################");  % ####################
end


function [func, vecPara] = getFunc(whiFunc, mu, lambda)
% To define the function for length of arrival interval and serving time.
    if whiFunc == "expArrive"
        func = @exprnd;
        vecPara = mu;
    elseif whiFunc == "expServe"
        func = @exprnd;
        vecPara = lambda;
    elseif  whiFunc == "cons"
        cons = 10;
        func = @(cons) cons;
        vecPara = cons;
    end
    fprintf("Func: %s.\n", whiFunc);
end


function [boundLower, boundUpper] = printResult(vecResult, variance)
    fprintf("mean(b) = %f.\n", mean(vecResult));
    fprintf("var(b) = %f.\n", variance);
    [boundLower, boundUpper] = calConfInte(vecResult);
    fprintf("lowerConfiInterval(b) = %f.\n", boundLower);
    fprintf("upperConfiInterval(b) = %f.\n", boundUpper);
end


function test()
    nServer = 10;
    nCustomer = 10000;  % 10000;
    clockSimZero = 0;
    % 2,  Define Functions for Length of Arrival Interval and Serve Time
    [funcArrive, vecParaArrive] = getFunc2("expArrive");
    [funcServe, vecParaServe] = getFunc2("expServe");
    % 3,  Begin `numSim`-Times Simulations
    nEvent = nCustomer;
    [b, sState] = simDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, funcServe, vecParaArrive, vecParaServe);
    plotLine([1:nEvent], [sState.nCustomerBlock], ...
        '2.png', "The Result of Number of Blocked Customers");
    plotScatter([1:nEvent], [sState.nCustomerServe], ...
        '3.png', "The Result of Number of Customers being Served");
    [bCap] = calErlangsFormula(8, 1, nServer);
    plotLine([1:nEvent], [sState.b; ones(1, nEvent) * bCap], '4.png', "The Result of the Probability a Customer is Blocked");
    matTimeDepart = [sState.vecTimeDepart];
end


function [func, vecPara] = getFunc2(whiFunc)
    if whiFunc == "expArrive"
        mu = 1;
        func = @exprnd;
        vecPara = mu;
    elseif whiFunc == "expServe"
        lambda = 8;
        func = @exprnd;
        vecPara = lambda;
    elseif  whiFunc == "cons"
        cons = 10;
        func = @(cons) cons;
        vecPara = cons;
    end
    fprintf("Func: %s.\n", whiFunc);
end