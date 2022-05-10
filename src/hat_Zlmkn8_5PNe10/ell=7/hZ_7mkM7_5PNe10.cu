/*

PN Teukolsky amplitude hat_Zlmkn8: (ell = 7, n = -7)

- BHPC's maple script `outputC_Slm_Zlmkn.mw`.


25th May 2020; RF
17th June. 2020; Sis


Convention (the phase `B_inc`  is defined in `Zlmkn8.c`):
 Zlmkn8  = ( hat_Zlmkn8 * exp(-I * B_inc) )

 For ell = 7, we have only
 0 <= |k| <= 16 (jmax = 9)
 
 //Shorthad variables for PN amplitudes  in `inspiral_orb_data`
 k = sqrt(1. - q^2); y = sqrt(1. - Y^2) ;
 Ym = Y - 1.0 , Yp = Y + 1.0 ;

PNq[11] = 1, q, q ^2, ..., q ^ 9, q ^ 10
PNe[11] = 1, e, e ^ 2, ..., e ^ 9, e ^ 10
PNv[11] = v ^ 8, v ^ 9, ..., v ^ 17, v ^ 18
PNY[11] = 1, Y, Y ^ 2, ..., Y ^ 9, Y ^ 10
PNYp[11] = 1, Yp, Yp^2,...  Yp^10
PNy[21] = 1, y, y ^ 2, ..., y ^ 19, y ^ 20



 WARGNING !! 
`hZ_7mkP0_5PNe10` stores  only the PN amplitudes that has the index
m + k + n > 0 and m + k + n = 0 with n <= 0

 Other modes should be computed from the symmetry relation in `Zlmkn8.c`: 
 Z8[l, -m, -k, -n] = (-1)^(l + k) * conjugate(Z8_[l, m, k, n])
 
 */


// C headers 
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// GSL headers
//#include<gsl/cmplx.h>

// BHPC headers
#include "hat_Zlmkn8_5PNe10/ell=7/hZ_7mkM7_5PNe10.h"

/*-*-*-*-*-*-*-*-*-*-*-* Global variables (but used only within hZ_7mkP0_5PNe10.c) *-*-*-*-*-*-*-*-*-*-*-*/


/*-*-*-*-*-*-*-*-*-*-*-* Global functions (used only within hZ_7mkP0_5PNe10.c) *-*-*-*-*-*-*-*-*-*-*-*/


