Tmb = 0.9; % Tiempo de muestreo
Tm_bi = Tmb/10;

fprintf('\n---------Controlador PID (Predictor Smith) con la función de Tranformación bilineal----------- :\n');

s = tf('s');
F1 = 1/(20*s+1);
Fb = ss(F1);
Gfz3 = bilin(Fb,1,'Tustin',Tm_bi);
Fbil = tf(Gfz3);
Fbil.InputName = 'dy';
Fbil.OutputName = 'dp';

% Process
Gs3z = tf(288800000,[1 16565 94600000]);
Gb = ss(Gs3z);
Gzzz = bilin(Gb,1,'Tustin',Tm_bi);
Pz3 = tf(Gzzz);
Pz3.InputName = 'u';
Pz3.OutputName = 'y0';

% Prediction model
Gp3 = tf(288800000,[1 16565 94600000]);
Gq = ss(Gp3);
Gpz3= bilin(Gq,1,'Tustin',Tm_bi);
G3 = tf(Gpz3);
Ex3 =  exp(-0.1*s);
Exss = ss(Ex3);
Tpz3 = c2d(Ex3,Tm_bi,'foh');
Gppz3 = tf(Tpz3*G3);
Gppz3.InputName = 'u';
Gppz3.OutputName = 'yp';

Dp3 =  exp(-0.1*s);
D3 = ss(Dp3);
Dpz3 = c2d(D3,Tm_bi,'foh');
Dppz3 = tf(Dpz3);
Dppz3.InputName = 'yp';
Dppz3.OutputName = 'y1';

% Overall plant
S1 = sumblk('ym = yp + dp');
S2 = sumblk('dy = y0 - y1');
Plant3 = connect(Pz3,Gppz3,Dppz3,Fbil,S1,S2,'u','ym');


% -----------------------------------------------------------------------------------
% Design PID controller with 0.08 rad/s bandwidth and 90 degrees phase margin
Options = pidtuneOptions('PhaseMargin',90);
C3 = pidtune(Plant3,pidstd(11.37,0.0051,0.00000191,0.000001,Tm_bi),0.08,Options);
C3.InputName = 'e';
C3.OutputName = 'u';
% -----------------------------------------------------------------------------------

% Assemble closed-loop model from [y_sp,d] to y
Sum1 = sumblk('e = ysp - yp - dp');
Sum2 = sumblk('y = y0 + d');
Sum3 = sumblk('dy = y - y1');
Tbil = connect(Pz3,Gppz3,Dppz3,C3,Fbil,Sum1,Sum2,Sum3,{'ysp','d'},'y');
R3 = tf(Tbil);
figure(1);impulse(R3,'b');
figure(2);step(R3,'r')

% Entrada Escalon
E3 = tf(1,[1 0]);
E3z = c2d(E3,Tm2_zoh,'foh');
E3z.InputName = 'ye';
E3z.OutputName = 'ysp';
TE3z = connect(Pz2,Gppz2,Dppz2,C2,Fzoh,Sum1,Sum2,Sum3,E3z,{'ye'},'y');
RE3 = tf(TE3z);

% Entrada  Rampa
U3 = tf(1,[1 0 0]);
U3z = c2d(E2,Tm2_zoh,'foh');
U3z.InputName = 'yr';
U3z.OutputName = 'ysp';
TU3z = connect(Pz2,Gppz2,Dppz2,C2,Fzoh,Sum1,Sum2,Sum3,U3z,{'yr'},'y');
RU3 = tf(TU3z);
figure(3);impulse(RU3,'g')

% Estabilidad 
isstable(R3)  % Impulso
isstable(RE3) % Escalon
isstable(RU3) % Rampa