clear all; close all; clc;
Vdc = 0;
A1 = 1e-9;
A2 = -1e-9;
edge = (0:9);
[t,signal] = trapezoidal_signal(Vdc,A1,A2,edge);
figure
plot(t,signal)

tau = t(2)-t(1);

[v_t,M_t] = memristor_i_type2(signal, tau);



figure
plot(t,M_t)
xlabel("time");
ylabel("Resistance");
title("Memristör Modeli(Type 2 Voltage Driven)");

figure
plot(v_t,signal)

figure
plot(t,100 *M_t/M_t(1))