function TripMatrix = GravityModel(SkimMatrix,Nodes,Mu,Sig)
% Determine the TripMatrix given Population Distribution, Distance Matrix
% and Node(count)

% Determine Nodecount & setup Population (target)Matrices
targethor=[Nodes.pop].* 3;
targetver=[Nodes.pop]';

%Determine initial TripMatrix based on the distance matrix and the
%Deterrence Function (exp-0.5*distance)
iterations=struct('TripMatrix',[]);
iter0=arrayfun(@(x) deter(x,Mu,Sig),SkimMatrix);
    % 50 iterations should ensure some sort of approximation
    for n=1:1:50
        if n==1 %First iteration, balance Attraction
            iterations(n).Curhor = sum(iter0);
            iterations(n).aij = targethor ./ iterations(n).Curhor;
            iterations(n).TripMatrix = iterations(n).aij .* iter0;
        else
            iterations(n).Curhor = sum(iterations(n-1).TripMatrix);
            iterations(n).Curver = sum(iterations(n-1).TripMatrix,2);
            iterations(n).aij = targethor ./ iterations(n).Curhor;
            iterations(n).bij = targetver ./ iterations(n).Curver;
            % The Odd/Even Switch to alternate balancing between production and attraction        
            if mod(n,2)==1 % Even iteration, balance Production
               iterations(n).TripMatrix = iterations(n).aij .* iterations(n-1).TripMatrix;
            else %odd iteration, balance Attraction
               iterations(n).TripMatrix = iterations(n).bij .* iterations(n-1).TripMatrix;
            end
        end
    end
TripMatrix = iterations(end).TripMatrix;    
end

% Deterrence function steers the balancing. Starting at 0 (no self travel)
% and there is a exponential decay function with a factor 0.05 resulting in
% max traveldist of approx 150km (just short of max-shortest path?) peaking
% at 25-50km
function output = deter(x,Mu,Sig)
    %output = x .* exp(-0.05.*x);
    output = lognpdf(x,log(Mu),Sig);
end
