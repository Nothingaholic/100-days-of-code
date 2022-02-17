# Interview query 

"""
Say you are given a text document in the form of a string with the following sentences:

Example:

Input:

document = "I have a nice car with a nice tires"
Output:

{
"I":0.11,
"have":0.11,
"a":0.22,
"nice":0.22,
"car": 0.11,
"with":0.11,
"tires":0.11
}
Write a program in python to determine the TF (term_frequency) values for each term of this document.

Note: Round the term frequency to 2 decimal points.
"""


from pydoc import doc


def term_frequency(sentences):
    pass


if __name__ == "__main__":
    document = "I have a nice car with a nice tires"
    print(term_frequency(document))