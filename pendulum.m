L = 1;
init = [pi/4, 0];
odefun = @(t, x) [x(2); -9.81/L*sin(x(1))];
[t, Y] = ode45(odefun, [0 10], init);
##disp(t);
##disp(Y);
theta = Y(:,1);
figure;
for i = 1:length(t)
  x = L*sin(theta(i));
  y = -L*cos(theta(i));
  plot([0, x], [0, y]);
  axis([-L-1, L+1, -L-1, L+1]);
  drawnow;
end


