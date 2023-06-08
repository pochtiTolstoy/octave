function m = parametric_normal(f, p)
  h = 1e-10;
  x = linspace(-pi,pi,50);
  y = linspace(-pi,pi,50);
  [X,Y] = meshgrid(x,y);
  Z = f(X,Y);
  z0 = f(p(1), p(2))
  dzdx = (f(p(1)+h, p(2)) - f(p(1), p(2))) / h;
  dzdy = (f(p(1), p(2)+h) - f(p(1), p(2))) / h;
  t = linspace(0,1,100);
  xn = dzdx * t + p(1);
  yn = dzdy * t + p(2);
  zn = -t + z0;
  hold on
  axis equal;
  xlabel('x');
  ylabel('y');
  zlabel('z');
  plot3(xn, yn, zn);
  S = surf(X, Y, Z);
  hold off
end
