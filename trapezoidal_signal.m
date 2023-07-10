function [t,signal] = trapezoidal_signal(Vdc,A1,A2,edge)
t = edge(1): (edge(end)-edge(1))*1e-3:edge(end);
signal = zeros(size(t));
state = 1;
for iter = 1:length(edge)-1
    ind = t<edge(iter+1) & t>=edge(iter);
    first = find(ind,1);
    last = find(ind,1,'last');
    delta = t(last)-t(first);
    if state == 1 || state == 5
        signal(ind) = Vdc;
    elseif state ==2
        signal(ind) = Vdc + A1/delta * (t(first:last)-t(first));
    elseif state==3
        signal(ind) = Vdc + A1;
    elseif state == 4
        signal(ind) = Vdc +A1- A1/delta * (t(first:last)-t(first));
    elseif state==6
        signal(ind) = Vdc + A2/delta * (t(first:last)-t(first));
    elseif state==7
        signal(ind) = Vdc + A2;
    elseif state==8
        signal(ind) = Vdc +A2- A2/delta * (t(first:last)-t(first));
        state = 0;
    end
    state = state +1;
end
end