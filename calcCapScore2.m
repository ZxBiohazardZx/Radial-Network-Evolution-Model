%Capacity Scoring Function. Inputs the Capacity Candidate, Link Library,
%Construction Costs and some Value for Denied Boarding.
function [Benefits,Costs,Score] = calcCapScore2(CandidateIn,Alpha,CapValue,VOT,VMode,VAlt,MaxCapacity)
    % No Score if there is no need for expansion (OverCapacity)
    if CandidateIn.Denied < 0 || CandidateIn.CapacityBefore >= MaxCapacity
        Benefits = -1; Costs = Alpha*CandidateIn.NewLinkLength;Score = -1; % Debug Values
    else % There is a need for Capacity Expansion
        Link_TT =(CandidateIn.NewLinkLength / VMode);
        if CandidateIn.DeniedAfter > 0
            % If the Candidate has a remaining Denied Capacity, Full CapValue is benefit for users:
            % 7*LinkTT - Link TT = 6* Link_TT Reduction
            d_TT = CapValue * (-6 * Link_TT);
        else %There is no remaining Denied thus we only get a fraction of the benefits!
            TT_Before = (CandidateIn.CapacityBefore * Link_TT ) + CandidateIn.Denied *(7*Link_TT);
            TT_After  = (CandidateIn.LinkUsage * Link_TT );
            d_TT = TT_After - TT_Before;
        end
        Benefits = d_TT * VOT * 8760;
%         % For all links in the Candidate check if there is a change and if so, compute the dLoad
%         if CandidateIn.DeniedAfter > 0
%             d_Denied = CapValue; %We assume max capacity increment as benefits
%         else
%             d_Denied = CandidateIn.Denied; %We assume remaning denial as benefits
%         end
%         hourBenefits = d_Denied * (CandidateIn.NewLinkLength / (VMode/VAlt)); %[UserHours]
%         Benefits = hourBenefits * 7 * -VOT * 8760;
%                    % [Hours]     [Money/Hour/Year]
        % Benefits are the Appreciation of reduction in denied boarding 
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
