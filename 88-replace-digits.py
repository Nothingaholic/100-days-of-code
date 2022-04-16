"""
1844. Replace All Digits with Characters
Easy

377

46

Add to List

Share
You are given a 0-indexed string s that has lowercase English letters in its even indices and digits in its odd indices.

There is a function shift(c, x), where c is a character and x is a digit, that returns the xth character after c.

For example, shift('a', 5) = 'f' and shift('x', 0) = 'x'.
For every odd index i, you want to replace the digit s[i] with shift(s[i-1], s[i]).

Return s after replacing all digits. It is guaranteed that shift(s[i-1], s[i]) will never exceed 'z'.

 

Example 1:

Input: s = "a1c1e1"
Output: "abcdef"
Explanation: The digits are replaced as follows:
- s[1] -> shift('a',1) = 'b'
- s[3] -> shift('c',1) = 'd'
- s[5] -> shift('e',1) = 'f'
Example 2:

Input: s = "a1b2c3d4e"
Output: "abbdcfdhe"
Explanation: The digits are replaced as follows:
- s[1] -> shift('a',1) = 'b'
- s[3] -> shift('b',2) = 'd'
- s[5] -> shift('c',3) = 'f'
- s[7] -> shift('d',4) = 'h'

"""

class Solution:
    def replaceDigits(self, s: str) -> str:
        letters = 'abcdefghijklmnopqrstuvwxyz'
        shift = lambda char, idx: letters[letters.find(char) + int(idx)]
        s = list(s)
        for i in range(1, len(s),2):
            s[i] = shift(s[i-1], s[i])
        return ''.join(s)
    def replaceDigits2(self, s: str) -> str:
        """
        ord() convert character to value
        chr() convert value to character
        """
        s = list(s)
        for i in range(1, len(s),2):
            s[i] = chr(ord(s[i-1]) + int(s[i])) # ord(s[i-1] to find the char, int(s[i]) to get the number to shift)
        return ''.join(s)


        
if __name__ == "__main__":
    s = "a1c1e1"
    s1 = "n7r3r5j7"
    print(Solution().replaceDigits(s1))
    print(Solution().replaceDigits2(s1))