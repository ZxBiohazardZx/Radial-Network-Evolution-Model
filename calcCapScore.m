%Capacity Scoring Function. Inputs the Capacity Candidate, Link Library,
%Construction Costs and some Value for Denied Boarding.
function [Benefits,Costs,Score] = calcCapScore(CandidateIn,Links,Alpha,VOT)
    Kappa = 100*VOT; % Capacity Expansion Appreciation Parameter (BLACK-BOX / MAGIC NUMBER 

    % No Score if there is no need for expansion (OverCapacity)
    if CandidateIn.Denied < 0
        Benefits = -1; Costs = Alpha*CandidateIn.NewLinkLength;Score = -1; % Debug Values
    else % There is a need for Capacity Expansion
        % For all links in the Candidate check if there is a change and if so, compute the dLoad
        for a=1:1:numel(CandidateIn.Links)
            if Links(a).Capacity ~= CandidateIn.Links(a).Capacity
                %Then compare the ratios for score urgency parameter
                LoadOld = Links(a).Usage ./ Links(a).Capacity; % Old Ratio (Before Implementation)
                LoadNew = CandidateIn.Links(a).Usage / CandidateIn.Links(a).Capacity; % New Ratio (After Implementation)
                if LoadNew < 1 
                    dLoad = LoadOld -1; % Only account for Denied Boarding Ratio Portion
                else
                    dLoad = (LoadNew - LoadOld); % "Full" Change in Ratio
                end
            else
                dLoad=0;
            end
            dBenefits(a) = dLoad .* CandidateIn.Links(a).Usage;

        end
        % Benefits are the Appreciation of reduction in denied boarding 
        Benefits = Kappa * sum([dBenefits]);
        Costs = Alpha * CandidateIn.NewLinkLength; %Cost*Length
        
        % DISCOUNT UserBenefits are Annual Benefits for 30 years
        A=Benefits*ones(1,30);A(1)=0; % Create Array & Assing Benefits first year as 0
        Benefits=pvvar(A,0.05);       % Apply Net Present Value Function @ 5% Rate (Common value)

        %Operator Costs have the same functionality: 
        B=zeros(1,30);B(1)=-Costs; % Create Array & Assing Costs non-year1 as 0
        Costs=-pvvar(B,0.05);     % Apply Net Present Value Function @ 5% Rate (Common value)
    
        Score = Benefits / Costs;

        %Score = Benefits ./ Costs;
        if Score < 1
            Score = -1;
        end
    end
end
