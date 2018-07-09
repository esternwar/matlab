clear
ft=0.01;
ff=1;
T=3;
t=0:0.001:2*T;
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
koef = 90;
%лчм+шум
%f=exp(-pi*(((t-tau0)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau0)).*(t-tau0)).*exp(i*W0*t);
%оси цикла
taux=ft:ft:2*T;
sizetx=size(taux,2);
Wx=ff:ff:200;
sizewx=size(Wx,2);
tau = 300;
W = 100;
f=exp(-pi*(((t-tau0)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau0)).*(t-tau0)).*exp(i*W0*t);
g=exp(-pi*(((t-tau*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau*ft)).*(t-tau*ft)).*exp(i*W*ff*t);
W1 = 80;
tau1 = 270;
g2=exp(-pi*(((t-tau1*ft)-0.5*T)/(0.5*T)).^2).*exp(i*(w0+b*(t-tau1*ft)).*(t-tau1*ft)).*exp(i*W1*ff*t);  
for i=1:1:10000
    no=koef*normrnd(0,0.1,size(t));
    resfunc = (f-(g+no));
    stat_noise(i) = trapz(resfunc.^2);
end


for i=1:1:10000
    no=koef*normrnd(0,0.1,size(t));
    resfunc = (f-(g2+no));
    stat_signal(i) = trapz(resfunc.*conj(resfunc));
end
[x,y] = hist(stat_noise,50);
liney = [0,700];
linex = [y(39), y(39)];

figure
hist(stat_noise, 50);
hold on;
hist(stat_signal, 50);
hold on;
plot(linex, liney,'m')
