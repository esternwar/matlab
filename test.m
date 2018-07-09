x = 0:0.01:1;
y = x;
plot(x,y)

f = getframe;
[im,map] = rgb2ind(f.cdata,256);
im(1,1,1,10) = 0;
for k = 1:10
  y = x.^k;
  plot(x,y)
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map);
end