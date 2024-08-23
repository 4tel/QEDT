import tkinter as tk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, NavigationToolbar2Tk)

class window:
  def __init__(self, master):
    self.master = master
  def new_plt(self):
    self.fig=plt.figure()
    self.ax =self.fig.add_subplot()
    self.canvas=FugureCanvasTkAgg(fig,master=self.master)
  def toolbar(self):
    self.toolbar = NavigationToolbar2Tk(self.canvas, self.root, pack_toolbar=False)
    self.toolbar.update()
    self.toolbar.pack(side=tk.BOTTOM, fill=tk.x)

