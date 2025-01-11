s=tf('s');

Gs = (1/(10*s+1))^2;
Hs = 1/(0.1*s+1);
OpenLoop = Gs*Hs;
bode(OpenLoop);
ti = 10;
Ds = (ti*s+1)/(ti*s);
sys1 = OpenLoop*Ds;
%bode(OpenLoop,sys1);
%legend('system a', 'system b');
Ki = 10^(2.73/20);
sys2 = sys1*Ki;
bode(OpenLoop,sys1, sys2);
legend('system a', 'system b no gain', 'system b with gain');