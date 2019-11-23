% % ------------------------Lazo Abierto----------------------------------
% % ----------------------------------------------------------------------
s = tf('s');
% Funcion de transferencia del sistema
Gs = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs2 = tf(288800000,[1 16565 94600000]);

% fprintf('\nLazo Abierto:\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
%  
% % ------------------------Respuesta al impulso discreta-------------------
% 
% Tm = 0.1; % Tiempo de muestreo del Arduino UNO
% Gz = c2d(Gs,Tm,'tustin');
% inf1 = stepinfo(step(Gz));
% % h = tf(Gz);
% ess = isstable(step(Gz));% error de estado estacionario
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf1);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess);


% % -------------------Retenedor de orden cero (zoh)---------------------------
% 
% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% Ts2 = 2.2; % Tiempo de muestreo
% Tm2 = Ts2/10;
% Gz2 = c2d(Gs,Tm2,'zoh');
% % w = tf(Gz2)
% inf2 = stepinfo(step(Gz2));
% ess2 = isstable(step(Gz2));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf2);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess2);


% % % ------------------------Tranformación bilineal----------------------------------
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% Tm3 = 2.2; % Tiempo de muestreo
% T = Tm3/10;
% G = ss(Gs2);
% Gz3 = bilin(G,1,'Tustin',T);
% 
% Ex_ol =  exp(-0.1*s);
% Exss_ol = ss(Ex_ol);
% Tpz_ol = c2d(Exss_ol,T,'foh');
% Gze_ol = tf(Tpz_ol*Gz3);
% 
% inf3 = stepinfo(step(Gze_ol));
% ess3 = isstable(step(Gze_ol));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime)son:\n');
% disp(inf3);
% fprintf('\nError en estado estacionario es :%6.1f\n',ess3);

% ------------------------Lazo Cerrado----------------------------------
% ----------------------------------------------------------------------

fprintf('\nLazo Cerrado:\n');

% ---------------------Respuesta al impulso discreto--------------------
% % 
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
% T1m = 0.1; % Tiempo de muestreo del Arduino UNO
% Gz_cl = c2d(Gs,T1m,'tustin');
% F = ss(Gz_cl);
% sys1 = feedback(F,1,1);
% j = tf(sys1);
% inf_cl = stepinfo(step(sys1));
% ess_cl = isstable(step(sys1));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf_cl);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess_cl);


% -------------------Retenedor de orden cero (zoh)---------------------------
% 
% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% T2s = 2.2; % Tiempo de muestreo
% T2m = T2s/10;
% Gz2_cl = c2d(Gs,T2m,'zoh');
% F2 = ss(Gz2_cl);
% sys2 = feedback(F2,1,-1);
% inf2_cl = stepinfo(step(sys2));
% ess2_cl = isstable(step(sys2));% error de estado estacionario  [1 = True  0 = False]
% fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime) son :\n');
% disp(inf2_cl);
% fprintf('\nError en estado estacionario es :%6.1f\n', ess2_cl);

% ------------------------Tranformación bilineal----------------------------------
fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
T3m = 2.2; % Tiempo de muestreo
T3 = T3m/10;
G_cl = ss(Gs2);
Gz3_cl = bilin(G,1,'Tustin',T3);
F3 = ss(Gz3_cl);

Ex_cl =  exp(-0.1*s);
Exss_cl = ss(Ex_cl);
Tpz_cl = c2d(Exss_cl,T3,'foh');
Gze_cl = tf(Tpz_cl*F3);

Ess_cl = ss(Gze_cl);
sys3 = feedback(Ess_cl,1,-1);
inf3 = stepinfo(step(sys3));
ess3 = isstable(step(sys3));% error de estado estacionario  [1 = True  0 = False]
fprintf('\nEl sobreimpulso(Overshoot) y el tiempo de asentamiento(SettlingTime)son:\n');
disp(inf3);
fprintf('\nError en estado estacionario es :%6.1f\n',ess3);

