Tmz = 0.9; % Tiempo de muestreo
Tm2_zoh = Tmz/10;

fprintf('\n---------Controlador PID (Predictor Smith) con la función de Retenedor de orden cero (zoh)----------- :\n');

s = tf('s');
F1 = 1/(20*s+1);
Gfz = c2d(F1,Tm2_zoh,'zoh');
Fzoh = tf(Gfz);
Fzoh.InputName = 'dy';
Fzoh.OutputName = 'dp';

% Process
Gs2z = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gzz = c2d(Gs2z,Tm2_zoh,'zoh');
Pz2 = tf(Gzz);
Pz2.InputName = 'u';
Pz2.OutputName = 'y0';

% Prediction model
Gp2 = tf(288800000,[1 16565 94600000]);
Gpz2= c2d(Gp2,Tm2_zoh,'zoh');
Gppz2 = tf(Gpz2);
Gppz2.InputName = 'u';
Gppz2.OutputName = 'yp';

Dp2 =  exp(-0.1*s);
Dpz2 = c2d(Dp2,Tm2_zoh,'zoh');
Dppz2 = tf(Dpz2);
Dppz2.InputName = 'yp';
Dppz2.OutputName = 'y1';

% Overall plant
S1 = sumblk('ym = yp + dp');
S2 = sumblk('dy = y0 - y1');
Plant2 = connect(Pz2,Gppz2,Dppz2,Fzoh,S1,S2,'u','ym');

% -----------------------------------------------------------------------------------
% Design PID controller with 0.08 rad/s bandwidth and 90 degrees phase margin
Options = pidtuneOptions('PhaseMargin',90);
C2 = pidtune(Plant2,pidstd(11.37,0.0051,0.00000191,0.000001,Tm2_zoh),0.08,Options);
C2.InputName = 'e';
C2.OutputName = 'u';
% -----------------------------------------------------------------------------------

% Assemble closed-loop model from [y_sp,d] to y
Sum1 = sumblk('e = ysp - yp - dp');
Sum2 = sumblk('y = y0 + d');
Sum3 = sumblk('dy = y - y1');
Tzoh = connect(Pz2,Gppz2,Dppz2,C2,Fzoh,Sum1,Sum2,Sum3,{'ysp','d'},'y');
R2 = tf(Tzoh);
figure(1);impulse(R2,'b');
figure(2);step(R2,'r')

% Entrada Escalon
E2 = tf(1,[1 0]);
E2z = c2d(E2,Tm2_zoh,'zoh');
E2z.InputName = 'ye';
E2z.OutputName = 'ysp';
TE2z = connect(Pz2,Gppz2,Dppz2,C2,Fzoh,Sum1,Sum2,Sum3,E2z,{'ye'},'y');
RE2 = tf(TE2z);

% Entrada  Rampa
U2 = tf(1,[1 0 0]);
U2z = c2d(E2,Tm2_zoh,'zoh');
U2z.InputName = 'yr';
U2z.OutputName = 'ysp';
TU2z = connect(Pz2,Gppz2,Dppz2,C2,Fzoh,Sum1,Sum2,Sum3,U2z,{'yr'},'y');
RU2 = tf(TU2z);
figure(3);impulse(RU2,'g')

% Estabilidad 
isstable(R2)  % Impulso
isstable(RE2) % Escalon
isstable(RU2) % Rampa