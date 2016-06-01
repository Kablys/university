goal = 1;
P0 = [2, 3, 7, 9, 10, 14];
Mut = [20, 10, 12, 23, 24, 19, 14, 22, 12, 4, 16, 20, 6, 2, 7, 3, 12, 11, 10, 22];
P0bin = [];
for i = P0
  P0bin = [P0bin; double(dec2bin(i,4)-'0')];
end
%bestfit = [];
sumfit = [];

for m = Mut
  P0bin(m) = 1 - P0bin(m);
  fit = [];
  for i = size(P0bin,2);
    test = mat2str(P0bin(i,:))
    fit = [fit, abs(goal - test)];
  end
  bestfit = [bestfit, min(fit)];
  sumfit = [sumfit, sum(fit)];
  if (bestfit == 0)
    break
  end
end
bestfit
sumfit