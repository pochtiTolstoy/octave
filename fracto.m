function retval = fracto(p, ll, ur, xx, yy)
  ##fracto([-1, 0, 0, 1], [-1,1], [1, -1], 100, 100)
  disp(p);
  f_roots = roots(p)
  f = createFunction(p);
  eps = 1e-10;
  x_steps = (ur(1) - ll(1)) / (xx - 1)
  y_steps = (ll(2) - ur(2)) / (yy - 1)
  matrix = zeros(yy, xx);
  x = ll(1);
  y = ur(2);
  for i = 1:xx
    for j = 1:yy
      num_z = complex(x, y);
      y = y + y_steps;
      new_num = newton(f, num_z);
      for k = 1:length(f_roots)
        if (abs(f_roots(k) - new_num) < eps)
          matrix(i, j) = 100/k;
          break;
        else
          matrix(i, j) = 10;
        end
      endfor
    end
    x = x + x_steps;
    y = ur(2);
  end
  figure
  image(matrix);
  colorbar
end


function res = newton(f, x0)
  eps = 1e-10;
  max_iter=100;
  iter = 0;
  res = [];
  while (iter < max_iter)
    fx = f(x0);
    if (abs(fx) < eps)
      res = x0;
      return;
    end
    x1 = x0 - fx / dfunc(f, x0);
    if (abs(x1 - x0) < eps)
      res = x1;
      return;
    end
    x0 = x1;
    iter = iter + 1;
  end
  res = -1;
end

function df = dfunc(f, x)
  h = 1e-10;
  df = (f(x + h) - f(x)) / h;
end

function f = createFunction(coef)
  f = @(x) polyval(coef, x);
end
