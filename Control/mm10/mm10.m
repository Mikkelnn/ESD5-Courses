s=tf('s');
sys1 = 1/(s*(s+1));%initial bode plot of the system
%bode(sys1)

lead = (6/0.6)*((s/0.6+1)/(s/6+1));%The calculated lead response that needs to be added
sys2 = sys1*lead;%The response of the system with the lead response added
%bode(sys2,sys1)%Plot comparing system 1 and 2
%legend('sys2', 'sys1');

sys3 = sys2*0.14;%Added a constant k that hopefully makes the system meet every criteria
%bode(sys1,sys2,sys3)%plot compairing the 3 systems found so far
%legend('sys1','sys2', 'sys3');

T = [0.1 0.05 0.025];
figure;
hold on; % To overlay all step response plots on the same figure

for i = 1:length(T)
    % Define the transfer function for the current T value
    Sample = 1/(s + 2/T(i));
    
    % Combine with sys3 if needed, otherwise use Sample directly
    sys4 = sys3 * Sample; 
    
    % Plot the step response
    step(sys4,10);
end
step(sys3,10)
% Add labels and title
title('Step Response for Different Values of T');
legend('T = 0.1', 'T = 0.05', 'T = 0.025','T=0');
hold off;

figure;
hold on; % To overlay all plots on the same figure

for i = 1:length(T)
    % Define the transfer function for the current T value
    Sample = 1/(s + 2/T(i));
    
    % Combine with sys3 if needed, otherwise plot Sample directly
    sys4 = sys3 * Sample;
    
    % Plot the Bode plot
    bode(sys4);
end
bode(sys3)
% Add labels and title
title('Bode Plot for Different Values of T');
legend('T = 0.1', 'T = 0.05', 'T = 0.025','T=0');
hold off;
%{
sys5 = (1/27000)*sys4;%Calculated constant to match the Kv criteria
bode(sys1,sys2,sys3,sys4,sys5);%Final plot comparing the systems and checking if 
%the lead/lag system meets the criteria
legend('sys1','sys2','sys3','sys4','sys5');
ClosedLoop = sys5/(1+sys5);%Closed loop transfer function with perfect sensor
step(ClosedLoop);%step response
step(ClosedLoop/s,14)  %ramp response
%}