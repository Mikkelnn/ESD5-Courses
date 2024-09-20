%Excercise 1. Det her er ikke chat kode det er mit alt sammen, bare kig på
%underskriften

% Given transfer function parameters
fs = 10;  % Sampling frequency in Hz
T = 1 / fs;  % Sampling interval

% Continuous-time transfer function H(s) = 2 / ((s+1)*(s+3))
num_s = [2];  % Numerator of H(s)
den_s = [1 4 3];  % Denominator of H(s), expanded (s+1)*(s+3)

% Bilinear transformation
[num_z, den_z] = bilinear(num_s, den_s, fs);

% Frequency response of the discrete system
[H, w] = freqz(num_z, den_z, 512, fs);

% Plot the frequency response
figure;
plot(w, 20*log10(abs(H)));
title('Frequency Response of Discrete System');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Display the discrete-time transfer function coefficients
disp('Numerator coefficients (z-domain):');
disp(num_z);
disp('Denominator coefficients (z-domain):');
disp(den_z);
%Signed Johan Theil

%Excercise 1.b
% Given parameters
fs = 10;  % Sampling frequency in Hz
T = 1 / fs;  % Sampling interval

% Continuous-time transfer function H(s) = 2 / ((s+1)*(s+3))
num_s = [2];  % Numerator of H(s)
den_s = [1 4 3];  % Denominator of H(s), expanded (s+1)*(s+3)

% Continuous-time frequency response
w_cont = logspace(-1, 2, 1000);  % Frequency range (rad/s)
[H_s, w_cont] = freqs(num_s, den_s, w_cont);  % Continuous-time frequency response

% Bilinear transformation to obtain discrete-time transfer function
[num_z, den_z] = bilinear(num_s, den_s, fs);

% Discrete-time frequency response
[H_z, w_disc] = freqz(num_z, den_z, 512, fs);  % Discrete-time frequency response

% Plot continuous-time frequency response
figure;
subplot(2,1,1);
semilogx(w_cont / (2*pi), 20*log10(abs(H_s)), 'b');
title('Continuous-Time Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Plot discrete-time frequency response
subplot(2,1,2);
plot(w_disc, 20*log10(abs(H_z)), 'r');
title('Discrete-Time Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Display transfer function coefficients
disp('Discrete-time transfer function coefficients:');
disp('Numerator coefficients (z-domain):');
disp(num_z);
disp('Denominator coefficients (z-domain):');
disp(den_z);
