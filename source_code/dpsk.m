a=[0 0 0 1 1 0 1 0 1 1];
K=length(a)
a3=a;
a2=a;
for j=[2:1:K]
if a(j)==a(j-1)
a2(j)=0;
else
a2(j)=1;
end
end
a
a=a2;
a
initial_phase=pi;
f1=1;
N=200;
i=[0:1:N-1];
sin2=sin(2*pi*f1*i/N);
sin1=sin(2*pi*f1*i/N+pi);
for j=[1:1:K]
for i=[1:1:N]
yout(N*(j-1)+i)=a(j)*sin1(i)+(1-a(j))*sin2(i);
end
end
sin22=sin2;

sin11=sin1;
for j=[1:1:K-1]
sin22=[sin22 sin2];
sin11=[sin11 sin1];
end
a=a3;
for j=[1:1:K]
for i=[1:1:N]
a1(N*(j-1)+i)=a(j);
end
end
figure(1);
plot(a1,'--r');
hold on;
plot(yout);
grid on;