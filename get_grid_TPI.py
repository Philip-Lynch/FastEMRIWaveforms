import matplotlib.pyplot as plt
import numpy as np
import TPI
from few.trajectory.inspiral import EMRIInspiral
from few.utils.utility import get_overlap, get_mismatch, get_separatrix, get_fundamental_frequencies, get_fundamental_frequencies_spin_corrections
from scipy.interpolate import RegularGridInterpolator

def save_txt(my_array, fname):
    # Open the file in write mode
    with open(fname, "w") as file:
        # Write each element of the array to a new line in the file
        for element in my_array:
            file.write("{:.16f}".format(element) + "\n")

def read_txt(fname):
    # Open the file in read mode
    with open(fname, "r") as file:
        # Read the contents of the file into a list
        lines = file.readlines()

    # Initialize an empty two-dimensional list
    data = []

    # Loop through each line in the file
    for line in lines:
        # Split the line into a list of values using a comma delimiter
        values = line.strip().split(" ")

        # Convert each value to a float and append to the two-dimensional list
        # data.append([np.float128(value) for value in values])
        data.append([np.float64(value) for value in values])
    
    return np.asarray(data)



def pdotpn(a, p, e, pLSO):
    """
    https://arxiv.org/pdf/2201.07044.pdf
    eq 91
    """
    risco = get_separatrix(a+1e-500, np.zeros_like(a), np.ones_like(a))
    U2 = (p - risco)**2 - (pLSO - risco)**2
    pdot_V = 8./5. * p**(-3) * (1-e**2)**1.5 * (8 + 7 * e**2) * (p**2 / U2)
    return pdot_V

def edotpn(a, p, e, pLSO):
    """
    https://arxiv.org/pdf/2201.07044.pdf
    eq 91
    without the factor of e
    """
    risco = get_separatrix(a+1e-500, np.zeros_like(a), np.ones_like(a))
    U2 = (p - risco)**2 - (pLSO - risco)**2
    return 1/15 * p**(-4) * (1-e**2)**1.5 * (304 + 121 * e**2) * (p**2 / U2) #* (e + 1e-500)

trajpn5 = EMRIInspiral(func="pn5")
trajS = EMRIInspiral(func="SchwarzEccFlux")

import glob
a_tot, u_tot, w_tot = [], [], []
pdot = []
edot = []
plso = []

alpha = 4.0
deltap = 0.05
beta = alpha - deltap

for aa in np.arange(0,10):
    el = f'few/files/a0.{aa}0_xI1.000.flux'
    imp = read_txt(el)
    a, p, e, xi, E, Lz, Q, pLSO, EdotInf_tot, EdotH_tot, LzdotInf_tot, LzdotH_tot, QdotInf_tot, QdotH_tot, pdotInf_tot, pdotH_tot, eccdotInf_tot, eccdotH_tot, xidotInf_tot, xidotH_tot = imp.T
    
    u = np.log((p-pLSO + beta)/alpha)
    w = np.sqrt(e)
    a_tot.append(a )
    u_tot.append(u )
    w_tot.append(w )
    pdot.append( (pdotInf_tot+pdotH_tot ) / pdotpn(a, p, e, pLSO) )
    edot.append( (eccdotInf_tot+eccdotH_tot) / edotpn(a, p, e, pLSO) )
    plso.append(pLSO )

flat_a = np.round(np.asarray(a_tot).flatten(),decimals=5)
flat_u = np.round(np.asarray(u_tot).flatten(),decimals=5)
flat_w = np.round(np.asarray(w_tot).flatten(),decimals=5)
flat_pdot = np.asarray(pdot).flatten()
flat_edot = np.asarray(edot).flatten()

def get_pdot(aa,uu,ww):
    mask = (aa==flat_a)*(uu==flat_u)*(ww==flat_w)
    return flat_pdot[mask][0]

def get_edot(aa,uu,ww):
    mask = (aa==flat_a)*(uu==flat_u)*(ww==flat_w)
    return flat_edot[mask][0]



a_unique = np.unique(flat_a)
u_unique = np.unique(flat_u)
w_unique = np.unique(flat_w)

x1 = a_unique.copy()
x2 = u_unique.copy()
x3 = w_unique.copy()
X = [x1, x2, x3]

for get,lab in zip([get_pdot,get_edot], ['pdot', 'edot']):
    reshapedF = np.asarray([[[get(el1,el2,el3) for el3 in x3] for el2 in x2] for el1 in x1])

    # flux interpolation
    InterpFlux = TPI.TP_Interpolant_ND(X, F=reshapedF)

    coeff = InterpFlux.GetSplineCoefficientsND().flatten()

    # np.savetxt(f'few/files/coeff_' + lab +'.dat', coeff)
    save_txt(coeff, f'few/files/coeff_' + lab +'.dat')

for i,el in enumerate(X):
    # print(el.shape)
    # np.savetxt(f'few/files/x{i}.dat', el)
    save_txt(el, f'few/files/x{i}.dat')

