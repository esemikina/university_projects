import numpy as np
import matplotlib.pyplot as plt
import json


def find_inflection_points(func, start, end, step, dim):
    if np.any(start >= end):
        raise ValueError("Start values must be less than end values")

    if dim == 1:
        x = np.arange(start[0], end[0], step)
        Z = func(x)
        dZ_dx = np.gradient(Z, x)
        d2Z_dx2 = np.gradient(dZ_dx, x)
        inflection_points = []
        for i in range(len(x) - 1):
            if d2Z_dx2[i] * d2Z_dx2[i + 1] < 0:
                inflection_points.append((x[i], x[i + 1]))
        return inflection_points
    elif dim == 2:
        if len(start) >= 1 and len(end) >= 1 and step != 0:
            x = np.arange(start[0], end[0], step)
        y = np.arange(start[1], end[1], step)
        X, Y = np.meshgrid(x, y)
        Z = func(X, Y)
        dZ_dx, dZ_dy = np.gradient(Z)
        d2Z_dx2, d2Z_dxdy = np.gradient(dZ_dx, dZ_dy)
        d2Z_dy2, d2Z_dydx = np.gradient(dZ_dy, dZ_dx)
        inflection_points = []
        for i in range(len(x) - 1):
            for j in range(len(y) - 1):
                if d2Z_dx2[i, j] * d2Z_dx2[i + 1, j] < 0 or j < len(y) - 1 and d2Z_dy2[i, j] * d2Z_dy2[i, j + 1] < 0:
                    inflection_points.append((x[i], y[j]))
        return inflection_points
    else:
        raise ValueError("Invalid number of dimensions")


def plot_function(func, start, end, step, dim=1, title=None):
    if dim == 1:
        x = np.arange(start, end, step)
        y = func(x)
        inflection_points = find_inflection_points(func, start, end, step, dim)
        inflection_x, inflection_y = zip(*inflection_points)
        min_x = x[np.argmin(y)]
        min_y = min(y)
        max_x = x[np.argmax(y)]
        max_y = max(y)
        data = {
            "inflection_points": inflection_points,
            "local_minima": [(min_x, min_y)],
            "local_maxima": [(max_x, max_y)],
            "global_min": (min_x, min_y),
            "global_max": (max_x, max_y)
        }

        with open("func_data.json", "w") as f:
            json.dump(data, f)

        plt.plot(x, y)
        plt.scatter(inflection_x, inflection_y, color="red",
                    marker="o", label="inflection points")
        plt.scatter(min_x, min_y, color="green",
                    marker="o", label="local minima")
        plt.scatter(max_x, max_y, color="blue",
                    marker="o", label="local maxima")
        plt.legend()
        if title:
            plt.title(title)
        plt.show()
    elif dim == 2:
        inflection_points = find_inflection_points(func, start, end, step, dim)
        inflection_x, inflection_y, inflection_z = zip(*inflection_points)
        min_x, min_y, min_z = min(inflection_points, key=lambda x: x[2])
        max_x, max_y, max_z = max(inflection_points, key=lambda x: x[2])
        data = {
            "inflection_points": inflection_points,
            "local_minima": [(min_x, min_y, min_z)],
            "local_maxima": [(max_x, max_y, max_z)],
            "global_min": (min_x, min_y, min_z),
            "global_max": (max_x, max_y, max_z)
        }
        with open("func_data.json", "w") as f:
            json.dump(data, f)
        fig = plt.figure()
        ax = plt.axes(projection='3d')
        ax.scatter(inflection_x, inflection_y, inflection_z,
                   color="red", marker="o", label="inflection points")
        ax.scatter(min_x, min_y, min_z, color="green",
                   marker="o", label="local minima")
        ax.scatter(max_x, max_y, max_z, color="blue",
                   marker="o", label="local maxima")
        plt.legend()
        if title:
            plt.title(title)
        plt.show()
    else:
        raise ValueError("Invalid dimension.")


def f2(x1, x2):
    return (1.5 - x1 + x1 * x2) ** 2 + (2.25 - x1 + x1 * x2 ** 2) ** 2 + (2.625 - x1 + x1 * x2 ** 3) ** 2


plot_function(f2, np.array([-10, -10]), np.array([10, 10]),
              np.array([0.1, 0.1]), dim=2, title="f2")
