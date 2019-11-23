T_arduino = 0.1; % Tiempo de muestreo del Arduino UNO

fprintf('\n---------Controlador PID con la función de respuesta al impulso discreta----------- :\n');

s = tf('s');
Gz = c2d(F1,T_arduino,'tustin');

% 
Gs = tf(288800000,[1 16565 94600000],'InputDelay', 0.1);
Gzz = c2d(Gs,T_arduino,'tustin');
[Gpid1,info] = pidtune(Gzz,pidstd(1,1,1,1,0.1))

% Para Lazo Cerrado se tiene
G1cl = feedback(Ctry3*Gzz,1)

% Prueba de Estabilidad ante Impulso/Escalon/Rampa


% Graficas
figure(1);impulse(G1cl,'r');
figure(2);step(G1cl,'b');
stepinfo(G1cl)
