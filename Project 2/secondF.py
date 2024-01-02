import numpy as np
import matplotlib.pyplot as plt

x1 = np.linspace(-4, 4, 100)
x2 = np.linspace(-4, 4, 100)
X1, X2 = np.meshgrid(x1, x2)
Y = (1.5 - X1 + X1 * X2) ** 2 + (2.25 - X1 + X1 * X2 ** 2) ** 2 + (2.625 - X1 + X1 * X2 ** 3) ** 2

plt.contour(X1, X2, Y, levels=np.logspace(-1, 3, 20))
plt.grid()
plt.show()
