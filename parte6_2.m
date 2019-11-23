% % ------------------------Lazo Abierto----------------------------------
% % ----------------------------------------------------------------------
s = tf('s');
% Funcion de transferencia del sistema
Gs6 = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs26 = tf(288800000,[1 16565 94600000]);

% fprintf('\nLazo Abierto :\n');

% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
% % ------------------------Respuesta al impulso discreta-------------------
% 
% % Tm6 = 3; % Tiempo de muestreo para pto 6
% Tm6 = 0.05; % Tiempo de muestreo para pto 7
% Gz6 = c2d(Gs6,Tm6,'tustin');
% inf16 = stepinfo(Gz6);
% ess6 = isstable(Gz6);% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf16);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess6);


% % -------------------Retenedor de orden cero (zoh)---------------------------

% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% % Ts26 = 1.1; % Tiempo de muestreo para pto 6
% % Tm26 = Ts26/10; % para pto 6
% Ts26 = 3.2; % Tiempo de muestreo para pto 7
% Tm26 = Ts26/100; %para pto 7
% Gz26 = c2d(Gs6,Tm26,'zoh');
% inf26 = stepinfo(Gz26);
% ess26 = isstable(Gz26);% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf26);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess26);


% % ------------------------Tranformación bilineal----------------------------------
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% % Tm36 = 1.1; % Tiempo de muestreo para pto 6
% % T= Tm36/10;
% Tm36 = 3.2; % Tiempo de muestreo para pto 7
% T= Tm36/100; %para pto 7
% G66 = ss(Gs26);
% Gz36 = bilin(G66,1,'Tustin',T);
% 
% Ex_ol6 =  exp(-0.1*s);
% Exss_ol6 = ss(Ex_ol6);
% Tpz_ol6 = c2d(Exss_ol6,T,'foh');
% Gze_ol6 = tf(Tpz_ol6*Gz36);
% 
% inf36 = stepinfo(Gze_ol6);
% ess36 = isstable(Gze_ol6);% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime)son:\n');
% disp(inf36);
% fprintf('\nError en estado estacionario es :%6.1f\n',ess36);
% 


% % ------------------------Lazo Cerrado----------------------------------
% % ----------------------------------------------------------------------
% 
fprintf('\nLazo Cerrado:\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
% 
% % T1m6  = 3; % Tiempo de muestreo para pto 6
% T1m6 = 0.05; % Tiempo de muestreo para pto 7
% Gz_cl6 = c2d(Gs6,T1m6,'tustin');
% F6 = ss(Gz_cl6);
% sys16 = feedback(F6,1,-1);
% % j6 = tf(sys1);
% inf_cl6 = stepinfo(step(sys16));
% ess_cl6 = isstable(step(sys16));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf_cl6);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess_cl6);

% 
% % -------------------Retenedor de orden cero (zoh)---------------------------
% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% % T2s6 = 1.1; % Tiempo de muestreo para pto 6
% % T2m6 = T2s6/10; %para pto 6
% T2s6 = 3.2; % Tiempo de muestreo para pto 7
% T2m6 = T2s6/100; %para pto 7
% Gz2_cl6 = c2d(Gs6,T2m6,'zoh');
% F26 = ss(Gz2_cl6);
% sys26 = feedback(F26,1,-1);
% inf2_cl6 = stepinfo(step(sys26));
% ess2_cl6 = isstable(step(sys26));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf2_cl6);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess2_cl6);
% 


% % ------------------------Tranformación bilineal----------------------------------
fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');

% T3m6 = 1.1; % Tiempo de muestreo para pto 6
% T36 = T3m6/10;
T3m6 = 1.26; % Tiempo de muestreo para pto 7
T36 = T3m6/100; %para pto 7
G_cl6 = ss(Gs26);
Gz3_cl6 = bilin(G_cl6,1,'Tustin',T36);
F3 = ss(Gz3_cl6);

Ex_cl6 =  exp(-0.1*s);
Exss_cl6 = ss(Ex_cl6);
Tpz_cl6 = c2d(Exss_cl6,T36,'foh');
Gze_cl6 = tf(Tpz_cl6*F3);

Ess_cl6 = ss(Gze_cl6);
sys36 = feedback(Ess_cl6,1,-1);
inf36 = stepinfo(step(sys36));
ess36 = isstable(step(sys36));% error de estado estacionario  [1 = True  0 = False]
fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime)son:\n');
disp(inf36);
fprintf('\nError en estado estacionario es :%6.1f\n',ess36);

