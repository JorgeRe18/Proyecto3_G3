% % -----------------------------------------------Lazo Abierto-------------------------------------------
% % -------------------------------------------------------------------------------------------------------
s = tf('s');
% Funcion de transferencia del sistema
Gs6 = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs26 = tf(288800000,[1 16565 94600000]);

 fprintf('\nLazo Abierto :\n\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
%  
% % Tm6 = 3; % Tiempo de muestreo para pto 6
% Tm6 = 0.05; % Tiempo de muestreo para pto 7
% G1z6 = c2d(Gs6,Tm6,'tustin');
% d6 = tf(G1z6);
% % P16 = [1 2 0.998]; %para pto 6 
% P16 = [1 1.986 0.986]; %para pto 7
% [M6, L6] = routh_hurwitz(P16,10);%el numero 2 fue aletorio
% % [ T6 ]= juryC(P16);
% % fprintf('\nEl metodo de Jury :\n\n');
% % disp(T6);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M6, L6]);


% -------------------Retenedor de orden cero (zoh)---------------------------

% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');

% % Ts2_ol6 = 1.1; % Tiempo de muestreo para pto 6
% % Tm2_ol6 = Ts2_ol6/10;%para pto 6
% Ts2_ol6 = 3.2; % Tiempo de muestreo para pto 7
% Tm2_ol6 = Ts2_ol6/100;%para pto 7
% G2z_ol6 = c2d(Gs6,Tm2_ol6,'zoh');
% Gp6 = tf(G2z_ol6)
% % P26 = [1 0 0 0];  %para pto 6 
% P26 = [1 -1.54e-115 6.154e-231];  %para pto 7
% [M26, L26] = routh_hurwitz(P26,10);%el numero 10 fue aletorio
% [ T26 ]= juryC(P26);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T26);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M26, L26]);


% ------------------------Tranformación bilineal----------------------------------
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% % Tm36 = 1.1; % Tiempo de muestreo para pto 6
% % Tb6 = Tm36/10;
% Tm36 = 3.2; % Tiempo de muestreo para pto 7
% Tb6 = Tm36/100;%para pto 7
% Gb6 = ss(Gs26);
% Gz3_ol6 = bilin(Gb6,1,'Tustin',Tb6);
% 
% Ex1_ol6 =  exp(-0.1*s);
% Exss1_ol6 = ss(Ex1_ol6);
% Tpz1_ol6 = c2d(Exss1_ol6,Tb6,'foh');
% Gze1_ol6 = tf(Tpz1_ol6*Gz3_ol6);
% 
% Gp6 = tf(Gze1_ol6);
% % P36 = [1 1.994 0.9937 0];%para pto 6 
% P36 = [1 1.978 0.9783 0]; %para pto 7
% [M36, L36] = routh_hurwitz(P36,8);%el numero 8 fue aletorio
% [ T36 ]= juryC(P36);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T36);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M36, L36]);

% -------------------------------------------------Lazo Cerrado--------------------------------------------------------
% ---------------------------------------------------------------------------------------------------------------------

% fprintf('\nLazo Cerrado:\n');

% 
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
% 
% T1s6= 3; % Tiempo de muestreo para pto 6
% % T1s6= 0.05; % Tiempo de muestreo para pto 7
% Gz_cl6 = c2d(Gs6,T1s6,'tustin');
% F66 = ss(Gz_cl6);
% sys16 = feedback(F66,1,-1);
% m6 = tf(sys16);
% [P1_cl6] = [1 2 0.999]; %para pto 6
% % [P1_cl6] = [1 1.986 4.018 6.063 3.032]; %para pto 7
% [M46, L46] = routh_hurwitz(P1_cl6,10);%el numero 10 fue aletorio
% % [ T46 ]= juryC(P1_cl6);
% % fprintf('\nEl metodo de Jury :\n\n');
% % disp(T46);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M46, L46]);


% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% % 
% % Ts2_6 = 1.1; % Tiempo de muestreo para pto 6
% % Tm2_cl6 = Ts2_6/10; %para pto 6
% Ts2_6 = 3.2; % Tiempo de muestreo para pto 7
% Tm2_cl6 = Ts2_6/100; %para pto 7
% G2z_cl6 = c2d(Gs6,Tm2_cl6,'zoh');
% F2_cl6 = ss(G2z_cl6);
% sys2_cl6 = feedback(F2_cl6,1,-1);
% Gp26 = tf(sys2_cl6);
% % P2_cl6 = [1 3.053 0]; %para pto 6 los cero están para q dé
% P2_cl6 = [1 2.665e-15 -2.109e-15 6.661e-16 3.053 0 0]; %para pto 7 
% [M56, L56] = routh_hurwitz(P2_cl6,10);%el numero 2 fue aletorio
% [ T56 ]= juryC(P2_cl6);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T56);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp(simplify([M56, L56]));


% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% % Tm36_cl6 = 1.1; % Tiempo de muestreo para pto 6
% % T_cl6 = Tm36_cl6/10;%para pto 6
% Tm36_cl6 = 3.2; % Tiempo de muestreo para pto 7
% T_cl6 = Tm36_cl6/100; %para pto 7
% Fexp6 =  exp(-0.1*s);
% Exp6 = ss(Fexp6);
% Dpz36 = c2d(Exp6,T_cl6,'foh');
% Dppz36 = tf(Dpz36);
% 
% Gbl6 = ss(Gs26);
% Gz3_cl6 = bilin(Gbl6,1,'Tustin',T_cl6);
% j = tf(Gz3_cl6*Dppz36);
% F3_cl6 = ss(j);
% 
% sys3_cl6 = feedback(F3_cl6,1,-1);
% Gp36 = tf(sys3_cl6); 
% % P3_cl6 = [1 4.162 5.329 2.167];%para pto 6
% P3_cl6 = [1 1.978 0.9783 2.642 5.662 3.397 0.3775];%para pto 7 
% [M66, L66] = routh_hurwitz(P3_cl6,10);%el numero 10 fue aletorio
% [ T66 ]= juryC(P3_cl6);
% fprintf('\nEl metodo de Jury :\n\n');
% disp(T66);
% fprintf('\nTabla de Routh Hurwitz :\n\n');
% disp([M66, L66]);

