import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

# Open the file in read mode
# Insert your own file location!
with open(r'C:\Users\Valdemar\Desktop\DSPData\Signal_with_noise.txt', 'r') as file:
    # Create an empty list to store the lines
    lines = []

    # Iterate over the lines of the file
    for line in file:
        # Remove the newline character at the end of the line
        line = line.strip()
        line = line.lstrip(" ")

        # Append the line to the list
        lines.append(float(line))

with open(r'C:\Users\Valdemar\Desktop\DSPData\Signal_without_noise.txt', 'r') as file:
    # Create an empty list to store the lines
    noiseFreeLine = []

    # Iterate over the lines of the file
    for line in file:
        # Remove the newline character at the end of the line
        line = line.strip()
        line = line.lstrip(" ")

        # Append the line to the list
        noiseFreeLine.append(float(line))

filteredLines = []
a = 0.88
b = 0.125
filteredLineOld = 0.0
i = 0
filteredLineNew = 0.0
for i in range(0, len(lines)):
    filteredLineNew = (a * filteredLineOld + b * lines[i])
    filteredLineOld = filteredLineNew
    filteredLines.append(filteredLineNew)

# Generate time values based on the indices of the array
x_values = range(len(filteredLines))

# Create the plot
plt.plot(x_values, filteredLines, linestyle='-', color='b', label='Filtered Line')
plt.plot(x_values, lines, linestyle='-', color='r', label='Non Filtered Line')
plt.plot(x_values, noiseFreeLine, linestyle='-', color='g', label='Noise free Line')

# Labeling the axes
plt.xlabel('Index')
plt.ylabel('Value')

# Adding a title
plt.title('Array Values Over Time')

# Show a legend
plt.legend()

# Display the plot
plt.show()
