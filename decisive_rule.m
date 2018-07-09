function res = decisive_rule(f,g,sz,p)
a = 0;
b = sz;
x = a:0.01:b;
y = abs(f-g).^p
F = 0;
n = 100;
m = 2;
while m <= n
    F = F + (x(m)-x(m-1))*0.5*(y(m)+ y(m-1));
    m = m +1;
end

res = F/sz;

end

