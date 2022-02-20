# InterviewQuery
"""
Given a string, write a function recurring_char to find its first recurring character. Return None if there is no recurring character.

Treat upper and lower case letters as distinct characters.

You may assume the input string includes no spaces.
"""

def recurring_char(input):
    temp = []
    for i in list(input):
        if i not in temp:
            temp.append(i)
        else: 
            return i
    return None

if __name__ == "__main__":
    input = "interv"
    
    print(recurring_char(input))