clc
close all
clear all
n  = 1000;

x  = linspace(0e-10,5e-10,n);
xv = linspace(0e-10,7e-10,n)
V  = zeros(n,1);
De = 4.799; %eV
m  = 1.574e-27; %kg
b  = 1e10;
x0 = 1.01e-10; %m
h = (6.582e-16)^2; 
ep = 0.0414;
%dx = 1.419e-29;
dx = 3e-31; 

H = zeros(n,n);
alpha = (h/2*m);
term13 = -alpha*(1 / dx^2);
term2 = alpha*(2 / dx^2);

V = De*(1-exp(-b*(xv-x0))).^2;
% plot(xv,V)
for j = 1:n
    %Ensure the first entry does not result in an error
    if j-1>0
        H(j,j-1) = term13;
    end
    
    %Ensure the last entry does not result in an error
    if j+1< n+1
        H(j,j+1) = term13;
    end
    
    %The second term cannot result in an error
     H(j,j) = term2 + V(j);
    
end
[U,E] = eig(H);
for m = 1:n
    U(:,m) = U(:,m) / norm(U(:,m));
end
   
%Take the complex conjugate in order to plot probability density
P = U.*conj(U);
E(1,1)
plot(xv,P(:,1),'b')
xlim([0e-10,2.7e-10])
% % plot(x,v)
% % hold on
% % plot(x,y*10e7)
% % 
% % xlim([0e-10,9e-10])