import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["figure.dpi"]=150
plt.rcParams["figure.facecolor"]="white"
plt.rcParams["figure.figsize"]=(8, 6)
plt.figure(figsize=(6,5))
plt.title('none')
# load data
data = np.loadtxt('ReS2.bands.gnu')

k = np.unique(data[:, 0])
bands = np.reshape(data[:, 1], (-1, len(k)))
fermi = 9.3002

for band in range(len(bands)):
    plt.plot(k, bands[band, :]-fermi, linewidth=1, color='k')
plt.xlim(min(k), max(k))

# Fermi energy
plt.axhline(0, linestyle=(0, (5, 5)), linewidth=0.75, color='k', alpha=0.5)
# High symmetry k-points (check bands_pp.out)
#plt.axvline(0.8660, linewidth=0.75, color='k', alpha=0.5)
#plt.axvline(1.8660, linewidth=0.75, color='k', alpha=0.5)
#plt.axvline(2.2196, linewidth=0.75, color='k', alpha=0.5)
# text labels
#plt.xticks(ticks= [0, 0.8660, 1.8660, 2.2196, 3.2802], \
#           labels=['L', '$\Gamma$', 'X', 'U', '$\Gamma$'])
plt.ylabel("Energy (eV)")
plt.text(2.3, 5.6, 'Fermi energy')#, fontsize= small)
plt.ylim(-2,3)
plt.show()
