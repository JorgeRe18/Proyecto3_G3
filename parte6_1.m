s = tf('s');
% Funcion de transferencia del sistema
Gs6 = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs26 = tf(288800000,[1 16565 94600000]);


fprintf('\nLazo Abierto:\n');
% fprintf('\n--------------Respuesta al impulso discreta---------------------------- :\n');
%  
% ------------------------Respuesta al impulso discreta-----------------

% % Tm = 3 ; % Tiempo de muestreo para pto 6
% Tm = 0.05 ; % Tiempo de muestreo para pto 7
% [Nz6,Dz6] = c2d(Gs6,Tm,'tustin');
% % Gz6 = tf(Nz6, Dz6);
% y6 = dstep(Nz6,Dz6);
% % plot(y,':ch');
% 
% stairs(y6);
% title ('Respuesta al escalón para un motor CD');
% xlabel ('Tiempo[seg]');
% ylabel ('Amplitud');
% grid;
% 
% fprintf('La función de tranferencia resultante de la Respuesta al impulso discreta es:\n');
% % disp(Gz6);
% Gz6 = tf(Nz6, Dz6)


% ------------------------Retenedor de orden cero (zoh)----------------------------------
% fprintf('\n-------------------Retenedor de orden cero (zoh)--------------------------- :\n');
% % Ts26 = 1.1; % Tiempo de muestreo para pto 6
% % Tm26 = Ts26/10; %para pto 6
% Ts26 = 3.2; % Tiempo de muestreo para pto 7
% Tm26 = Ts26/100; %para pto 7
% Gz26 = c2d(Gs6,Tm26,'zoh');
% fprintf('La función de tranferencia resultante del retenedor de orden cero es:\n');
% Gz3s = tf(Gz26)
% % disp(Gz26);

% 
% % ------------------------Tranformación bilineal----------------------------------
% fprintf('\n-------------------Tranformación bilineal--------------------------- :\n');
% % Tm36 = 1.1; % Tiempo de muestreo para pto 6
% % T6 = Tm36/10;
% Tm36 = 3.2; % Tiempo de muestreo para pto 7
% T6 = Tm36/100; %para pto 7
% G6 = ss(Gs26);
% Gz36 = bilin(G6,1,'Tustin',T6);
% 
% Ex16 =  exp(-0.1*s);
% Exss16 = ss(Ex16);
% Tpz36 = c2d(Exss16,T6,'foh');
% 
% fprintf('La función de tranferencia resultante de la transformación bilineal(Tustin) es:\n');
% Gze6 = tf(Tpz36*Gz36)
% % disp(Gze6);
