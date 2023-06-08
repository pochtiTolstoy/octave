function caterpooly(start_2v, speed_2v, left_2v, right_2v, num_iter)
  % двумерный вектор начального положения гусеницы
  % двумерный вектор начальной скорости гусеницы
  % координаты левого нижнего и правого верхнего углов прямоугольного листа
  % целое число итераций
  num_circles = 10;
  r = 2;
  X = start_2v(1) * ones(num_circles, 1);
  Y = start_2v(2) * ones(num_circles, 1);
  t = 0:pi/10:2*pi;
##  shift = abs(left_2v(1)) + 5;
  shift = 10;
  figure;
  hold on;
  axis([left_2v(1)-shift, right_2v(1)+shift, left_2v(2)-shift, right_2v(2)+shift]);
  rectangle('Position', [left_2v(1), left_2v(2), right_2v(1)-left_2v(1), right_2v(2)-left_2v(2)]);
  for i = 1:num_circles
    x = X(1) + r * cos(t);
    y = Y(1) + r * sin(t);
    if i == 1
      plot(x, y, 'r', 'linewidth', 0.1);
    elseif i == num_circles
      plot(x, y, 'k', 'linewidth', 0.5);
    else
      plot(x, y, 'g', 'linewidth', 0.1);
    end
  end
  for i = 1:num_iter
    xn = X(1) + speed_2v(1);
    yn = Y(1) + speed_2v(2);
    if (xn < (left_2v(1) + r) || xn > (right_2v(1) - r))
      speed_2v(1) = -speed_2v(1);
      xn = X(1) + speed_2v(1);
    end
    if (yn > (right_2v(2) - r) || yn < (left_2v(2) + r))
      speed_2v(2) = -speed_2v(2);
      yn = Y(1) + speed_2v(2);
    end
    X = circshift(X, 1);
    X(1) = xn;
    Y = circshift(Y, 1);
    Y(1) = yn;
    for j = 1:num_circles
      x = r * cos(t) + X(j);
      y = r * sin(t) + Y(j);
      if j == 1
        plot(x, y, 'r', 'linewidth', 0.1);
      elseif j == num_circles
        plot(x, y, 'k', 'linewidth', 0.5);
      else
        plot(x, y, 'g', 'linewidth', 0.1);
      end
    end
    pause(0.005);
  end
  hold off;
end
