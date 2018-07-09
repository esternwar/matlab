clear
ft=0.01;
ff=1;
T=3;
t=0:0.005:2*T;
sizet=size(t,2);
p = 2;
%закон изменени€ частоты
w0=100;
wk=300;
b=(wk-w0)/(2*T);
w=w0+2*pi*b*t;
%параметры поиска
tau0=3;
W0=100;
%шум
noiseG=10*normrnd(0,0.1,size(t));
%лчм+шум
f=exp(-pi*(((t-tau0)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau0)).*(t-tau0)).*exp(i*W0*t);
%оси цикла
taux=ft:ft:2*T;
sizetx=size(taux,2);
Wx=ff:ff:200;
sizewx=size(Wx,2);

DeltaTau = zeros(101,1);
DeltaW = zeros(200,1);
temp = 1;
W=100;
for tau=250:1:350
    g=exp(-pi*(((t-tau*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau*ft)).*(t-tau*ft)).*exp(i*W0*ff*t);
    resfunc = (f-g);
    DeltaTau(temp,1) = trapz(resfunc.*conj(resfunc));
    temp = temp+1;
end

temp = 1;
tau = 300;
for W=0:1:200
    g=exp(-pi*(((t-tau*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau*ft)).*(t-tau*ft)).*exp(i*W*ff*t);
    resfunc = (f-g);
    DeltaW(temp,1) = trapz(resfunc.*conj(resfunc));
    temp = temp+1;
end


temp = 1;
sec = 1;
for tau=290:0.1:310
    for W=90:0.1:110
        g=exp(-pi*(((t-tau*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau*ft)).*(t-tau*ft)).*exp(i*W*ff*t);
        resfunc = (f-g);
        DeltaTauW(temp,sec) = trapz(resfunc.*conj(resfunc));
        sec = sec+1;
    end
    sec = 1;
    temp = temp+1;
end

tau = 250:1:350;
W = 0:1:200;
figure(1)
plot(tau,DeltaTau)
xlabel ('tau, с')
ylabel ('delta')
%
figure(2)
plot(W,DeltaW)
xlabel ('w, Hz')
ylabel ('delta')
%
tau2=290:0.1:310;
w2= 90:0.1:110;
figure(3);
mesh(tau2, w2, DeltaTauW)
colorbar
xlabel ('w, Hz')
ylabel ('tau, c')

