///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  MONITEUR D'ENCHAINEMENT POUR LE CALCUL DE L'EQUILIBRE D'UN RESEAU D'EAU  //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

// --------------------------------------
// Dimensionnement de l'espace de travail
// --------------------------------------

   stacksize(10000000);

// ------------------------------------------
// Fonctions fournies dans le cadre du projet
// ------------------------------------------

   // Donnees du problemes

   exec('Probleme_R.sce');
   exec('Structures_R.sce');

   // Affichage des resultats

   exec('Visualg.sci');

   // Verification  des resultats

   exec('HydrauliqueP.sci');
   exec('HydrauliqueD.sci');
   exec('Verification.sci');

// ------------------------------------------
// Fonctions a ecrire dans le cadre du projet
// ------------------------------------------

   // ---> Charger les fonctions  associees a l'oracle du probleme,
   //      aux algorithmes d'optimisation et de recherche lineaire.
   //
   // Exemple : la fonction "optim" de Scilab
   //
   exec('OraclePH.sci');
   exec('OraclePG.sci');
   exec('Optim_Scilab.sci');
   exec('Gradient_F.sci');
   exec('Wolfe_Skel.sci');
   exec('Gradient_W.sci');
   exec('Gradient_Conj.sci');

   exec('quasiNewton.sci');
   exec('Newton.sci');

   exec('OracleDG.sci');
   exec('OracleDH.sci');
   titrgr = "Fonction gradient à pas variable de Scilab sur le probleme primal";


// ------------------------------
// Initialisation de l'algorithme
// ------------------------------

   // La dimension (n-md) est celle du probleme primal

   xini = 0.1 * rand(n-md,1);

// ----------------------------
// Minimisation proprement dite
// ----------------------------

   // Exemple : la fonction "optim" de Scilab
   //[fopt,xopt,gopt] = Optim_Scilab( OraclePG, xini );

   // Gradient à pas fixe
   //[fopt,xopt,gopt] = Gradient_F( OraclePG, xini );

   // Wolfe
   // [fopt,xopt,gopt] = Gradient_W( OraclePG, xini );

   // Gradient conjugué Polak - Ribière
   //[fopt,xopt,gopt] = Gradient_Conj( OraclePG, xini );

   // Quasi Newton BFGS
   //[fopt,xopt,gopt] = quasiNewton( OraclePG, xini );

   // Newton avec pas de Wolfe. Attention il faut utiliser OraclePH

   // [fopt,xopt,gopt] = Newton( OraclePH, xini );

// --------------------------
// Verification des resultats
// --------------------------

   lambda_ini = 0.1 * rand(md, 1);
   
   // Exemple : la fonction "optim" de Scilab
   // [fopt,xopt,gopt] = Optim_Scilab(OracleDG, lambda_ini);

   // Gradient à pas fixe 
   // [fopt,xopt,gopt] = Gradient_F(OracleDG, lambda_ini);

   // Wolfe
   // [fopt,xopt,gopt] = Gradient_W(OracleDG, lambda_ini);

   // Gradient conjugué Polak - Ribière
   // [fopt,xopt,gopt] = Gradient_Conj(OracleDG, lambda_ini);

   // Quasi Newton BFGS
   // [fopt,xopt,gopt] = quasiNewton( OracleDG, lambda_ini);

   // Newton avec pas de Wolfe. Attention il faut utiliser OraclePH
   [fopt,xopt,gopt] = Newton( OracleDH, lambda_ini);

   [q,z,f,p] = HydrauliqueD(xopt);

   Verification(q,z,f,p);

//
