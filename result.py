import matplotlib.pyplot as plt

iter_count = [1, 5, 10, 20]
rmse_random = [1.0722417, 1.0681478, 1.0681228, 1.0681226]
# rmse_sequence = [1.1362, 1.1362, 1.1362]
error_rate = []

plt.plot(iter_count, rmse_random)
plt.grid(True)
plt.ylabel('RMSE')  # y label
plt.xlabel('Iteration')  # x label
plt.show()
