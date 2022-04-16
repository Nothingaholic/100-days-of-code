"""
1773. Count Items Matching a Rule
Easy

You are given an array items, where each items[i] = [typei, colori, namei] describes the type, color, and name of the ith item. You are also given a rule represented by two strings, ruleKey and ruleValue.

The ith item is said to match the rule if one of the following is true:

ruleKey == "type" and ruleValue == typei.
ruleKey == "color" and ruleValue == colori.
ruleKey == "name" and ruleValue == namei.
Return the number of items that match the given rule.

 

Example 1:

Input: items = [["phone","blue","pixel"],["computer","silver","lenovo"],["phone","gold","iphone"]], ruleKey = "color", ruleValue = "silver"
Output: 1
Explanation: There is only one item matching the given rule, which is ["computer","silver","lenovo"].
Example 2:

Input: items = [["phone","blue","pixel"],["computer","silver","phone"],["phone","gold","iphone"]], ruleKey = "type", ruleValue = "phone"
Output: 2
Explanation: There are only two items matching the given rule, which are ["phone","blue","pixel"] and ["phone","gold","iphone"]. Note that the item ["computer","silver","phone"] does not match.
"""




class Solution:
    def countMatches(self, items, ruleKey, ruleValue):
        count = 0
        for item in items:
            if ruleKey == "type" and ruleValue == item[0]:
                count += 1
            if ruleKey == "color" and ruleValue == item[1]:
                count += 1
            if ruleKey == "name" and ruleValue == item[2]:
                count += 1
        return count
    def countMatches2(self, items, ruleKey, ruleValue):
        count = 0
        key_d = {"type": 0, "color": 1, "name": 2}
        for i in items:
            if i[key_d[ruleKey]] == ruleValue:
                # print(i[key_d[ruleKey]])
                count += 1
        return count
if __name__ == '__main__':
    items = [["phone","blue","pixel"],["computer","silver","lenovo"],["phone","gold","iphone"]]
    key = "color"
    value = "silver"
    print(Solution().countMatches(items, key, value))
    print(Solution().countMatches2(items, key, value))