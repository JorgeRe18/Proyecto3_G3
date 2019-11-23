T_arduino = 0.1; % Tiempo de muestreo del Arduino UNO
% T_arduino = 3; % Punto 6
% T_arduino = 0.05; % Punto 7

fprintf('\n---------Controlador PID (Predictor Smith) con la función de respuesta al impulso discreta----------- :\n');

s = tf('s');
F1 = 1/(20*s+1);
Gz = c2d(F1,T_arduino,'tustin');
F2 = tf(Gz);
F2.InputName = 'dy';
F2.OutputName = 'dp';

% Process
Gs = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gzz = c2d(Gs,T_arduino,'tustin');
Pz = tf(Gzz);
Pz.InputName = 'u';
Pz.OutputName = 'y0';

% Prediction model
Gp = tf(288800000,[1 16565 94600000]);
Gpz= c2d(Gp,T_arduino,'tustin');
Gppz = tf(Gpz);
Gppz.InputName = 'u';
Gppz.OutputName = 'yp';

Dp =  exp(-0.1*s);
Dpz = c2d(Dp,T_arduino,'tustin');
Dppz = tf(Dpz);
Dppz.InputName = 'yp';
Dppz.OutputName = 'y1';

% Overall plant
S1 = sumblk('ym = yp + dp');
S2 = sumblk('dy = y0 - y1');
Plant = connect(Pz,Gppz,Dppz,F2,S1,S2,'u','ym');

% -----------------------------------------------------------------------------------
% Design PID controller with 0.08 rad/s bandwidth and 90 degrees phase margin
Options = pidtuneOptions('PhaseMargin',90);
C = pidtune(Plant,pidstd(1,5,0,1,T_arduino),1)
C.InputName = 'e';
C.OutputName = 'u';
% -----------------------------------------------------------------------------------

% Assemble closed-loop model from [y_sp,d] to y
Sum1 = sumblk('e = ysp - yp - dp');
Sum2 = sumblk('y = y0 + d');
Sum3 = sumblk('dy = y - y1');
Timpd = connect(Pz,Gppz,Dppz,C,F2,Sum1,Sum2,Sum3,{'ysp','d'},'y');
R1 = tf(Timpd)
figure(1);impulse(R1,'b');
figure(2);step(R1,'r')
stepinfo(R1(1))

% Entrada Escalon
E1 = tf(1,[1 0]);
E1z = c2d(E1,T_arduino,'zoh');
E1z.InputName = 'ye';
E1z.OutputName = 'ysp';
TE1z = connect(Pz,Gppz,Dppz,C,F2,Sum1,Sum2,Sum3,E1z,{'ye'},'y');
RE1 = tf(TE1z);

% Entrada  Rampa
U1 = tf(1,[1 0 0]);
U1z = c2d(U1,T_arduino,'zoh');
U1z.InputName = 'yr';
U1z.OutputName = 'ysp';
TU1z = connect(Pz,Gppz,Dppz,C,F2,Sum1,Sum2,Sum3,U1z,{'yr'},'y');
RU1 = tf(TU1z);
figure(3);impulse(RU1,'g')

% Estabilidad 
isstable(R1)  % Impulso
isstable(RE1) % Escalon
isstable(RU1) % Rampa