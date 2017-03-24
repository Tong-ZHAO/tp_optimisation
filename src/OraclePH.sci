function [F, G, H, ind]=OraclePH(qc, ind)


  v_qc = q0 + B*qc;
  v_qc_abs = abs(v_qc);
  v_rqc = r .* v_qc .* v_qc_abs;

  F = 0;
  G = 0;
  H = 1;

  if ind == 2 | ind == 3 | ind == 4 then
    [F G] = OraclePG(qc, ind);
    return;

  elseif ind == 5 then
    H = 2 * B' * diag(r .* v_qc_abs) * B;
    return;

  elseif ind == 6 then
    G = B' * (v_rqc + Ar' * pr);
    H = 2 * B' * diag(r .* v_qc_abs) * B;
    return;

  elseif ind == 7 then
    [F G] = OraclePG(qc, 4);
    H = 2 * B' * diag(r .* v_qc_abs) * B;
    return;

  else
    error("The ind takes an invalid value.", 10001);
  end

endfunction
