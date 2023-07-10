function [V_t,M_t] = memristor_i_type2(i_t, deltat)
D = 10e-9;
uv = 1e-12;
Ron = 1e5;
Roff = 16e6;
% Wo = 0.1*D;
Wo = 0.1;
lambda = uv*Ron/(D^2);

k2 = D/Wo-1;
V_t = zeros(1,length(i_t));
area = zeros(1,length(i_t));
M_t = zeros(1,length(i_t));
M_t(1) = Roff + (Ron-Roff)*exp(lambda*area(1))/(k2+exp(lambda*area(1)));
V_t(1) = M_t(1)*i_t(1);

for ii = 2:length(i_t)
    area(ii) = area(ii-1) + 1/2*(i_t(ii)+i_t(ii-1)) * deltat;
    M_t(ii) = Roff + (Ron-Roff)*exp(lambda*area(ii))/(k2+exp(lambda*area(ii)));
    V_t(ii) = M_t(ii)*i_t(ii);
end

end