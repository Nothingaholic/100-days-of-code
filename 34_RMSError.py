# InterviewQuery 
"""
Write a function calculate_rmse to calculate the root mean squared error of a regression model. 
The function should take in two lists, one that represents the predictions y_pred 
and another with the target values y_true.


"""
import numpy as np
def calculate_rmse(y_pred, y_true):
    diff = np.subtract(y_pred, y_true) **2
    rmse = np.sqrt(sum(diff) / len(y_true))

    return round(rmse,2)

if __name__ == "__main__":
    y_pred = [3,4,5]
    y_true = [5,4,3]
    print(calculate_rmse(y_pred, y_true))