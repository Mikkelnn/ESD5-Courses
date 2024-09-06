s=tf('s');
T=1.21/(s^2+s+1.21);
figure(1); step(T,30)
figure(2); step(T/s,5)
figure(3); step(T/s^2,5)