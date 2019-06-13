% function file for exercise 6
% Author: Edward J. Xu, Sanaz
% Date: 190613
% ######################################################################################################################


function [x] = loopRandWalk(x, nMax, nMin)
    x = x + randWalk();
    if x > nMax
        x = nMin;
    elseif x < nMin
        x = nMax;
    end
end


function [delta] = randWalk()
    delta = randi(2, 1);
    if delta == 2
        delta = -1;
    end
end
