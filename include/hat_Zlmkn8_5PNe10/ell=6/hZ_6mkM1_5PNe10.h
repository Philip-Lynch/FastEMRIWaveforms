#ifndef hZ_6mkM1_5PNe10_H_ 
#define hZ_6mkM1_5PNe10_H_ 

/*
  Header of the PN Teukolsky amplitude Zlmkn8 (ell = 6, n = -1)

  25th May 2020; RF
  17th June. 2020; Sis

*/

//! \file hZ_6mkM1_5PNe10.h

#include "global.h"

// BHPC headers
#include "Zlmkn8_5PNe10.h"


// Define type


// Declare prototype 
CUDA_CALLABLE_MEMBER
cmplx hZ_6mkM1(const int m, const int k, inspiral_orb_PNvar* PN_orb);

#endif // hZ_6mkM1_5PNe10_H_ 