function [V_t,M_t] = memristor_v_type2(i_t, deltat)
D = 10e-9;
uv = 1e-14;
Ron = 100;
Roff = 16e3;
Wo = 0.1*D;
% Wo = 0.1;
lambda = uv*Ron/(D^2);

k = D/Wo -1;
area = zeros(1,length(i_t));
for ii = 2:length(i_t)
    area(ii) = area(ii-1) + 1/2*(i_t(ii)+i_t(ii-1)) * deltat;
end

M_t = Roff + (Ron-Roff) .* exp(lambda .* area) ./ (k+exp(lambda .* area));

V_t = Roff .* (1-exp(lambda .* area) ./ (k+exp(lambda .* area))).*i_t;

end