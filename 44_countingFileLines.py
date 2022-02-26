# InterviewQuery
# easy
"""
Let’s say you’re given a huge 100 GB log file. 
You want to be able to count how many lines are in the file. 

Write code in Python to count the total number of lines in the file.
"""

def count_lines():
    num_lines = sum(1 for line in open('myfile.txt'))

# source:
    # https://www.oreilly.com/library/view/python-cookbook/0596001673/ch04s07.html
    # mmapcount is better approach https://stackoverflow.com/questions/845058/how-to-get-line-count-of-a-large-file-cheaply-in-python/68385697#68385697