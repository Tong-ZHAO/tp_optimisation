function [F, G, H, ind]=OracleDH(lambda, ind)

  Cl = - (Ad' * lambda + Ar' * pr) ./ r;
  ql = sign(Cl) .* sqrt(abs(Cl));
  dc = - (1 ./ sqrt(abs(Cl))) .* (1 ./ r); 

  F = 0;
  G = 0;
  H = 1;

  if ind == 2 | ind == 3 | ind == 4 then
    [F G] = OracleDG(lambda, ind);
    return;

  elseif ind == 5 then
    H = - Ad * diag(dc) * Ad';
    return;

  elseif ind == 6 then
    G = - Ad * ql + fd;
    H = - Ad * diag(dc) * Ad';
    return;

  elseif ind == 7 then
    [F G] = OracleDG(lambda, 4);
    H = - Ad * diag(dc) * Ad';
    return;

  else
    error("The ind takes an invalid value.", 10001);
  end

endfunction
