import matplotlib.pyplot as plt
from math import *
import numpy as np


# Define the carrier function
def cosFunc(ax, t):
    return ax * np.cos(2 * np.pi * t)

# array of symbol values to modulate
symbols_to_transmit = [-2, 1, 2, -1, 2, -2, 1]
symbol_count = len(symbols_to_transmit)

fs = 1000
carrier_amplitude = 1

# Create a time array with finer sampling
total_modulated_signal_array = np.linspace(0, symbol_count, symbol_count*fs)  # Time from 0 to 10, sampled 1000 points
single_symbol_array = np.linspace(0, 1, fs)

# Generate the carrier signal, here the amplitude of the carrier is 1
carrier = cosFunc(carrier_amplitude, total_modulated_signal_array)

# calculate all symbols individually 
symbols = [cosFunc(symbol, single_symbol_array) for symbol in symbols_to_transmit]


# Plot the signal
plt.figure(1)
plt.plot(total_modulated_signal_array, carrier*np.array(symbols).flatten())
plt.title("Modulated Signal")
plt.xlabel("Time (t)")
plt.ylabel("Amplitude")
plt.grid()
# plt.show()

plt.figure(2)
for idx, symbol in enumerate(symbols):
  sym = np.zeros(symbol_count*fs)
  sym[idx*fs:(idx+1)*fs] = symbol
  plt.plot(total_modulated_signal_array, carrier*sym, label=f"Symbol: {symbols_to_transmit[idx]}")

plt.title("Modulated Signal")
plt.xlabel("Time (t)")
plt.ylabel("Amplitude")
plt.legend()
plt.grid()
plt.show()


