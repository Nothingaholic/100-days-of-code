-- Stratascratch
-- MEta/Facebook Practice Questions

/* 

Find all posts which were reacted to with a heart

Tables: facebook_reactions, facebook_posts

facebook_reactions
+------------------+------------+
| poster           |    int     | 
+------------------+------------+
| friend           |    int     | 
+------------------+------------+
| reaction         |  varchar   |
+------------------+------------+
| date_day         |    int     |
+------------------+------------+
| post_id          |    int     | 
+------------------+------------+

facebook_posts
+------------------+------------+
| post_id          |    int     |
+------------------+------------+
| poster           |    int     |
+------------------+------------+
| post_text        |  varchar   |
+------------------+------------+
| post_keywords    |  varchar   |
+------------------+------------+
| post_date        | datetime   |
+------------------+------------+

*/
SELECT distinct p.* FROM facebook_posts p
LEFT JOIN facebook_reactions r
ON p.post_id = r.post_id
WHERE r.reaction = 'heart';