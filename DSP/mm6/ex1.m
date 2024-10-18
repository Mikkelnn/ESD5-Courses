% Call function here
transBand = 0.01; % Transition band
peakApproxErr = 0.001; %peak approximation error 
filterOrder = 100; % Filter order
bessleApprox = 20; % terms for Bessel function approximation

kaiserWindowPlot(transBand, peakApproxErr, filterOrder, bessleApprox);



function kaiserWindowPlot(Delta_f, Delta_p, M, N_bessel)
    % Function to plot Kaiser Window using the width of the transition band, 
    % peak approximation error, filter order M, and Bessel function terms (N_bessel).
    %
    % Inputs:
    % Delta_f   - Filter transition band width
    % Delta_p   - Peak approximation error
    % M         - Filter order
    % N_bessel  - Number of terms used in the Bessel function approximation
    
    % Step 1: Calculate Beta based on approximation error and transition band
    A = -20*log10(Delta_p); % Attenuation in dB based on approximation error
    if A > 50
        beta = 0.1102*(A - 8.7);
    elseif A >= 21
        beta = 0.5842*(A - 21)^0.4 + 0.07886*(A - 21);
    else
        beta = 0;
    end
    
    % Step 2: Create Kaiser window using Bessel function approximation
    % Compute window points
    n = 0:M; % Time samples
    
    % Compute the Kaiser window with Bessel approximation
    w = zeros(1, length(n)); % Initialize Kaiser window
    for i = 1:length(n)
        t = 2*(n(i) / M) - 1; % Normalized time index
        w(i) = besselI0(beta * sqrt(1 - t^2), N_bessel) / besselI0(beta, N_bessel);
    end
    
    % Step 3: Plot the time domain representation
    figure;
    stem(n, w, 'filled');
    title(['Kaiser Window (M = ' num2str(M) ', Beta = ' num2str(beta) ')']);
    xlabel('n');
    ylabel('w[n]');
    grid on;
    w1 = kaiser(M,beta);
    [W1,f] = freqz(w1/sum(w1),1,512,2);
    figure;
    plot(f,20*log10(abs(W1)))
end

% Local function to compute the modified Bessel function of the first kind (I0)
% with N terms
function I = besselI0(x, N)
    % Approximate the zeroth-order modified Bessel function of the first kind (I0)
    % using the first N terms of the series expansion.
    I = 0;
    for k = 0:N-1
        I = I + ((1/factorial(k)) * (x/2)^k)^2;
    end
end

