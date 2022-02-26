# InterviewQuery
# medium
"""
Write a function compute_deviation that takes in a list of dictionaries with a key and list of integers
and returns a dictionary with the standard deviation of each list.

Note: This should be done without using the NumPy built-in functions.
"""

def compute_deviation(list_numbers):
    result = {}
    
    for list in list_numbers:
        value = list['values']
        # find mean
        mean = sum(value) / len(value)
        #std
        num = 0
        for i in value:
            num += (i-mean) ** 2
            
        std = (num / len(value)) ** 0.5
        result[list['key']] = round(std,2)
    return result


if __name__ == "__main__":
    list_numbers = [
    {
        'key': 'list1',
        'values': [4,5,2,3,4,5,2,3],
    },
    {
        'key': 'list2',
        'values': [1,1,34,12,40,3,9,7],
    }
    ]
    
    print(compute_deviation(list_numbers))