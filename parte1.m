s = tf('s');
% Funcion de transferencia del sistema
Gs = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gs2 = tf(288800000,[1 16565 94600000]);

% ------------------------Respuesta al impulso discreta-----------------

Tm = 0.1 ; % Tiempo de muestreo del Arduino UNO
[Nz,Dz] = c2d(Gs,Tm,'tustin');
% Gz = tf(Nz, Dz)
y = dstep(Nz,Dz);
% plot(y,':ch');

stairs(y);
title ('Respuesta a un escalón para un motor CD');
xlabel ('Tiempo[seg]');
ylabel ('Amplitud');
grid;

fprintf('La función de tranferencia resultante de la Respuesta al impulso discreta es:\n');
% disp(Gz)
Gz = tf(Nz, Dz)


% Tiempo de estabilización el motor DC en lazo abierto es de 3s

% ------------------------Retenedor de orden cero (zoh)----------------------------------

Ts2 = 2.2; % Tiempo de muestreo
Tm2 = Ts2/10;
G1z2 = c2d(Gs,Tm2,'zoh');
fprintf('La función de tranferencia resultante del retenedor de orden cero es:\n');
% disp(Gz2);
Gz2 = tf(G1z2)

% 
% ------------------------Tranformación bilineal----------------------------------
Tm3 = 2.2; % Tiempo de muestreo
T = Tm3/10;
G = ss(Gs2);
G1z3 = bilin(G,1,'Tustin',T);

Ex1 =  exp(-0.1*s);
Exss1 = ss(Ex1);
Tpz3 = c2d(Exss1,T,'foh');

fprintf('La función de tranferencia resultante de la transformación bilineal(Tustin) es:\n');
% disp(Gze);
Gz3 = tf(Tpz3*G1z3)