/*-*-*-*-*-*-*-*-*-*-*-* External functions (can be refered by other source files) *-*-*-*-*-*-*-*-*-*-*-*/
CUDA_CALLABLE_MEMBER
cmplx hZ_7mkM7(const int m, const int k, inspiral_orb_PNvar* PN_orb) { //

    cmplx hZ_7mkM7 = { 0.0 };

    double  Re_7mkM7 = 0.0;
    double  Im_7mkM7 = 0.0;

    // NULL check
    if (PN_orb == NULL) {

        //perror("Point errors: hZ_7mkM7");
        //exit(1);

    }

    /* Read out the PN variables from `inspiral_orb_PNvar`*/
    /* PNq, PNe, PNv, PNY, PNy */
    double Ym = PN_orb->PNYm;

    double q = PN_orb->PNq[1];
    double q2 = PN_orb->PNq[2];
    
    double v17 = PN_orb->PNv[9];
    double v18 = PN_orb->PNv[10];
    
    double e7 = PN_orb->PNe[7];
    double e9 = PN_orb->PNe[9];

    double Y = PN_orb->PNY[1];
   
    double Yp = PN_orb->PNYp[1];
    double Yp2 = PN_orb->PNYp[2];
    double Yp3 = PN_orb->PNYp[3];
    double Yp4 = PN_orb->PNYp[4];
    double Yp5 = PN_orb->PNYp[5];
    double Yp6 = PN_orb->PNYp[6];
    double Yp7 = PN_orb->PNYp[7];

    double y = PN_orb->PNy[1];
    double y3 = PN_orb->PNy[3];
    double y4 = PN_orb->PNy[4];
    double y5 = PN_orb->PNy[5];
    double y6 = PN_orb->PNy[6];
    double y7 = PN_orb->PNy[7];
    double y8 = PN_orb->PNy[8];
    double y9 = PN_orb->PNy[9];
    double y10 = PN_orb->PNy[10];
    double y11 = PN_orb->PNy[11];
    double y12 = PN_orb->PNy[12];
    double y13 = PN_orb->PNy[13];
    double y14 = PN_orb->PNy[14];
    double y15 = PN_orb->PNy[15];
    double y16 = PN_orb->PNy[16];


if (m == 7 && k == 2) { 

   // 1. Z_deg[7][7][2][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.5637210251435850376036e-8 * v17 * Yp7 * Yp * Ym * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 

} else if (m == 7 && k == 1) { 

   // 2. Z_deg[7][7][1][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.4805731373253300739261e-5 * (((-0.1333333333333333333333e1 + 0.1000000000000000000000e1 * Y) * e7 + (0.1232878134587511995800e2 - 0.9246586009406339968506e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742918e1 * v17 * q * e9) * Yp7 * y; 

} else if (m == 6 && k == 3) { 

   // 3. Z_deg[7][6][3][-7]: 17, 
   Re_7mkM7  = 0.2109250937808273697752e-7 * v17 * y3 * Yp6 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == 6 && k == 2) { 

   // 4. Z_deg[7][6][2][-7]: 17, 
   Re_7mkM7  = -0.1798140029158448995769e-4 * (((-0.1142857142857142857143e1 + 0.1000000000000000000000e1 * Y) * e7 + (0.1056752686789295996401e2 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) * Yp6 * Yp * Ym; 
   Im_7mkM7  = 0.0e0; 

} else if (m == 5 && k == 4) { 

   // 5. Z_deg[7][5][4][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.5377555845474134498168e-7 * v17 * Yp5 * y4 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 

} else if (m == 5 && k == 3) { 

   // 6. Z_deg[7][5][3][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.4584375548425615264899e-4 * Yp5 * (((-0.9523809523809523809524e0 + 0.9999999999999999999999e0 * Y) * e7 + (0.8806272389910799970003e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742918e1 * v17 * q * e9) * y3; 

} else if (m == 4 && k == 5) { 

   // 7. Z_deg[7][4][5][-7]: 17, 
   Re_7mkM7  = -0.1075511169094826899634e-6 * v17 * y5 * Yp4 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == 4 && k == 4) { 

   // 8. Z_deg[7][4][4][-7]: 17, 
   Re_7mkM7  = -0.9168751096851230529797e-4 * Yp4 * (((-0.7619047619047619047619e0 + 0.9999999999999999999999e0 * Y) * e7 + (0.7045017911928639976002e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460105e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) * y4; 
   Im_7mkM7  = 0.0e0; 

} else if (m == 3 && k == 6) { 

   // 9. Z_deg[7][3][6][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.178353350286201063165e-6 * v17 * y6 * Yp3 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 

} else if (m == 3 && k == 5) { 

   // 10. Z_deg[7][3][5][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.1520465359220752743676e-3 * Yp3 * (((-0.5714285714285714285715e0 + 0.1000000000000000000000e1 * Y) * e7 + (0.5283763433946479982003e1 - 0.9246586009406339968504e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) * y5; 

} else if (m == 2 && k == 7) { 

   // 11. Z_deg[7][2][7][-7]: 17, 
   Re_7mkM7  = 0.2522297268694248769158e-6 * v17 * y7 * Yp2 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == 2 && k == 6) { 

   // 12. Z_deg[7][2][6][-7]: 17, 
   Re_7mkM7  = 0.2150262732128468379355e-3 * Yp2 * y6 * (((-0.3809523809523809523810e0 + 0.1000000000000000000000e1 * Y) * e7 + (0.3522508955964319988002e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9); 
   Im_7mkM7  = 0.0e0; 

} else if (m == 1 && k == 8) { 

   // 13. Z_deg[7][1][8][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.3089170643958294036216e-6 * v17 * Yp * y8 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 

} else if (m == 1 && k == 7) { 

   // 14. Z_deg[7][1][7][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.2633523253318807899287e-3 * (((-0.1904761904761904761905e0 + 0.9999999999999999999999e0 * Y) * e7 + (0.1761254477982159994001e1 - 0.9246586009406339968502e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) * y7 * Yp; 

} else if (m == 0 && k == 9) { 

   // 15. Z_deg[7][0][9][-7]: 17, 
   Re_7mkM7  = -0.3302462331134789761445e-6 * y9 * v17 * (-0.7340137e7 * e9 + 0.793449e6 * e7) * q2; 
   Im_7mkM7  = -0.294862708137034800129e-8 * y9 * v18 * (0.4739134e7 * e7 - 0.53284145e8 * e9) * q2; 

} else if (m == 0 && k == 8) { 

   // 16. Z_deg[7][0][8][-7]: 17, 
   Re_7mkM7  = (-0.8646310540353502871087e-4 * v17 * y8 * e7 + 0.7995058422914363179685e-3 * v17 * y8 * e9) * q + (-0.2662707553412072198347e-3 * y8 * Y * q2 * e7 + 0.2447861246524407836057e-2 * q2 * y8 * e9 * Y) * v18; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -1 && k == 10) { 

   // 17. Z_deg[7][-1][10][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.3089170643958294036216e-6 * v17 * y10 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp * q2; 

} else if (m == -1 && k == 9) { 

   // 18. Z_deg[7][-1][9][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.2633523253318807899287e-3 * y9 * (((0.1904761904761904761905e0 + 0.9999999999999999999999e0 * Y) * e7 + (-0.1761254477982159994001e1 - 0.9246586009406339968502e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) / Yp; 

} else if (m == -2 && k == 11) { 

   // 19. Z_deg[7][-2][11][-7]: 17, 
   Re_7mkM7  = 0.2522297268694248769158e-6 * v17 * y11 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp2 * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -2 && k == 10) { 

   // 20. Z_deg[7][-2][10][-7]: 17, 
   Re_7mkM7  = 0.2150262732128468379355e-3 * (((0.3809523809523809523810e0 + 0.1000000000000000000000e1 * Y) * e7 + (-0.3522508955964319988002e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) * y10 / Yp2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -3 && k == 12) { 

   // 21. Z_deg[7][-3][12][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.178353350286201063165e-6 * v17 * y12 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp3 * q2; 

} else if (m == -3 && k == 11) { 

   // 22. Z_deg[7][-3][11][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.1520465359220752743676e-3 * y11 * (((0.5714285714285714285715e0 + 0.1000000000000000000000e1 * Y) * e7 + (-0.5283763433946479982003e1 - 0.9246586009406339968504e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) / Yp3; 

} else if (m == -4 && k == 13) { 

   // 23. Z_deg[7][-4][13][-7]: 17, 
   Re_7mkM7  = -0.1075511169094826899634e-6 * v17 * y13 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp4 * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -4 && k == 12) { 

   // 24. Z_deg[7][-4][12][-7]: 17, 
   Re_7mkM7  = -0.9168751096851230529797e-4 * y12 * (((0.7619047619047619047619e0 + 0.9999999999999999999999e0 * Y) * e7 + (-0.7045017911928639976002e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460105e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) / Yp4; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -5 && k == 14) { 

   // 25. Z_deg[7][-5][14][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.5377555845474134498168e-7 * v17 * y14 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp5 * q2; 

} else if (m == -5 && k == 13) { 

   // 26. Z_deg[7][-5][13][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = 0.4584375548425615264899e-4 * (((0.9523809523809523809524e0 + 0.9999999999999999999999e0 * Y) * e7 + (-0.8806272389910799970003e1 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742918e1 * v17 * q * e9) * y13 / Yp5; 

} else if (m == -6 && k == 15) { 

   // 27. Z_deg[7][-6][15][-7]: 17, 
   Re_7mkM7  = 0.2109250937808273697752e-7 * v17 * y15 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp6 * q2; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -6 && k == 14) { 

   // 28. Z_deg[7][-6][14][-7]: 17, 
   Re_7mkM7  = 0.1798140029158448995769e-4 * y14 * (((0.1142857142857142857143e1 + 0.1000000000000000000000e1 * Y) * e7 + (-0.1056752686789295996401e2 - 0.9246586009406339968503e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742919e1 * v17 * q * e9) / Yp6; 
   Im_7mkM7  = 0.0e0; 

} else if (m == -7 && k == 16) { 

   // 29. Z_deg[7][-7][16][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.5637210251435850376036e-8 * v17 * y16 * (-0.7340137e7 * e9 + 0.793449e6 * e7) / Yp7 * q2; 

} else if (m == -7 && k == 15) { 

   // 30. Z_deg[7][-7][15][-7]: 17, 
   Re_7mkM7  = 0.0e0; 
   Im_7mkM7  = -0.4805731373253300739261e-5 * y15 * (((0.1333333333333333333333e1 + 0.1000000000000000000000e1 * Y) * e7 + (-0.1232878134587511995800e2 - 0.9246586009406339968506e1 * Y) * e9) * q2 * v18 + 0.3071126452071873460106e0 * v17 * q * e7 - 0.2839804942683501742918e1 * v17 * q * e9) / Yp7; 

 } 
 else {

        //perror("Parameter errors: hZ_7mkM7");
        //exit(1);

    }

    hZ_7mkM7 = cmplx(Re_7mkM7, Im_7mkM7);
    return hZ_7mkM7;

}
