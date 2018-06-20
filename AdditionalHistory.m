function output = AdditionalHistory(input)
    % AvgLoadRatio
    for n=1:1:numel(input)
        for a=1:1:numel(input(n).Links)
            input(n).Links(a).Ratio=input(n).Links(a).Usage / input(n).Links(a).Capacity;
        end
        input(n).AvgLoadRatio=mean([input(n).Links.Ratio]);
    end

    AScore=0;
    for a=1:1:numel(input)
        AScore=AScore+input(a).Score;
        input(a).AScore=AScore;
    end

    %AvgDetour
    for n=1:1:numel(input)
    tempDetour=input(n).Detour;
    tempDetour(isnan(tempDetour))=Inf;
    input(n).AvgDetour=mean(tempDetour(~isinf(tempDetour)));
    end
    
    output=input;
end