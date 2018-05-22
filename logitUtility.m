% LOGITUTILITY Calculate Modal Split using Logit Model
% Filename: logitUtility.m
%
% Description: Given Traveltime Matrices for Mode1 and Mode2, calculate the
% modal split based on a logit choice model.
%
% Author:
%       Alex Vermeulen
%       zxbiohazardzx@gmail.com
% Inputs:
%     [LBeta] Commonly 1, this can be used to change logit sensitivity to
%     relative changes from [-10 to 10] into [-x x]
%     [TT_Alt1] NxN TravelTime Matrix for Mode 1
%     [TT_Alt2] NxN TravelTime Matrix for Mode 2
% Outputs:
%     [Share_Alt1] The modal split for Mode 1 [%]
%     [Share_Alt2] The modal split for Mode 2 [%]
% Note:
%     If the inputs are not properly normalised, the logit sensitivity
%     might needs tinkering. For more information see Logit Choice Model by
%     McFadden.
% Usage:
%     [SharePT,ShareCar] = logitUtility(1,TT_PT,TT_Car)
%
function [Share_Alt1,Share_Alt2] = logitUtility(LBeta,TT_Alt1,TT_Alt2)
    %Following McFadden: Logit Model: P(a) = e^Utility / e^U_1 + e^U_2) 
    % Prepare Quick Variables
    P_Util_Alt1 = exp(-LBeta .* TT_Alt1);    
    P_Util_Alt2 = exp(-LBeta .* TT_Alt2);
    SumUtil=P_Util_Alt1+P_Util_Alt2;
    %Modal Split is then determined using:
    Share_Alt1 = P_Util_Alt1 ./ SumUtil; %P(a) = e^U_a / (e^U_a + e^U_b)
    Share_Alt2 = P_Util_Alt2 ./ SumUtil; %P(b) = e^U_b / (e^U_a + e^U_b)
end
