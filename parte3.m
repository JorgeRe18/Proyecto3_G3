% % ------------------------Lazo Abierto----------------------------------
% % ----------------------------------------------------------------------
s = tf('s');
% Funcion de transferencia del sistema
Gs = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs2 = tf(288800000,[1 16565 94600000]);

fprintf('\nLazo Abierto:\n\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
%  
% Tm = 0.1; % Tiempo de muestreo del Arduino UNO
% G1z = c2d(Gs,Tm,'tustin');  
% d = tf(G1z);
% P1 = [1 0 1.993 0.993]; %Se quita el cero para routh
% [M, L] = routh_hurwitz(P1,10);%el numero 2 fue aletorio
% [ T ]= juryC(P1);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M, L]);


% -------------------Retenedor de orden cero (zoh)---------------------------

fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');

Ts2_ol = 2.2; % Tiempo de muestreo
Tm2_ol = Ts2_ol/10;
G2z_ol = c2d(Gs,Tm2_ol,'zoh');
Gp = tf(G2z_ol);
P2 = [1 0 0 0]; %Se saca poniendo en el command window la función(tf)-->se usan los polos 
[M2, L2] = routh_hurwitz(P2,10);%el numero 2 fue aletorio
[ T2 ]= juryC(P2);
fprintf('\nEl metodo de Jury :\n\n');
disp(T2);
fprintf('\nTabla de Routh Hurwitz :\n\n');
disp([M2, L2]);

% % ------------------------Tranformación bilineal----------------------------------
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% Tm3 = 2.2; % Tiempo de muestreo
% T = Tm3/10;
% G = ss(Gs2);
% Gz3_ol = bilin(G,1,'Tustin',T);
% 
% Ex1_ol =  exp(-0.1*s);
% Exss1_ol = ss(Ex1_ol);
% Tpz1_ol = c2d(Exss1_ol,T,'foh');
% Gze1_ol = tf(Tpz1_ol*Gz3_ol);
% 
% Gp = tf(Gze1_ol);
% P3 = [1 1.997 0.9968 0];
% [M3, L3] = routh_hurwitz(P3,10);%el numero 10 fue aletorio
% % [ T3 ]= juryC(P3);
% % fprintf('\nEl metodo de Jury :\n\n');
% % disp(T3);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M3, L3]);

% ------------------------Lazo Cerrado----------------------------------
% ----------------------------------------------------------------------

% fprintf('\nLazo Cerrado :\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
% 
% T1s = 0.1; % Tiempo de muestreo del Arduino UNO
% Gz_cl = c2d(Gs,T1s,'tustin');
% F = ss(Gz_cl);
% sys1 = feedback(F,1,-1);
% m = tf(sys1);
% [P1_cl] = [1 5.035 7.077 3.042];
% [M4, L4] = routh_hurwitz(P1_cl,10);%el numero 10 fue aletorio
% % [ T4 ]= juryC(P1_cl);
% % fprintf('\nEl metodo de Jury :\n\n');
% % disp(T4);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M4, L4]);


% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% 
% Ts2_cl = 2.2; % Tiempo de muestreo
% Tm2_cl = Ts2_cl/10;
% G2z_cl = c2d(Gs,Tm2_cl,'zoh');
% F2_cl = ss(G2z_cl);
% sys2_cl = feedback(F2_cl,1,-1);
% Gp2 = tf(sys2_cl);
% P2_cl = [1 0 3.053]; %se quitan esos ceros para routh
% [M5, L5] = routh_hurwitz(P2_cl,10);%el numero 2 fue aletorio
% % [ T5 ]= juryC(P2_cl);
% % fprintf('\nEl metodo de Jury :\n\n');
% % disp(T5);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M5, L5]);

% 
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% Tm3_cl = 2.2; % Tiempo de muestreo
% T_cl = Tm3_cl/10;
% Fexp =  exp(-0.1*s);
% 
% Exp = ss(Fexp);
% Dpz3 = c2d(Exp,T_cl,'foh');
% Dppz3 = tf(Dpz3);
% G = ss(Gs2);
% Gz3_cl = bilin(G,1,'Tustin',T_cl);
% F3_cl = ss(Gz3_cl* Dppz3);
% 
% sys3_cl = feedback(F3_cl,1,-1);
% Gp3 = tf(sys3_cl);
% P3_cl = [1 2.519 2.04 0.5203]; %quitar el cero para routh
% [M6, L6] = routh_hurwitz(P3_cl,10);%el numero 2 fue aletorio
% [ T6 ]= juryC(P3_cl);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T6);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M6, L6]);

