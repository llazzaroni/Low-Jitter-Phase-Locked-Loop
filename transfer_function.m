% Parameters
KVCO = 0.0139 * 1e12 * 2 * 3.1415; % [rad/Vs]
Gm = 0.228e-6; % [A/V]
FREF = 100e6; % [Hz]
TREF = 1 / FREF; % [s]
KPD = 0.9*12.5; % [V/rad]
M = 160; % fixed
Rp = 30000; % [Ohm]
Cp1 = 5e-12; % [F]
Cp2 = 0.5e-12; % [F]

% Open loop transfer function
numeratorOPL = [Rp*Cp1,1];
denominatorOPL = [Rp*Cp1*Cp2,Cp1+Cp2,0,0];
sysOPL = tf(numeratorOPL,denominatorOPL) * KVCO * Gm * KPD;

% Open loop transfer function with feedback
sysOPLB = sysOPL / M;

% Bode plot and phase margin
bode(sysOPLB)
[Gm, Pm, Wcg, Wcp] = margin(sysOPLB);

% Closed loop transfer function
sysCLP = sysOPL / (sysOPL / M + 1); % True transfer function
bode(sysCLP);
step(sysCLP);

omega_n = sqrt(KVCO*KPD*Gm/(M*Cp1));
xi = ((KVCO*KPD*Gm*Cp1/M)^(1/2))*Rp/2;