import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt


def f2(x):
    return (1.5 - x[0] + x[0] * x[1])**2 + (2.25 - x[0] + x[0] * x[1]**2)**2 + (2.625 - x[0] + x[0] * x[1]**3)**2


def find_extrema_points(func, start, end):
    # Use scipy's optimization function to find the minimum of the function
    result = opt.minimize(func, np.array([0, 0]), bounds=[start, end])
    min_x, min_y = result.x[0], result.x[1]

    # Plot the function to show the minimum
    x = np.linspace(start[0], end[0], 100)
    y = np.linspace(start[1], end[1], 100)
    X, Y = np.meshgrid(x, y)
    Z = func([X, Y])

    plt.contourf(X, Y, Z, 50, cmap='RdGy')
    plt.colorbar()
    plt.scatter(min_x, min_y, c='red')
    plt.show()

    return min_x, min_y


def find_inflection_points(func, start, end, step):
    x = np.arange(start[0], end[0], step)
    y = np.arange(start[1], end[1], step)
    X, Y = np.meshgrid(x, y)
    Z = func([X, Y])

    # Find the second partial derivatives of the function
    dx, dy = np.gradient(Z, step, step)
    d2x, d2y = np.gradient(dx, step, step)

    inflection_points = []
    # Find the critical points where the second partial derivatives are equal to 0
    for i in range(Z.shape[0]):
        for j in range(Z.shape[1]):
            if d2x[i][j] == 0 and d2y[i][j] == 0:
                inflection_points.append([X[i][j], Y[i][j]])

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_surface(X, Y, Z, cmap='RdGy')
    for inflection_point in inflection_points:
        ax.scatter(inflection_point[0], inflection_point[1], func(
            [inflection_point[0], inflection_point[1]]), c='blue', s=100)
    plt.show()

    return inflection_points


start = np.array([-4, -4])
end = np.array([4, 4])
step = 0.1

# min_x, min_y = find_extrema_points(f2, start, end)
inflection_points = find_inflection_points(f2, start, end, step)
