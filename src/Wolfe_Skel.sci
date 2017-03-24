function [alphan,ok]=Wolfe(alpha,x,D,Oracle)


//////////////////////////////////////////////////////////////
//                                                          //
//   RECHERCHE LINEAIRE SUIVANT LES CONDITIONS DE WOLFE     //
//                                                          //
//                                                          //
//  Arguments en entree                                     //
//  -------------------                                     //
//    alpha  : valeur initiale du pas                       //
//    x      : valeur initiale des variables                //
//    D      : direction de descente                        //
//    Oracle : nom de la fonction Oracle                    //
//                                                          //
//  Arguments en sortie                                     //
//  -------------------                                     //
//    alphan : valeur du pas apres recherche lineaire       //
//    ok     : indicateur de reussite de la recherche       //
//             = 1 : conditions de Wolfe verifiees          //
//             = 2 : indistinguabilite des iteres           //
//                                                          //
//                                                          //
//    omega1 : coefficient pour la 1-ere condition de Wolfe //
//    omega2 : coefficient pour la 2-eme condition de Wolfe //
//                                                          //
//////////////////////////////////////////////////////////////


// -------------------------------------
// Coefficients de la recherche lineaire
// -------------------------------------

   omega1 = 0.1;
   omega2 = 0.9;

   alphamin = 0.0;
   alphamax = %inf;

   ok = 0;
   dltx = 0.00000001;

// ---------------------------------
// Algorithme de Fletcher-Lemarechal
// ---------------------------------

   // Appel de l'oracle au point initial

   ind = 4;
   [F,G] = Oracle(x,ind);

   // Initialisation de l'algorithme

   alphan = alpha;
   xn     = x;

   // Boucle de calcul du pas
   //
   // xn represente le point pour la valeur courante du pas,
   // xp represente le point pour la valeur precedente du pas.

   while ok == 0

      xp = xn;
      xn = x + (alphan*D);

      // Calcul des conditions de Wolfe

      // Première condition :
      [fn, gn] = Oracle(xn, ind);

      [fp, gp] = Oracle(xp, ind);

      ok1 = 0;
      ok2 = 0;
      if fn <= fp + omega1*alpha*gp'*D then
        ok1 = 1;
      end
      // Seconde condition :
      if gn'*D >= omega2*gp'*D then
        ok2 = 1;
      end
      ok = ok1*ok2;

      // Test de la valeur de alphan :
      // - si les deux conditions de Wolfe sont verifiees,
      //   faire ok = 1 : on sort alors de la boucle while
      // - sinon, modifier la valeur de alphan : on reboucle.

      if ok1 != 1 then
        alphamax = alphan;
        alphan = (alphamin + alphamax)/2;
      end

      if ok2 != 1 then
        if alphamax == %inf then
            alphamin = alphan;
            alphan = 2*alphamin;
        else
            alphan = (alphamin + alphamax)/2;
        end
      end

      // Test d'indistinguabilite

      if norm(xn-xp) < dltx then
        ok = 2;
      end

   end

endfunction
