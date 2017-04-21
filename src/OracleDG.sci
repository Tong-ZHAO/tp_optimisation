function [F, G, ind]=OracleDG(lambda, ind)

  Cl = - (Ad' * lambda + Ar' * pr) ./ r;
  ql = sign(Cl) .* sqrt(abs(Cl));

  F = 0;
  G = 0;

  if ind == 2 then
    F = - ql' * (r .* ql .* abs(ql)) / 3 - pr' * (Ar * ql) - lambda' * (Ad * ql - fd);
    return;
  elseif ind == 3 then
    G = - Ad * ql + fd;
    return;
  elseif ind == 4 then
    F = - ql' * (r .* ql .* abs(ql)) / 3 - pr' * (Ar * ql) - lambda' * (Ad * ql - fd);
    G = - Ad * ql + fd;
    return;
  else
    error("The ind takes an invalid value.", 10001);
  end

endfunction