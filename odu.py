from scipy.integrate import solve_ivp
import numpy as np
import matplotlib.pyplot as plt

alpha = 28
beta = 8/3
sigma = 10

x0 = 0
y0 = 1
z0 = 20

n = 10000

init = []
init.append(x0)
init.append(y0)
init.append(z0) 
t = [0, 50]
t_eval = np.linspace(t[0], t[1], n)
step = t_eval[1] - t_eval[0]


def ode_function(t, init):
    x, y, z = init
    x1 = sigma * (y - x)
    y1 = x * (alpha - z) - y
    z1 = x * y - beta*z
    return x1, y1, z1

def ivp_solution():    
    #ivp solution
    res = solve_ivp(ode_function, t, init, t_eval=t_eval)
    
    #visualization
    fig = plt.figure()
    ax = fig.add_subplot(projection="3d")
    ax.plot(res.y[0], res.y[1], res.y[2])
    plt.show()
    
ivp_solution()