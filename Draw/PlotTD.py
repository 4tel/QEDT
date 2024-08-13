import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import os

Ry2eV=13.605703976
cur = os.getcwd()

plt.rcParams['xtick.bottom'] = False    # 아랫 눈금 없음.
plt.rcParams['ytick.right'] = True      # 오른쪽 눈금 있음.
plt.rcParams['ytick.direction'] = 'in'  # 좌우 눈금은 그래프 안으로
plt.rcParams['font.family'] = 'serif'
#plt.rcParams['font.serif'] = ['Times New Roman']
plt.rcParams['font.size'] = 20          # 폰트 크기
plt.rcParams['lines.linewidth'] = 2     # 라인 굵기

r=1.5
#fig,ax=plt.subplots(figsize=(5.5*r,3.5*r))
fig,ax=plt.subplots(figsize=(6*r,4.5*r))

def selection():
  files=[x for x in os.listdir(cur)if x.endswith('txt')]
  for i,v in enumerate(files):
    print(f"{i+1}) {v}")
  print()
  R=input("Select : ")
  
  if R.isdigit():
    if int(R) < 1 or int(R) > len(files):raise ValueError
    File = files[int(R)-1]
  else:
    if R not in files:raise ValueError(f"{R} is not in files")
    File = R
  
  values=np.loadtxt(File)
  
  with open(File) as f:
    print(f.readline())
  
  for x in range(1,len(values[0])):
    if max(values[:,x])>1e1:break
    plt.plot(values[:,0],values[:,x],label=f"column {x}")
  plt.legend()
  plt.show()

def Etot_init():
  ax.set_xlabel('time(fs)')
  ax.set_ylabel(r'$\Delta$E(eV)')
  
  Etot_lines = []
  Etot_lines.extend(ax.plot([],[], label='$E_{tot}+E_{kin}$'))
  Etot_lines.extend(ax.plot([],[], label='$E_{tot}$'))
  Etot_lines.extend(ax.plot([],[], label='$E_{kin}$'))


  ax.legend()
  plt.tight_layout()
  return Etot_lines

def Etot_update(frame, Etot_lines):
  ground_energy1 = -1.27164063 # fhi
  ground_energy2 = -2.33313689 # ONCV
  ground_energy3 = -1.52992011 # excited ONCV
  ground_energy4 = -2.23453035 # 0.4A ONCV
  ground_energy5 = -2.13313684 # velocity ONCV
  ground_energy = ground_energy4
  ground=0
  try:
    values=np.loadtxt('Etot.txt')
    if ground:values[:,1:3] -= ground_energy
    else:values[:,1:3] -= values[0,1]
    values[:,1:4] *= Ry2eV

    Etot_lines[0].set_data(values[:,0], values[:,1])
    Etot_lines[1].set_data(values[:,0], values[:,2])
    Etot_lines[2].set_data(values[:,0], values[:,3])
    
    xlim = [np.min(values[:,0]), np.max(values[:,0])]
    Xdif = (xlim[1] - xlim[0]) * 0.03
    ylim = [np.min(values[:,1:3]), np.max(values[:,1:4])]
    Ydif = (ylim[1] - ylim[0]) * 0.03

    if Xdif!=0:ax.set_xlim(xlim[0]-Xdif, xlim[1]+Xdif)
    if Ydif!=0:ax.set_ylim(ylim[0]-Ydif, ylim[1]+Ydif)

    #xmin,xmax=0,6
    #ymin,ymax=-3,2
    #ax.set_xlim(xmin, xmax)
    #ax.set_ylim(ymin,ymax)

    if not ground:return
    Eg = (ground_energy2-ground_energy)*Ry2eV
    ax.axhline(Eg,0,1,color='gray',linestyle=':')
    ax.text((xmax-xmin)/2,Eg-(ymax-ymin)*0.01,'$E_{g}$='+f'{Eg:.2f}eV',va='top',ha='center')
    fig.tight_layout()
  except Exception as e:
    print(f'QEDT Error Reading File: {e}')
  return Etot_lines

def Etot():
  Etot_lines=Etot_init()
  anim = animation.FuncAnimation(fig, Etot_update, fargs=(Etot_lines,),\
		init_func=lambda:Etot_lines, cache_frame_data=False, interval=100)
  plt.show()

def eigen_init():
  ax.set_xlabel('time(fs)')
  ax.set_ylabel('Energy Level(eV)')
  
  with open('eigen.txt', 'r') as f:
    f.readline()
    line = len(f.readline().split()) - 1
  eigen_lines = []

  #for x in range(line):
  #  eigen_lines.extend(ax.plot([],[], label=f'eigenValue{x}'))
  eigen_lines.extend(ax.plot([],[],label=r'${\sigma}$'))
  eigen_lines.extend(ax.plot([],[],label=r'${\sigma}^{*}$'))
  ax.legend()
  plt.tight_layout()
  return eigen_lines

def eigen_update(frame, eigen_lines):
  try:
    values=np.loadtxt('eigen.txt')
    #for x in range(len(eigen_lines)):
    #  eigen_lines[x].set_data(values[:,0], values[:, x+1])

    eigen_lines[0].set_data(values[:,0], values[:, 1])
    eigen_lines[1].set_data(values[:,0], values[:, 4])
    
    #eigen_lines[0].set_data(values[:,0], values[:, 3])
    #eigen_lines[1].set_data(values[:,0], values[:, 2])

    xlim = [np.min(values[:,0]), np.max(values[:,0])]
    Xdif = (xlim[1] - xlim[0]) * 0.03
    ylim = [np.min(values[:,1:]), np.max(values[:,1:])]
    Ydif = (ylim[1] - ylim[0]) * 0.03

    ax.set_xlim(xlim[0]-Xdif, xlim[1]+Xdif)
    ax.set_ylim(ylim[0]-Ydif, ylim[1]+Ydif)

    ax.set_xlim(0,5)
    ax.set_ylim(-18,1)
    ax.set_yticks([0,-4,-8,-12,-16])
  except Exception as e:
    print(f'QEDT Error Reading File: {e}')
  return eigen_lines

def eigen():
  eigen_lines=eigen_init()
  anim = animation.FuncAnimation(fig, eigen_update, fargs=(eigen_lines,),\
		init_func=lambda:eigen_lines, cache_frame_data=False, interval=100)
  plt.show()
"""
def eigen():
  values=np.loadtxt('eigen.txt')
  #for x in range(2,4):
  for x in range(1,5):
    plt.plot(values[:,0], values[:,x],label=f'eigenvalue{x}')
  plt.xlim(0,5)
  plt.xlabel('time(fs)')
  plt.ylabel('Energy Level(eV)')
  plt.legend()
  plt.tight_layout()
  plt.show()
"""
Sol={1:selection,
     2:Etot,
     3:eigen}
for k,v in Sol.items():
  print(f'{k}) {v.__name__}')

Sol[int(input('\nChoice : '))]()
