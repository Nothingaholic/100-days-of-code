-- Stratascratch
-- Spotify
-- Medium

/* 

Find songs that have ranked in the top position. 
Output the track name and the number of times it ranked at the top. 
Sort your records by the number of times the song was in the top position in descending order.

Table: spotify_worldwide_daily_song_ranking
+---------------+------------+
| id            |    int     | 
+---------------+------------+
| position      |    int     | 
+---------------+------------+
| trackname     |  varchar   |
+---------------+------------+
| artist        |  varchar   |
+---------------+------------+
| streams       |    varchar |
+---------------+------------+
| url           |    varchar | 
+---------------+------------+
| date          |   datetime |
+---------------+------------+
| region        |    varchar |
+---------------+------------+


*/

SELECT trackname, count(*)
FROM spotify_worldwide_daily_song_ranking
WHERE position = '1'
GROUP BY trackname;