function res = fence(r,c)
# формирует по заданому количеству строк и столбцов логическую матрицу с чередующимися нулевыми и единичными столбцами.
  if nargin == 1
    c = r
  end
  res = false(r, c);
  for i = 1:r
    for j = 1:c
      if mod(j, 2) != 0
        res(i, j) = true;
      endif
    endfor
  endfor
end
