# Anime Database Project
## Overview
This project involves designing and implementing a database schema for managing anime-related information, including anime titles, user interactions, recommendations, and ratings. The database schema is tailored for a platform where users can engage with anime content, share recommendations, and provide ratings.
![Anime Snapshot](https://github.com/AKaur-Connect/anime-recommendations-db/blob/main/Anime%20Snapshot.png)
## Dataset
The database consists of five tables:

- Anime: Stores information about individual anime titles.
- StatusTable: Contains various status options indicating the watching status of users for specific anime.
- UserAnime: Records user-specific interactions with anime, including ratings and watched episodes.
- AnimeRecommendations: Captures user recommendations for specific anime titles.
- UserAnimeRatings: Stores individual user ratings for anime titles.

## ER Diagram 

![ER Diagram](https://github.com/AKaur-Connect/anime-recommendations-db/blob/main/ER%20Diagram.png)
## Views
Several views have been created to facilitate data analysis and summarization:

- User's Watchlist: Displays anime in a user's watchlist.
- Highly Rated Anime: Showcases anime with a high average rating.
- User Ratings: Provides a summary of user ratings.
- Anime with Most Recommendations: Lists anime with the most recommendations.
- Anime Seasons and Episode Counts: Provides a count of anime for each season.

## SQL Functions
Various SQL functions and operations have been utilized:

- Filter with WHERE Clause: Filter anime titles based on rating criteria.
- Join Tables: Combines data from different tables for comprehensive analysis.
- Sub-query with IN: Retrieves anime titles recommended by a specific ID.
- Aggregate Function - GROUP BY: Calculates average ratings for each anime.
- String Function - CONCAT: Combines anime titles and types for readability.
- Window Function - ROW_NUMBER: Ranks anime titles based on rating scores.
- Common Table Expression (CTE): Identifies top-rated anime titles.
- CASE Statement: Categorizes anime into rating categories.
- Window Function with PARTITION BY: Calculates average rating and ranking within each anime type.
- Analytic Function with LEAD and LAG: Compares anime ratings within a sequence.
- Pivot Table with CASE Statements: Creates a pivot table for visual analysis.
- Correlated Sub-query with Aggregation: Identifies outstanding anime titles within specific types.
 
## Scripts
- Create_and_Insert_Script.sql: Script for creating and inserting data into tables.
- Create_Views_Anime_data.sql: Script for creating views.
- Using_function_Anime_data.sql: Script demonstrating the use of SQL functions.

##  References
- Valdivieso, H. (2020). AnimePlanet Recommendation Database 2020. Kaggle.[DATASET] https://www.kaggle.com/datasets/hernan4444/animeplanet-recommendation-database-2020 
- Roy Chowdhury, A. (2023, August 7). Best Jujutsu Kaisen Fan Theories [IMAGE]. GameRant. https://gamerant.com/best-jujutsu-kaisen-fan-theories/ 
