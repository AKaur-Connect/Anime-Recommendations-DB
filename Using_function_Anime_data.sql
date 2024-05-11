------------------------------------------------------------------------------------------------------
--Script: Using_function_Anime_data.sql
--Purpose: The purpose of this script is to analyse the anime database using various SQL functions.
--Name: Amanpreet Kaur
--Date: October 22, 2023
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- 1. Filter with WHERE Clause:
-- Retrieve anime with a rating greater than 4.0:
------------------------------------------------------------------------------------------------------
SELECT * 
  FROM Anime
 WHERE RatingScore > 4.0;

------------------------------------------------------------------------------------------------------
-- 2. Join Tables:
-- Retrieve user ratings with anime details:
------------------------------------------------------------------------------------------------------
SELECT ur.user_id, 
       ur.anime_id, 
       ur.rating, 
       a.Name AS AnimeName
  FROM UserAnimeRatings ur
  JOIN Anime a 
    ON ur.anime_id = a.AnimePlanetID;

------------------------------------------------------------------------------------------------------
-- 3. Sub-query with IN:
-- Retrieve anime titles recommended by a specific recommendation id:
------------------------------------------------------------------------------------------------------
SELECT Name
  FROM Anime
 WHERE AnimePlanetID IN ( SELECT AnimeID
                            FROM AnimeRecommendations
                           WHERE RecommendationID = 12
);

------------------------------------------------------------------------------------------------------
-- 4. Aggregate Function - GROUP BY:
-- Find the average rating for each anime and rounding the result to 2 digits:
------------------------------------------------------------------------------------------------------
SELECT anime_id, 
       ROUND(AVG(rating),2) AS AvgRating
  FROM UserAnimeRatings
 GROUP BY anime_id;

------------------------------------------------------------------------------------------------------
-- 5. String Function - CONCAT:
-- Combine anime title and type in a single column:
------------------------------------------------------------------------------------------------------
SELECT CONCAT(Name, ' - ', Type) AS TitleWithType
  FROM Anime;

------------------------------------------------------------------------------------------------------
-- 6. Window Function - ROW_NUMBER:
-- Assign a rank to anime based on their rating:
------------------------------------------------------------------------------------------------------
SELECT AnimePlanetID,
       Name,
       RatingScore,
       ROW_NUMBER() OVER (ORDER BY RatingScore DESC) AS RatingRank
  FROM Anime;

------------------------------------------------------------------------------------------------------
-- 7. Common Table Expression (CTE):
-- Use CTE to find the anime with the highest rating:
------------------------------------------------------------------------------------------------------
WITH TopRatedAnime AS (
    SELECT AnimePlanetID,
           Name, 
           RatingScore,
           ROW_NUMBER() OVER (ORDER BY RatingScore DESC) AS RatingRank
      FROM Anime
)
SELECT * 
  FROM TopRatedAnime
 WHERE RatingRank = 1;

------------------------------------------------------------------------------------------------------
-- 8. CASE Statement:
-- Categorize anime based on their rating:
------------------------------------------------------------------------------------------------------
SELECT Name,
       RatingScore,
       CASE
           WHEN RatingScore >= 4.0 THEN 'Highly Rated'
           WHEN RatingScore >= 2.5 THEN 'Moderately Rated'
           ELSE 'Low Rated'
       END AS RatingCategory
  FROM Anime;

------------------------------------------------------------------------------------------------------
-- 9. Window Function with PARTITION BY:
-- Calculate the average rating and the rank within each anime type:
------------------------------------------------------------------------------------------------------
SELECT AnimePlanetID,
       Name,
       Type,
       RatingScore,
       AVG(RatingScore) OVER (PARTITION BY Type) AS AvgRatingInType,
       RANK() OVER (PARTITION BY Type ORDER BY RatingScore DESC) AS RatingRankInType
  FROM Anime;

------------------------------------------------------------------------------------------------------
-- 10. Analytic Function with LEAD and LAG:
-- Compare the rating of an anime with the previous and next anime:
------------------------------------------------------------------------------------------------------
SELECT AnimePlanetID,
       Name,
       RatingScore,
       LAG(RatingScore) OVER (ORDER BY RatingScore) AS PreviousRating,
       LEAD(RatingScore) OVER (ORDER BY RatingScore) AS NextRating
  FROM Anime;

------------------------------------------------------------------------------------------------------
-- 11. Pivot Table with CASE Statements:
-- Create a pivot table to show the count of anime for each type:
------------------------------------------------------------------------------------------------------
SELECT Type,
       COUNT(CASE WHEN RatingScore >= 4.0 THEN 1 END) AS HighlyRated,
       COUNT(CASE WHEN RatingScore >= 2.5 AND RatingScore < 8.0 THEN 1 END) AS ModeratelyRated,
       COUNT(CASE WHEN RatingScore < 2.5 THEN 1 END) AS LowRated
  FROM Anime
 GROUP BY Type;

------------------------------------------------------------------------------------------------------
-- 12. Window Function with PARTITION BY and ORDER BY Date:
-- Calculate the cumulative number of episodes watched by users:
------------------------------------------------------------------------------------------------------
SELECT user_id,
       anime_id,
       watched_episodes,
       SUM(watched_episodes) OVER (PARTITION BY user_id) AS CumulativeEpisodes
  FROM UserAnime
 ORDER BY user_id;


------------------------------------------------------------------------------------------------------
-- 13. Correlated Sub-query with Aggregation:
-- Find anime with a rating higher than the average rating of their type:
------------------------------------------------------------------------------------------------------
SELECT AnimePlanetID,
       Name,
       Type,
       RatingScore
  FROM Anime a
 WHERE RatingScore > ( SELECT AVG(RatingScore)
                         FROM Anime
                        WHERE Type = a.Type
);


