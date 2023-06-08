function retval = numerical(f, a, b, userChoice)
  eps = 1e-6;
  if nargin == 0
    disp("Enter arguments: function, a, b, userChoice");
    return;
  endif
  if strcmp(userChoice, "newton")
    res = newton(f, a, b);
    graph(f, a, b, res);
  elseif strcmp(userChoice, "binsearch")
    bin_res = binsearch(f, a, b);
    bin_res = uniquetol(bin_res, eps);
    if length(bin_res != 0)
      for i = 1:50
        bin_res = [bin_res, binsearch(f, bin_res(end), b)];
        bin_res = uniquetol(bin_res, eps);
      end
    endif
    disp(bin_res);
    graph(f, a, b, bin_res);
  elseif strcmp(userChoice, "fzero")
    res = fzero_method(f, a, b);
    graph(f, a, b, res);
  else
    tic;
    bin_res = binsearch(f, a, b);
    bin_res = uniquetol(bin_res, eps);
    if length(bin_res != 0)
      for i = 1:50
        bin_res = [bin_res, binsearch(f, bin_res(end), b)];
        bin_res = uniquetol(bin_res, eps);
      end
    endif
    elapsedTime = toc;
    disp(["Binsearch solutions: ", num2str(bin_res)]);
    disp(["Binsearch method time: ", num2str(elapsedTime)]);
    disp("");

    tic;
    fzero_res = fzero_method(f, a, b);
    fzero_res = uniquetol(fzero_res, eps);
    elapsedTime = toc;
    disp(["Fzero solutions: ", num2str(fzero_res)]);
    disp(["Fzero method time: ", num2str(elapsedTime)]);
    disp("");

    tic;
    [new_res, real_res] = newton(f, a, b);
    graph(f, a, b, new_res);
    elapsedTime = toc;
    real_res = uniquetol(real_res, eps);
    disp(["Newton solutions: ", num2str(real_res)]);
    disp(["Newton method time (complex roots): ", num2str(elapsedTime)]);
    disp("");

    disp(["Difference between fzero and newton: ", num2str(fzero_res - real_res)]);
    disp(["Difference between fzero and binsearch: ", num2str(fzero_res - bin_res)]);
    disp(["Difference between newton and binsearch: ", num2str(real_res - bin_res)]);
  end
end

function df = dfunc(f, x)
  h = 1e-12;
  df = (f(x + h) - f(x)) / h;
end

function [res, real_res] = newton(f, a, b)
  eps = 1e-6;
  max_iter = 40;
  res = [];
  real_res = [];
  for x_real = a:0.5:b
    for x_image = a:0.5:b
      x0 = complex(x_real, x_image);
      x = x0 - f(x0) / dfunc(f, x0);
      count = 0;
      while (eps < abs(x - x0) && count < max_iter)
        x0 = x;
        x = x0 - f(x0) / dfunc(f, x0);
        count = count + 1;
      end
      if (count < max_iter && real(x) >= a && real(x) <= b)
        res = [res, x0];
        if (imag(x0) == 0)
          real_res = [real_res, real(x0)];
        end
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

##>> numerical(@(x)-x.^2+1, -2, 2, "1")
##Binsearch solutions: -1           1
##Binsearch method time: 0.003063
##
##Fzero solutions: -1           1
##Fzero method time: 0.10412
##
##Newton solutions: -1           1
##Newton method time (with complex roots): 2.9611
##
##Difference between fzero and newton: 8.2637e-08 -6.6613e-16
##Difference between fzero and binsearch: -8.8818e-16  4.7684e-07
##Difference between newton and binsearch: -8.2637e-08  4.7684e-07

##>> numerical(@(x)x.^3-1, -2, 2, "1")
##Binsearch solutions: 1
##Binsearch method time: 0.056712
##
##Fzero solutions: 1
##Fzero method time: 0.14462
##
##Newton solutions: 1
##Newton method time (with complex roots): 3.2589
##
##Difference between fzero and newton: 0
##Difference between fzero and binsearch: 0
##Difference between newton and binsearch: 0

##>> numerical(@(x) x.^3+x.^2+1, -2, 2,"1")
##Binsearch solutions: -1.4656
##Binsearch method time: 0.051034
##
##Fzero solutions: -1.4656
##Fzero method time: 0.10398
##
##Newton solutions: -1.4656
##Newton method time (complex roots): 1.0749
##
##Difference between fzero and newton: 9.7284e-07
##Difference between fzero and binsearch: 1.7163e-07
##Difference between newton and binsearch: -8.0122e-07
