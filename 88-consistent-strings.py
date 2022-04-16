"""
1684. Count the Number of Consistent Strings
Easy

You are given a string allowed consisting of distinct characters and an array of strings words. A string is consistent if all characters in the string appear in the string allowed.

Return the number of consistent strings in the array words.

 

Example 1:

Input: allowed = "ab", words = ["ad","bd","aaab","baa","badab"]
Output: 2
Explanation: Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
Example 2:

Input: allowed = "abc", words = ["a","b","c","ab","ac","bc","abc"]
Output: 7
Explanation: All strings are consistent.
Example 3:

Input: allowed = "cad", words = ["cc","acd","b","ba","bac","bad","ac","d"]
Output: 4
Explanation: Strings "cc", "acd", "ac", and "d" are consistent.

"""

class Solution:
    def countConsistentStrings(self, allowed, words):
        a = set(allowed)
        count = 0
        for i in words:
            w = set(i)
            if w.issubset(a):
                count += 1
        return count
    def countConsistentStrings2(self, allowed, words):
        count = 0
        for i in words:
            if all([char in allowed for char in i]):
                count += 1
        return count
        
if __name__ == '__main__':
    a1 = "ab"
    w1 = ["ad","bd","aaab","baa","badab"]

    a2 = "abc"
    w2 = ["a","b","c","ab","ac","bc","abc"]
    print(Solution().countConsistentStrings(a2, w2))
    print(Solution().countConsistentStrings2(a2, w2))