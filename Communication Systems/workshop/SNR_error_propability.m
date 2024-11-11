%modelName = 'pam_system';
%load_system(modelName);
%snr = '20';
%set_param([modelName '/AWGN Channel'],'SNR', snr);
%sim(modelName);

%STEPS:
%Set SNR in AWGN-block
%Run SIMULINK
%Run this script

Pe = 1 - sum(out.x(1:end-1) == out.xhat(2:end)) / length(out.x(1:end-1));
Pe

% SNR: -20 dB
%Pe = 0.3000

% SNR: -15 dB
%Pe = 0.1600

% SNR: -10 dB
%Pe = 0.0400

% SNR: -5 dB
%Pe = 0.0100

% SNR: 0 dB
%Pe = 0

% SNR: 5 dB
%Pe = 0

% SNR: 10 dB
%Pe = 0

% SNR: 15 dB
%Pe = 0

% SNR: 20 dB
%Pe = 0