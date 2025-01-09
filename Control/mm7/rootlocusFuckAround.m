s = tf('s');
sys1 = (s+10)/((s+3-4*i)*(s+3+4*i)*(s+6));
rlocus(sys1)