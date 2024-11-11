

% Define SNR values to test
SNR_values = [-20, -15, -10, -5, 0, 5, 10, 15, 20];
Pe_results = zeros(size(SNR_values));  % Initialize array to store Pe for each SNR

% Load the Simulink model
model_name = 'pam_system';  % Replace with the name of your model
load_system(model_name);

for i = 1:length(SNR_values)
    % Set the SNR in the AWGN block
    set_param([model_name '/AWGN Channel'], 'SNR', num2str(SNR_values(i)));
    
    % Run the simulation
    sim(model_name);
    
    % Retrieve out.x and out.xhat from the workspace
    
    % Calculate Probability of Error, Pe
    Pe = 1 - sum(out.x(1:end-1) == out.xhat(2:end)) / length(out.x(1:end-1));
    
    % Store the result for this SNR
    Pe_results(i) = Pe;
    
    % Display the result for each SNR
    fprintf('SNR = %d dB, Pe = %e\n', SNR_values(i), Pe);
end

% Plot Pe vs. SNR
figure;
plot(SNR_values, Pe_results, '-o');
xlabel('SNR (dB)');
ylabel('Probability of Error, Pe');
title('Bit Error Rate vs SNR');
grid on;
