function [V_t,M_t] = memristor_v_type2_ik(i_t, deltat)
D = 10e-9;
uv = 1e-14;
Ron = 100;
Roff = 16e3;
% W = 0.1*D;
Wo = 0.1;
lambda = uv*Ron/(D^2);

Ro = Ron*Wo+Roff*(1-Wo);
k2 = (D/Wo)-1;
V_t = zeros(1,length(i_t));
V_t(1) = (Ro)*i_t(1);
M_t = zeros(1,length(i_t));
M_t(1) = Ro;
area = zeros(1,length(i_t));
for ii = 2:length(i_t)
    area(ii) = area(ii-1) + 1/2*(i_t(ii)+i_t(ii-1)) * deltat;
    M_t(ii) = Roff + ((Ron-Roff)*((exp(lambda*area(ii)))/(k2+exp(lambda*area(ii)))));
    %V_t = Roff*(1-exp(lambda*area(ii)/(k2+exp(lambda*area(ii)))));
end

end