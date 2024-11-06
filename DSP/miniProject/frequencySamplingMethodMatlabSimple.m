n = 15;

f = [0 0.6 0.6 0.6 1];
mhi = [1 1 1 0 0];
bhi = fir2(n,f,mhi);
bhi;

[h1,w] = freqz(bhi,1);

plot(f,mhi,w/pi,abs(h1))
xlabel('\omega / \pi')
lgs = {'Ideal','fir2 default'};
legend(lgs)