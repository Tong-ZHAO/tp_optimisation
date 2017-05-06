function [fopt,xopt,gopt] = Gradient_Conj( Oracle, xini )



// ------------------------
// Parametres de la methode
// ------------------------

   titre = "Parametres du gradient conjugue non lineaire";
   labels = ["Nombre maximal d''iterations";...
             "Valeur du pas de gradient";...
             "Seuil de convergence sur ||G||"];
   typ = list("vec",1,"vec",1,"vec",1);
   default = ["5000";"1";"0.000001"];
   [ok,iter,alphai,tol] = getvalue(titre,labels,typ,default);

// ----------------------------
// Initialisation des variables
// ----------------------------

   logG = [];
   logP = [];
   Cout = [];

   timer();

// -------------------------
// Boucle sur les iterations
// -------------------------

   x = xini;
   G = 0;
   kstar = iter;
   for k = 1:iter

//    - valeur du critere et du gradient

      ind = 4;
      Gp = G;
      [F,G] = Oracle( x, ind );

//    - test de convergence

      if norm(G) <= tol then
         kstar = k;
         break
      end

//    - calcul de la direction de descente
      if k == 1 then
        D = - G;
      else
        Beta = G'*(G-Gp)/(norm(Gp, 2)^2);
        D = - G + Beta*D;
      end

//    - calcul de la longueur du pas de gradient

      [alpha, ok] = Wolfe(alphai, x, D, Oracle);

//    - mise a jour des variables

      x = x + (alpha*D);

//    - evolution du gradient, du pas et du critere

      logG = [ logG ; log10(norm(G)) ];
      logP = [ logP ; log10(alpha) ];
      Cout = [ Cout ; F ];

   end

// ---------------------------
// Resultats de l'optimisation
// ---------------------------

   fopt = F;
   xopt = x;
   gopt = G;

   tcpu = timer();

   cvge = ['Iteration         : ' string(kstar);...
           'Temps CPU         : ' string(tcpu);...
           'Critere optimal   : ' string(fopt);...
           'Norme du gradient : ' string(norm(gopt))];
   disp('Fin de la methode de gradient conjugue non lineaire')
   disp(cvge)

// - visualisation de la convergence

   Visualg(logG,logP,Cout);

endfunction
