function [F, G, ind]=OraclePG(qc, ind)

  v_qc = q0 + B * qc;
  v_qc_abs = abs(v_qc);
  v_rqc = r .* v_qc .* v_qc_abs;

  F = 0;
  G = 0;

  if ind == 2 then
    F = 1/3 * v_qc' * vr_qc + pr' * (Ar * v_qc);
    return;
  elseif ind == 3 then
    G = B' * (v_rqc + Ar' * pr);
    return;
  elseif ind == 4 then
    F = 1/3 * v_qc' * v_rqc + pr' * (Ar * v_qc);
    G = B' * (v_rqc + Ar' * pr);
    return;
  else
    error("The ind takes an invalid value.", 10001);
  end

endfunction

