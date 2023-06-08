function retval = numerical(f, a, b, userChoice)
  if nargin == 0
    disp("Enter arguments: function, a, b, userChoice");
    return;
  endif
  if strcmp(userChoice, "newton")
    res = newton(f, a, b);
    graph(f, a, b, res);
  elseif strcmp(userChoice, "binsearch")
    res = binsearch(f, a, b);
    graph(f, a, b, res);
  elseif strcmp(userChoice, "fzero")
    res = fzero_method(f, a, b);
    graph(f, a, b, res);
  else
    tic;
    res = newton(f, a, b);
    graph(f, a, b, res);
    elapsedTime = toc;
    disp(["Newton method time (with complex roots): ", num2str(elapsedTime)]);

    tic;
    res = binsearch(f, a, b);
    elapsedTime = toc;
    disp(["Binsearch method time: ", num2str(elapsedTime)]);

    tic;
    res = fzero_method(f, a, b);
    elapsedTime = toc;
    disp(["Fzero method time: ", num2str(elapsedTime)]);
  end
end

function df = dfunc(f, x)
  h = 1e-12;
  df = (f(x + h) - f(x)) / h;
end

function res = newton(f, a, b)
  eps = 1e-6;
  max_iter = 40;
  res = [];

  for x_real = a:0.1:b
    for x_image = a:0.1:b
      x0 = complex(x_real, x_image);
      x = x0 - f(x0) / dfunc(f, x0);
      count = 0;
      while (eps < abs(x - x0) && count < max_iter)
        x0 = x;
        x = x0 - f(x0) / dfunc(f, x0);
        count = count + 1;
      end
      if (count < max_iter && real(x) >= -2 && real(x) <= 2)
          res = [res, x0];
      end
    end
  end

  res = unique(res);
end

function res = binsearch(f, a, b)
  res = [];
  eps = 1e-6;
  while (abs(a-b) > eps)
    c = (a + b) / 2;
    fa = f(a);
    fc = f(c);
    if (abs(fc) < eps)
      res = [res, c];
      a = c;
    elseif fa * fc < 0
      b = c;
    else
      a = c;
    end
  endwhile
  if (abs(f(a)) < eps)
    res = [res, a];
  endif
end

function res = fzero_method(f, a, b)
  res = [];
  for i = a:0.1:b
    res = [res, fzero(f, i)];
  endfor
end

function graph(f, a, b, res)
  x = linspace(a, b, 1000);
  hold on
  plot(x, f(x));
  axis([-5, 5, -5, 5])
  xlabel('x real');
  ylabel('y imag');
  for i = 1:numel(res)
    plot(real(res(i)), imag(res(i)), 'ro');
  end
  hold off
end




