import numpy as np
cimport numpy as np
from libcpp.string cimport string
from libcpp cimport bool

from few.utils.utility import pointer_adjust

assert sizeof(int) == sizeof(np.int32_t)

cdef extern from "../include/Inspiral.hh":
    cdef cppclass InspiralCarrierWrap "InspiralCarrier":
        InspiralCarrierWrap(string func, bool enforce_schwarz_sep_, int num_add_args_, bool convert_Y_, string few_dir)
        void dealloc()

        void InspiralWrapper(np.float64_t *t, np.float64_t *p,
                         np.float64_t *e, np.float64_t *Y,
                         np.float64_t *Phi_phi,
                         np.float64_t *Phi_theta, np.float64_t *Phi_r,
                         np.float64_t M,
                          np.float64_t mu, np.float64_t a, np.float64_t p0,
                          np.float64_t e0,  np.float64_t Y0,
                          np.float64_t Phi_phi0, np.float64_t Phi_theta0,
                          np.float64_t Phi_r0,
                          int* length,
                          double tmax,
                          double dt,
                          np.float64_t err,
                          int  DENSE_STEPPING,
                          bool use_rk4,
                          int init_len,
                          double* additional_args) except+

cdef extern from "../include/ode.hh":
    void prepare_derivatives()

cdef extern from "../include/ode.hh":
    cdef cppclass GetDeriv "ODECarrier":
        GetDeriv(string func, string few_dir)
        void get_derivatives(np.float64_t *pdot,np.float64_t *edot, np.float64_t *Ydot,
                         np.float64_t *Omega_phi, np.float64_t *Omega_theta, np.float64_t *Omega_r,
                         np.float64_t epsilon, np.float64_t a, np.float64_t p,
                          np.float64_t e,  np.float64_t Y,
                          double* additional_args) except+

cdef class pyDerivative:
    cdef GetDeriv *g

    def __cinit__(self, func_name, few_dir):
        self.g = new GetDeriv(func_name.encode(), few_dir)

    def __dealloc__(self):
        if self.g:
            del self.g

    def __call__(self, epsilon, a, p0, e0, Y0, np.ndarray[ndim=1, dtype=np.float64_t] additional_args, max_init_len=1):
        
        cdef np.ndarray[ndim=1, dtype=np.float64_t] pdot = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] edot = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Ydot = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Omega_phi = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Omega_theta = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Omega_r = np.zeros(max_init_len, dtype=np.float64)

        self.g.get_derivatives(&pdot[0], &edot[0], &Ydot[0], &Omega_phi[0], &Omega_theta[0], &Omega_r[0], epsilon, a, p0, e0, Y0, &additional_args[0])

        return (pdot, edot, Ydot, Omega_phi, Omega_theta, Omega_r)



cdef class pyInspiralGenerator:
    cdef InspiralCarrierWrap *g

    def __cinit__(self, func_name, enforce_schwarz_sep, num_add_args, convert_Y, few_dir):
        self.g = new InspiralCarrierWrap(func_name.encode(), enforce_schwarz_sep, num_add_args, convert_Y, few_dir)

    def __dealloc__(self):
        self.g.dealloc()
        if self.g:
            del self.g

    def __call__(self, M, mu, a, p0, e0, Y0, Phi_phi0, Phi_theta0, Phi_r0, np.ndarray[ndim=1, dtype=np.float64_t] additional_args, T=1.0, dt=-1, err=1e-10, max_init_len=1000, DENSE_STEPPING=0, use_rk4=False):
        cdef np.ndarray[ndim=1, dtype=np.float64_t] t = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] p = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] e = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Y = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Phi_phi = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Phi_theta = np.zeros(max_init_len, dtype=np.float64)
        cdef np.ndarray[ndim=1, dtype=np.float64_t] Phi_r = np.zeros(max_init_len, dtype=np.float64)

        cdef int length

        self.g.InspiralWrapper(&t[0], &p[0], &e[0], &Y[0], &Phi_phi[0], &Phi_theta[0], &Phi_r[0], M, mu, a, p0, e0, Y0, Phi_phi0, Phi_theta0, Phi_r0, &length, T, dt, err, DENSE_STEPPING, use_rk4, max_init_len, &additional_args[0])

        return (t[:length], p[:length], e[:length], Y[:length], Phi_phi[:length], Phi_theta[:length], Phi_r[:length])
