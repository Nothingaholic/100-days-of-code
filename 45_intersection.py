# Ace DS interview book
# easy
"""
Given 2 arrays, write a function to get the intersection of the two
"""

def intersection(a,b):
    # simplest way
    # output = []
    # for i in a:
    #     if i in b:
    #         output.append(i)
    # return output
    
    # better hash map
    # only unique number set a and b, 
    # unordered, unchangeable, and do not allow duplicate values.
    a = set(a)
    b = set(b)
    if len(a) < len(b):
        return [x for x in a if x in b]
    else:
        return [x for x in b if x in a]


if __name__ == "__main__":
    a = [1,2,3,4,5]
    b = [0,1,3,7]
    print(intersection(a,b))