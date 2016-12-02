#Boundary Flow Constraint movie
import numpy as np
import sys
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import time
import math

sns.set_style("whitegrid", {'axes.grid':False})

plt.clf()
plt.close()

foreground_speed = 2
background_speed = 1
plot_width = 20
plot_height = 10
num_lines = int(plot_height/2)
dot_size = 5
vid_duration = 5
motion_range = plot_width/6
update_pause = 0.05
num_dots = 100

#Generate random dots
left_dots_x = plot_width*0.5*np.random.rand(num_dots//2)
left_dots_y = plot_height*np.random.rand(num_dots//2)
right_dots_x = plot_width*0.5*np.random.rand(num_dots//2) + plot_width*0.5
right_dots_y = plot_height*np.random.rand(num_dots//2)
plt.scatter(left_dots_x, left_dots_y, s=dot_size)
plt.scatter(right_dots_x, right_dots_y, s=dot_size)


left_dots = []
right_dots = []
#for x, y in dots_x, dots_y:


fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlim(0, plot_width)
ax.set_ylim(0, plot_height)

#Main updating plot
plt.ion()
x = 0
left_motion = True
t_stop = time.time() + vid_duration
t_half = time.time() + 0.5*vid_duration
while time.time() < t_stop:
    if time.time() > t_half:
        left_motion = False
    plt.cla()
    coherent_shift = math.sin(x)*motion_range
    noncoherent_shift = 0
    new_width = math.sin(x)*motion_range + 0.5*plot_width
    x_data = []
    y_data = []
    for i in range(num_lines):
        update_left_line = Line2D([0, new_width], [2*i+1, 2*i+1])
        update_right_line = Line2D([new_width, plot_width], [2*i+0.5, 2*i+0.5])
        ax.add_line(update_left_line)
        ax.add_line(update_right_line)

    ax.add_line(Line2D([new_width, new_width], [0, plot_height]))
    if left_motion:
        ax.scatter(left_dots_x+coherent_shift, left_dots_y, dot_size)
        ax.scatter(right_dots_x+noncoherent_shift, right_dots_y, dot_size)
    else:
        ax.scatter(left_dots_x+noncoherent_shift, left_dots_y, dot_size)
        ax.scatter(right_dots_x+coherent_shift, right_dots_y, dot_size)
    plt.draw()
    plt.pause(update_pause)
    x+=1
