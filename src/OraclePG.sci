function [F, G, ind]=OraclePG(qc, ind)

  H = q0 + B*qc;
  H_abs = abs(H);
  M = r.*H.*H_abs;

  if ind == 2 then
    F = 1/3 * H' * M + pr' * (Ar * H);
    G = 0;
  elseif ind == 3 then
    F = 0;
    G = B' * (M + Ar' * pr);
  elseif ind == 4 then
    F = 1/3 * H' * M + pr' * (Ar * H);
    G = B' * (M + Ar' * pr);
  else
    error("The ind takes an invalid value.", 10001);
  end

endfunction

