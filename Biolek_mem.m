p = 10;

f = @(x) 1 - (2*x-1).^(2*p);
fs = 1e4;
t = 0:1/fs:10;
Va = 1.2;
f0 = 1;
V_t = Va * sin(2*pi*f0*t);
% V_t = 1.3 * (sin(2*pi*f0*t)).^2;
% V_t(t>=1.5) = - V_t(t>=1.5);
Ron = 100;
Roff = 16e3;
Rinit = 11e3;
% Roff = 38e3;
% Rinit = 28e3;
k=1e-14 * Ron / (10e-9)^2;
dxdt = @(it,x) k * it * f(x);

Rmem = zeros(size(t));
% Rmem(1) = Rinit;
i_t = zeros(size(t));
xx = zeros(size(t));
xx(1) = (Rinit - Roff) / (Ron-Roff);
Rmem(1) = Ron*xx(1)+Roff*(1-xx(1));
i_t(1) = V_t(1)/Rmem(1);
for tt = 2:length(t)
    xx(tt) =xx(tt-1) + dxdt(i_t(tt-1),xx(tt-1))/fs;
    if xx(tt)>1
        xx(tt) = 0.9;
    elseif xx(tt)<0
        xx(tt) = 0;
    end
    Rmem(tt) = Ron*xx(tt)+Roff*(1-xx(tt));
    if Rmem(tt)>Roff
        Rmem(tt) = Roff;
    elseif Rmem(tt)<Ron
        Rmem(tt) = Ron;
    end
    i_t(tt) = V_t(tt)/Rmem(tt);
end

tf = find(t == 0)
tt = tf:length(t);
figure(3)
plot(t(tt),V_t(tt))
hold on
    plot(t(tt),1e4*i_t(tt))
hold off

figure(2)
plot(V_t(tt),i_t(tt))

figure(4)
plot(t(tt),xx(tt));
