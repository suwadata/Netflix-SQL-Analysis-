CREATE DATABASE netflix_analysis;
USE netflix_analysis;

CREATE TABLE netflix_titles(
show_id VARCHAR(20),
show_type VARCHAR(20),
title VARCHAR(255),
director TEXT,
cast TEXT,
country TEXT,
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(20),
duration VARCHAR(50),
listed_in TEXT,
show_description TEXT
);

SHOW TABLES;
SELECT COUNT(*) FROM netflix_titles;
SELECT * FROM netflix_titles LIMIT 10;