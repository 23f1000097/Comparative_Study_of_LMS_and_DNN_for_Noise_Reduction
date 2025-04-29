% Live Audio Noise Cancellation using LMS Adaptive Filtering in MATLAB
% for vocal noise cancellation, preserving speech

% Parameters
fs = 44100;              % Sampling frequency (44.1 kHz)
duration = 15;           % Duration for recording (15 seconds)
filter_order = 32;       % Order of the adaptive filter
mu = 0.005;             % Step size for the LMS algorithm

% 1. Set up the audio recorder
recObj = audiorecorder(fs, 16, 1); % 16-bit, mono audio
disp('Start speaking...');
recordblocking(recObj, duration);  % Record audio for the specified duration
disp('End of Recording.');

% Get the recorded audio data
recorded_signal = getaudiodata(recObj); % Recorded signal (with noise and speech)

% Pre-process: Apply a high-pass filter to reduce low-frequency noise
hp_cutoff = 300; % High-pass filter cutoff frequency (e.g., 300 Hz)
[b, a] = butter(6, hp_cutoff / (fs / 2), 'high');
filtered_signal = filter(b, a, recorded_signal);

% Plot the filtered signal
figure;
plot((1:length(filtered_signal)) / fs, filtered_signal);
title('High-Passed Signal (After Initial Noise Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');

% 2. Detect silent regions for noise estimation
threshold = 0.02; % Threshold to identify silence (adjust based on noise level)
silent_samples = find(abs(filtered_signal) < threshold);
estimated_noise = mean(filtered_signal(silent_samples)); % Estimate noise

% 3. Initialize LMS Filter Parameters
w = zeros(filter_order, 1);  % Initial filter coefficients (column vector)
N = length(filtered_signal);  % Number of samples
y = zeros(N, 1);             % Filter output (column vector)
e = zeros(N, 1);             % Error signal (column vector)

% 4. LMS Adaptive Filtering Loop
for n = filter_order:N
    % Segment of filtered signal to be used as input (column vector)
    x = filtered_signal(n:-1:n-filter_order+1); % Extract segment
    
    % Calculate the filter output (scalar)
    y(n) = w' * x; % Transpose w to row vector for multiplication
    
    % Calculate the error (difference between filtered signal and filter output)
    e(n) = filtered_signal(n) - y(n);

    % Update filter coefficients using LMS rule
    w = w + mu * e(n) * x; %Update coefficients
end

% Amplify the noise-cancelled output
amplification_factor = 1.5; % Adjust this factor for more or less amplification
e = e * amplification_factor;

% Optionally, normalize the amplified signal to avoid clipping
e = e / max(abs(e)) * 0.9; % Scale to 90% of max amplitude

% Plot the noise-cancelled and amplified signal
figure;
plot((1:length(e)) / fs, e);
title('Amplified Noise-Cancelled Signal using LMS Adaptive Filter');
xlabel('Time (s)');
ylabel('Amplitude');

% Optional: Play the original filtered and noise-cancelled signals for comparison
disp('Playing original high-passed signal...');
sound(filtered_signal, fs);
pause(duration + 1); % Wait for playback to finish

disp('Playing noise-cancelled and amplified signal...');
sound(e, fs);

% 5. Performance Evaluation: Calculate Noise Reduction (NR) in dB
filtered_power = mean(filtered_signal.^2); % Power of the filtered signal
cancelled_noise_power = mean((filtered_signal - e).^2); % Power of the residual noise

NR_dB = 10 * log10(filtered_power / cancelled_noise_power); % Noise reduction in dB
disp(['Noise Reduction (NR): ', num2str(NR_dB), ' dB']);

