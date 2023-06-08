function res = checkerboard(r,c)
# формирует по заданному количеству строк и столбцов логическую матрицу - аналог шахматной доски
  if nargin == 1
    c = r;
  endif
  res = false(r,c);
  for i = 1:r
    for j = 1:c
      if mod(i+j, 2) == 0
        res(i, j) = true;
      end
    end
  end
end
