function [i_t,M_t] = memristor_i(v_t, deltat)
D = 10e-9;
uv = 1e-14;
Ron = 1e5;
Roff = 16e6;
% W = 0.1*D;
Wo = 0.1;

Ro = Ron*Wo+Roff*(1-Wo);
k2 = uv*(1-Roff/Ron)*(Ron/D)^2;
i_t = zeros(1,length(v_t));
M_t = zeros(1,length(v_t));
M_t(1) = sqrt(Ro^2);
i_t(1) = v_t(1)/sqrt(Ro^2);
area = zeros(1,length(v_t));
for ii = 2:length(v_t)
    area(ii) = area(ii-1) + 1/2 * (v_t(ii)+v_t(ii-1)) * deltat;
    M_t(ii) = sqrt( Ro^2 + 2*k2* area(ii));
    i_t(ii) = v_t(ii)/(M_t(ii));
end

end


