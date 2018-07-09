clear
ft=0.01;
ff=1;
T=3;
t=0:ft:2*T;
sizet=size(t,2);
%закон изменени€ частоты
w0=150;
wk=200;
b=(wk-w0)/(2*T);
w=w0+2*pi*b*t;
%параметры поиска
tau0=3;
W0=100;
%шум
noiseG=100000*normrnd(0,0.1,size(t));
%лчм+шум
f=exp(-pi*(((t-tau0)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau0)).*(t-tau0)).*exp(i*W0*t);
%оси цикла
taux=ft:ft:2*T;
sizetx=size(taux,2);
Wx=ff:ff:200;
sizewx=size(Wx,2);
%коррел€ци€
A=zeros((sizetx),(sizewx));
for tau=1:sizetx;
    for W=1:sizewx;
  g=exp(-pi*(((t-tau*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau*ft)).*(t-tau*ft)).*exp(i*W*ff*t);
   k=corrcoef (f,g);
  k2=real((k(2)));
 A(tau,W)=(k2)^2;
    end
end
%поиск максимума и его номера
Amax=0;
for i=1:600
    for j=1:200
   if (i~=j )&( A(i,j)>Amax)
        Amax=A(i,j);
      Imax=i;
      Jmax=j;
    end
    end
end

figure(1);
mesh(A)
colorbar
xlabel ('w, Hz')
ylabel ('tau, 10 ^ -2 c')
figure(2);
plot(Wx, A(Imax,:))
xlabel ('w, Hz')
figure(3);
plot(taux,A(:,Jmax))
xlabel ('tau, 10 ^ -2 c')
figure(4);
imagesc(A)