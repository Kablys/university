#27.py
from pyqtgraph.Qt import QtGui, QtCore

import numpy as np
import pyqtgraph as pg
import math

# Duomenu ivedimas
N0 = input('Kiek buvo gyventoju pradiniu laiko momentu:')
t = input('Kiek metu praejo:')
Nt = input('Kiek buvo gyventoju praejus t laiko:')
tt = input('Po kiek metu noretumet suzinoti:')
app = QtGui.QApplication([])

# Grafiko langas
win = pg.GraphicsWindow(title="Basic plotting examples")
win.resize(1000,600)
win.setWindowTitle('27 Uzduoties grafikas')

# Skaiciavimas
x = np.linspace(0,tt,tt)
#print N0, ' ', t, ' ', Nt, ' ', tt
r1 = float(Nt) / N0
print "Augimo greitis: %d" % (r1)
r2 = math.log(r1)
r3 = r2/t
data = N0*(math.e**(r3*x))
print '\n'
print "Po %d metu populiacija bus %d" % (tt, N0*(math.e**(r3*tt)))

# Galutinio grafiko spausdinimas
p2 = win.addPlot(title="Populiacijos pokytis")
p2.setLabel('left', "Populiacija")
p2.setLabel('bottom', "Metai po pirmo matavimo")
#p2.setLabel('left', "Populiacija", units="zmoniu")
#p2.setLabel('bottom', "Metai po pirmo matavimo", units="metai")
p2.plot(data, pen = (255,255,255,200))

if __name__ == '__main__':
    import sys
    if (sys.flags.interactive != 1) or not hasattr(QtCore, 'PYQT_VERSION'):
        QtGui.QApplication.instance().exec_()

