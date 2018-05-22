%Capacity Scoring Function. Inputs the Capacity Candidate, Link Library,
%Construction Costs and some Value for Denied Boarding.

function [Score,UserBenefits,OperatorCosts] = CapacityScore(Candidate,Links,Alpha,VOT)
    Kappa = 7500; % Capacity Expansion Appreciation Parameter (TBD?) 
	% If the Candidate is non-existant, the start and EndNode are -1, so no score (-1) is used.
    if Candidate.StartNode== -1 || Candidate.EndNode== -1
        Score=-1;
        UserBenefits=0;
        OperatorCosts=0;
    else %There is an actual Capacity Candidate that we need to Score:
        % For Each link of the candidate determine the LinkLoad by
        % comparing the Preferred Usage / Capacity Ratio:
        for a=1:1:numel(Candidate.Links)
            LoadOld = Links(a).Usage ./ Links(a).Capacity; % Old Ratio (Before Implementation)
            LoadNew = Candidate.Links(a).Usage / Candidate.Links(a).Capacity; % New Ratio (After Implementation)
            dLoad = (LoadNew - LoadOld); % Change in Ratio

            if abs(LoadOld) < 1 %If the link was not fully used yet, Then there is no denied boarding, Thus Score = 0
                dBenefit(a)=0;
            %If Denied Boarding drops below 1 then, only the Actual Denied Fraction is accounted for
            elseif abs(LoadNew) <1 && dLoad > 0 % if the link now becomes underused Score = reduced by 1-load
                dBenefit(a) = dLoad.* Links(a).Usage .* (1-LoadNew);
            else %The link still is overused but so the full Denied Boarding benefits are experienced by users now able to travel
                dBenefit(a) = dLoad.* Links(a).Usage;
            end
        end
        UserBenefits = Kappa * VOT * sum([dBenefit]);% This is always the dLoad and the one link invested; 
        %Should these be made present value as well?
        OperatorCosts = Alpha * Candidate.NewLinkLength;
        Score = UserBenefits ./ OperatorCosts;
        if Score < 1
            Score = -1;
        end
	end
end
