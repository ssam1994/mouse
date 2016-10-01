'''
Create random dot stereogram.
'''

import numpy as np
import matplotlib.pyplot as plt

#Dimensions of the RDS
stereo_width = 100
stereo_height = 100

#Dimensions of RDS to be shifted horizontally
shift_width = 20
shift_height = 20
horizontal_shift = 3

#Random binary array to represent colors of RDS
random_matrix = np.random.randint(0, 2, size=(stereo_height, stereo_width))

#Calculate coordinates of subset of RDS to be shifted
stereo_width_middle = stereo_width//2
shift_width_middle = shift_width//2
left_bound = stereo_width_middle - shift_width_middle
right_bound = left_bound + shift_width

stereo_height_middle = stereo_height//2
shift_height_middle = shift_height//2
top_bound = stereo_height_middle - shift_height_middle
bottom_bound = top_bound + shift_width

shift_array = random_matrix[top_bound:bottom_bound, left_bound:right_bound]

#Shift array
shifted_random_matrix = random_matrix.copy()
shifted_random_matrix[top_bound:bottom_bound, left_bound - horizontal_shift:right_bound - horizontal_shift] = shift_array

#Plot stereograms
fig, (ax1, ax2) = plt.subplots(1, 2)
ax1.matshow(random_matrix, cmap=plt.cm.gray)
ax2.matshow(shifted_random_matrix, cmap=plt.cm.gray)
ax1.axis('off')
ax2.axis('off')
plt.subplots_adjust(wspace=.1)
plt.show()
plt.close()
