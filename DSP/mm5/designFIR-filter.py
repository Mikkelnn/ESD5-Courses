import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import freqz, firwin

# Specifications
Fs = 8000  # Sampling frequency in Hz
fc = 1000  # 3dB cutoff frequency in Hz
f1 = 750   # Frequency where gain should be -1dB
f2 = 1500  # Frequency where gain should be -10dB
gain_1dB = -1  # Desired gain at 750 Hz in dB
gain_10dB = -10  # Desired gain at 1500 Hz in dB
window_type = 'rectangular'  # Window type, can be changed later to other windows

# Normalized cutoff frequency (between 0 and 1, where 1 corresponds to Fs/2)
wc = 2 * fc / Fs

# Function to design the FIR filter using the rectangular window method
def design_fir_filter(cutoff, num_taps, window='rectangular'):
    if window == 'rectangular':
        window_function = np.ones(num_taps)  # Rectangular window
    else:
        raise ValueError("Unsupported window type.")
    
    # Design the FIR filter using the window method
    fir_coeffs = firwin(num_taps, cutoff, window=window_function, pass_zero=True)
    return fir_coeffs

# Estimate filter order (number of taps)
def estimate_filter_order(fc, Fs):
    delta_f = abs(f2 - f1) / Fs  # Transition width
    num_taps = int(np.ceil(1 / delta_f))  # Simple estimate for number of taps
    if num_taps % 2 == 0:  # Ensure an odd number of taps for Type I FIR
        num_taps += 1
    return num_taps

# Filter design
num_taps = estimate_filter_order(fc, Fs)  # Get the estimated number of taps
fir_coeffs = design_fir_filter(wc, num_taps, window_type)

# Frequency response of the FIR filter
w, h = freqz(fir_coeffs, worN=8000, fs=Fs)

# Convert frequency response to dB scale
h_dB = 20 * np.log10(abs(h))

# Plot frequency response
plt.figure()
plt.plot(w, h_dB, label='FIR Filter Frequency Response')
plt.axvline(fc, color='red', linestyle='--', label='3dB Cutoff Frequency (1 kHz)')
plt.axhline(gain_1dB, color='green', linestyle='--', label='-1dB Target at 750 Hz')
plt.axhline(gain_10dB, color='purple', linestyle='--', label='-10dB Target at 1500 Hz')
plt.title('FIR Filter Frequency Response')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Gain (dB)')
plt.legend()
plt.grid(True)
plt.show()

# Print filter order and key specs
print(f"Estimated filter order: {num_taps}")
print(f"Cutoff frequency (3dB): {fc} Hz")
print(f"Gain at 750 Hz (desired -1dB): {h_dB[int(f1 / Fs * len(w))]:.2f} dB")
print(f"Gain at 1500 Hz (desired -10dB): {h_dB[int(f2 / Fs * len(w))]:.2f} dB")
