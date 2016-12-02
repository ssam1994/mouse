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
dot_size = 0.2
vid_duration = 5
motion_range = plot_width/6
update_pause = 0.05
num_dots = 80

#Plot initial image
#note this is not completely necessary for movie
left_lines = []
right_lines = []
line_break = [0.5*plot_width - math.fabs(i - 0.5*num_lines) - 0.5*num_lines for i in range(num_lines)]
for i in range(num_lines):
    left_lines.append(Line2D([0, line_break[i]], [2*i+1, 2*i+1]))
    right_lines.append(Line2D([line_break[i], plot_width], [2*i+0.5, 2*i+0.5]))

#Generate random dots
dots_x = plot_width*np.random.rand(num_dots//2)
dots_y = plot_height*np.random.rand(num_dots//2)
plt.scatter(dots_x, dots_y, s=dot_size)

left_dots = []
right_dots = []
#for x, y in dots_x, dots_y:


fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlim(0, plot_width)
ax.set_ylim(-1, plot_height+1)

for i in range(num_lines):
    ax.add_line(left_lines[i])
    ax.add_line(right_lines[i])

ax.add_line(Line2D(line_break, [i for i in range(len(line_break))]))

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
    new_widths = [math.sin(x)*motion_range + line_break[i] for i in range(num_lines)]
    x_data = []
    y_data = []
    for i in range(num_lines):
        new_width = new_widths[i]
        update_left_line = Line2D([0, new_width], [2*i+1, 2*i+1])
        update_right_line = Line2D([new_width, plot_width], [2*i+0.5, 2*i+0.5])
        ax.add_line(update_left_line)
        ax.add_line(update_right_line)
        x_data.append(new_width)
        y_data.append(2*i+1)

    ax.add_line(Line2D(x_data, y_data))
    # if left_motion:
    #     for item in
    #     plt.scatter(left_dots_x, left_dots_y, markersize=dot_size)
    #     plt.scatter(right_dots_x, right_dots_y, markersize=dot_size)
    # else:
    #     plt.scatter(left_dots_x, left_dots_y, markersize=dot_size)
    #     plt.scatter(right_dots_x, right_dots_y, markersize=dot_size)
    plt.draw()
    plt.pause(update_pause)
    x+=1
