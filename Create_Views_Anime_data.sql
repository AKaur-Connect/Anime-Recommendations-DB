------------------------------------------------------------------------------------------------------
--Script: Create_Views_Anime_data.sql
--Purpose: Creating views for the anime database for users to analyse and summerise data
--Name: Amanpreet Kaur
--Date: October 22, 2023
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- View 1: User's Watchlist
-- A view that shows the anime in a user's watchlist:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW UserWatchlist AS
     SELECT ua.user_id,
            ua.anime_id,
            a.Name AS AnimeName,
            a.Type,
            a.Episodes,
            a.StartYear,
            a.EndYear
       FROM UserAnime ua
       JOIN Anime a 
         ON ua.anime_id = a.AnimePlanetID
      WHERE ua.watching_status = 1;

------------------------------------------------------------------------------------------------------
-- View 2: Highly Rated Anime
-- A view that shows anime with a high average rating:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW HighlyRatedAnime AS
     SELECT a.AnimePlanetID, 
            a.Name, 
            a.RatingScore, 
            a.NumberVotes
       FROM Anime a
      WHERE a.RatingScore >= 4.0;

------------------------------------------------------------------------------------------------------
-- View 3: User Ratings
-- A view that displays a user's ratings along with the corresponding anime information:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW UserRatings AS
     SELECT ur.user_id, 
            ur.anime_id, 
            ur.rating, 
            a.Name AS AnimeName, 
            a.Type, 
            a.Episodes
       FROM UserAnimeRatings ur
       JOIN Anime a 
         ON ur.anime_id = a.AnimePlanetID;

------------------------------------------------------------------------------------------------------
-- View 4: Anime with Most Recommendations
-- A view that shows anime with the most recommendations, including details about the recommendations:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW AnimeMostRecommended AS
     SELECT a.AnimePlanetID, 
            a.Name AS AnimeName, 
            COUNT(ar.RecommendationID) AS RecommendationCount
       FROM Anime a
       JOIN AnimeRecommendations ar 
         ON a.AnimePlanetID = ar.AnimeID
   GROUP BY a.AnimePlanetID, a.Name
   ORDER BY RecommendationCount DESC;


------------------------------------------------------------------------------------------------------
-- View 5: Anime with Longest Duration
-- A view that shows anime with the longest duration:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW LongestDurationAnime AS
     SELECT a.AnimePlanetID, 
            a.Name AS AnimeName, 
            a.Duration
       FROM Anime a
	   WHERE LOWER(a.Duration) != 'unknown'
   ORDER BY a.Duration DESC,
            a.Name
      LIMIT 5; 

------------------------------------------------------------------------------------------------------
-- View 6: Anime Seasons and Episode Counts
-- A view that shows the count of anime for each season along with the total number of episodes:
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW AnimeSeasonEpisodeCounts AS
     SELECT a.Season,
            COUNT(a.AnimePlanetID) AS AnimeCount,
            SUM(a.Episodes) AS TotalEpisodes
       FROM Anime a
   GROUP BY a.Season
   ORDER BY a.Season;

------------------------------------------------------------------------------------------------------

SELECT * FROM UserWatchlist;
SELECT * FROM HighlyRatedAnime;
SELECT * FROM UserRatings;
SELECT * FROM AnimeMostRecommended;
SELECT * FROM LongestDurationAnime;
SELECT * FROM AnimeSeasonEpisodeCounts;