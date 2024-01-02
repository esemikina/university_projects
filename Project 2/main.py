import json
import numpy as np
import matplotlib.pyplot as plt


def find_inflection_points(func, start, end, step):
    x = np.arange(start, end, step)
    y = func(x)
    first_derivative = np.diff(y) / np.diff(x)
    second_derivative = np.diff(first_derivative) / np.diff(x[:-1])

    inflection_points = []
    for i in range(len(second_derivative) - 1):
        if second_derivative[i] * second_derivative[i + 1] < 0:
            if i + 1 < len(second_derivative):
                inflection_x = (x[i] + x[i + 1]) / 2
                inflection_y = func(inflection_x)
                inflection_points.append((inflection_x, inflection_y))
    return inflection_points


def plot_function(func):
    start = -30
    end = 30
    step = 0.1
    x = np.arange(start, end, step)
    y = func(x)

    inflection_points = find_inflection_points(func, start, end, step)
    inflection_x, inflection_y = zip(*inflection_points)

    local_minima = []
    local_maxima = []
    for i in range(1, len(y) - 1):
        if y[i] < y[i - 1] and y[i] < y[i + 1]:
            local_minima.append((x[i], y[i]))
        elif y[i] > y[i - 1] and y[i] > y[i + 1]:
            local_maxima.append((x[i], y[i]))

    global_min = min(
        local_minima, key=lambda x: x[1]) if local_minima else None
    global_max = max(
        local_maxima, key=lambda x: x[1]) if local_maxima else None

    plt.xlim(-2, 2)
    plt.ylim(-10, 50)
    plt.plot(x, y)
    plt.scatter(inflection_x, inflection_y,
                color="red", label="Inflection Points")
    plt.scatter(*zip(*local_minima), color="green", label="Local Minima")
    plt.scatter(*zip(*local_maxima), color="blue", label="Local Maxima")
    if global_min:
        plt.scatter(*global_min, color="purple", label="Global Min")
    if global_max:
        plt.scatter(*global_max, color="orange", label="Global Max")
    plt.legend()
    plt.show()


def h(x):
    return (x**4 - x**3 - x**2)*5


def g(x):
    return 12*x**2 - 18*x


plot_function(h)
