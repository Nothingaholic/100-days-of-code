"""
1859. Sorting the Sentence
Easy

A sentence is a list of words that are separated by a single space with no leading or trailing spaces. Each word consists of lowercase and uppercase English letters.

A sentence can be shuffled by appending the 1-indexed word position to each word then rearranging the words in the sentence.

For example, the sentence "This is a sentence" can be shuffled as "sentence4 a3 is2 This1" or "is2 sentence4 This1 a3".
Given a shuffled sentence s containing no more than 9 words, reconstruct and return the original sentence.

 

Example 1:

Input: s = "is2 sentence4 This1 a3"
Output: "This is a sentence"
Explanation: Sort the words in s to their original positions "This1 is2 a3 sentence4", then remove the numbers.
Example 2:

Input: s = "Myself2 Me1 I4 and3"
Output: "Me Myself and I"
Explanation: Sort the words in s to their original positions "Me1 Myself2 and3 I4", then remove the numbers.
"""
import re
class Solution:
    def sortSentence(self, s: str) -> str:
        """
        \d+ matches 1-or-more digits.
        \d*\D+ matches 0-or-more digits followed by 1-or-more non-digits.
        \d+|\D+ matches 1-or-more digits or 1-or-more non-digits.
        """
        
        res = s.split()
        res.sort(key = lambda item:item[-1])
        ans = []
        for i in res:
            ans.append(i[:-1])
        return ' '.join(ans)

if __name__ == '__main__':
    s = "is2 sentence4 This1 a3"
    print(Solution().sortSentence(s))