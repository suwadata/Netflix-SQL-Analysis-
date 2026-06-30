-- NETFLIX SQL ANALYSIS PROJECT
-- Author: Genesis Suwa
-- Database: netflix_analysis



-- =====================
-- PHASE 1: Data_Exploration
-- =====================

-- Total Number of Titles
SELECT COUNT(*) AS total_titles
FROM netflix_titles;

-- Movies vs TV Shows Distribution
SELECT show_type, COUNT(*) AS total
FROM netflix_titles
GROUP BY show_type;


-- Missing Values Check
SELECT 
COUNT(*) AS total_rows,
COUNT(director) AS director_filled,
COUNT(country) AS country_filled,
COUNT(date_added) AS date_added_filled,
COUNT(rating) AS rating_filled
FROM netflix_titles;


-- Content Timeline Range
SELECT
MIN(release_year) AS earliest_release,
MAX(release_year) AS latest_release
FROM netflix_titles;

-- Global Reach Analysis
SELECT COUNT(DISTINCT country) AS unique_countries
FROM netflix_titles;

-- Top Producing Countries
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Content Rating Categories
SELECT DISTINCT rating
FROM netflix_titles
ORDER BY rating;


-- ==================
-- PHASE 2: Business_Analysis
-- ==================


-- Most Common Rating
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;

-- Top Genres on Netflix
SELECT listed_in, COUNT(*) AS total
FROM netflix_titles
GROUP BY listed_in
ORDER BY total DESC
LIMIT 10;

-- Content Growth by Year
SELECT  release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

-- Top Directors by Content Count
SELECT director, COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- Longest TV Shows by duration
SELECT title,duration
FROM netflix_titles
WHERE show_type = 'TV Show'
ORDER BY duration DESC
LIMIT 10;

-- Content Type by Rating
SELECT show_type,rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY show_type, rating
ORDER BY show_type, total DESC;


-- ================
-- PHASE 3: Advanced SQL
-- ================


-- Country Ranking
SELECT
country,
COUNT(*) AS total_titles,
RANK() OVER (ORDER BY COUNT(*) DESC) AS country_rank
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country;


-- Running Total Release by Year
SELECT
release_year,
COUNT(*) AS yearly_titles,
SUM(COUNT(*)) OVER (ORDER BY release_year) AS Ccumulative_titles
FROM netflix_titles
GROUP BY release_year;

-- Duration Cleaning
SELECT
title,
CAST(SUBSTRING_INDEX(duration,'',1) AS UNSIGNED) AS duration_minutes
FROM netflix_titles
WHERE show_type = 'Movie'
ORDER BY duration_minutes DESC
LIMIT 10;

-- Rating Analysis with CTE
WITH rating_counts AS(
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
)
SELECT *
FROM rating_counts
ORDER BY total DESC;


-- Recent Content Analysis
SELECT title,release_year,country
FROM netflix_titles
WHERE release_year > 2018
ORDER BY release_year DESC;


-- Percentage Distribution by Type
SELECT 
show_type,
COUNT(*) AS total,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS percentage
FROM netflix_titles
GROUP BY show_type;