
"""
1221. Split a String in Balanced Strings
Easy

Balanced strings are those that have an equal quantity of 'L' and 'R' characters.

Given a balanced string s, split it in the maximum amount of balanced strings.

Return the maximum amount of split balanced strings.

 

Example 1:

Input: s = "RLRRLLRLRL"
Output: 4
Explanation: s can be split into "RL", "RRLL", "RL", "RL", each substring contains same number of 'L' and 'R'.
Example 2:

Input: s = "RLLLLRRRLR"
Output: 3
Explanation: s can be split into "RL", "LLLRRR", "LR", each substring contains same number of 'L' and 'R'.
Example 3:

Input: s = "LLLLRRRR"
Output: 1
Explanation: s can be split into "LLLLRRRR".

"""


class Solution:
    def balancedStringSplit(self, s: str) -> int:
        count = 0 # track the balance of the string
        max_num = 0 # trach the balance of the substring
        for ch in s:
            # Iterate the string. 
            # For every R character, increase the count keeping the track of balance,
            # while for every L character, decrease the count.
            if ch == "R":
                count += 1
            else:
                count -= 1
            # At any point, if the count becomes 0 i.e the count of L and R becomes the same,                      #  we found the split point, we increase the max_num.
            if count == 0:
                max_num += 1

        return max_num