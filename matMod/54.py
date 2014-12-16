#54.py
from pyqtgraph.Qt import QtGui, QtCore

import numpy as np
import pyqtgraph as pg
import math

B0 = input('Indo skerspjuvio spindulys(metrais):')
h = input('Indo aukstis(metrais):')
t = input('Kiek laiko truks(valandom):')
#tt = input('Po kiek metu noretumet suzinoti:')
app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Basic plotting examples")
win.resize(1000,600)
win.setWindowTitle('pyqtgraph example: Plotting')

x = np.linspace(0,tt,tt)
#print N0, ' ', t, ' ', Nt, ' ', tt
B = math.pi * (B0**2)
c = (0.6 * sqrt(2) * sqrt(9.8)
A = (b*(h/(t*3600)))/(c * sqrt(h))

data = N0*(math.e**(r3*x))

p8 = win.addPlot(title="Populiacijos pokytis")
p8.plot(data, pen = (255,255,255,200))

if __name__ == '__main__':
    import sys
    if (sys.flags.interactive != 1) or not hasattr(QtCore, 'PYQT_VERSION'):
        QtGui.QApplication.instance().exec_()

