function res = diagsn(rows, columns)
  if nargin == 1
    columns = rows;
  end
  res = zeros(rows, columns);
  up = false;
  num = 1;
  row = 1;
  col = 1;

  while row <= rows && col <= columns
    res(row, col) = num;
    num = num + 1;

    if up
      if row > 1 && col < columns
        row = row - 1;
        col = col + 1;
      else
        up = false;
        if col == columns
          row = row + 1;
        else
          col = col + 1;
        end
      end
    else
      if col > 1 && row < rows
        row = row + 1;
        col = col - 1;
      else
        up = true;
        if row == rows
          col = col + 1;
        else
          row = row + 1;
        end
      end
    end
  end
end


