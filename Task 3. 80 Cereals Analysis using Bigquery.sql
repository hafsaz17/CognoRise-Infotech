-- Find cereals with more than 5 grams of fiber
SELECT name, fiber
FROM `centering-sweep-399611.80_cereals.dataset`
WHERE fiber > 5;


-- Calculate the average weight per serving, converting ounces to grams
SELECT name, weight, weight * 28.35 AS weight_grams
FROM `centering-sweep-399611.80_cereals.dataset`;


-- Calculate the percentage of calories from fat for each cereal
SELECT name, fat, calories, ROUND((fat / calories) * 100, 2) AS fat_calories_percentage
FROM `centering-sweep-399611.80_cereals.dataset`;


-- Find the manufacturer with the highest average sugar content
SELECT mfr, AVG(sugars) AS avg_sugars
FROM `centering-sweep-399611.80_cereals.dataset`
GROUP BY mfr
ORDER BY AVG(sugars) DESC 


-- Calculate average calories per serving using CTE
WITH AverageCalories AS (
    SELECT AVG(calories) AS avg_calories
    FROM `centering-sweep-399611.80_cereals.dataset`
)
SELECT *
FROM AverageCalories;


-- Find the cereal with the highest rating
SELECT 
  name, 
  rating AS max_rating
FROM 
  `centering-sweep-399611.80_cereals.dataset`
WHERE 
  rating = (SELECT MAX(rating) FROM `centering-sweep-399611.80_cereals.dataset`);


-- Create a temporary table to filter cereals with low sodium content
CREATE TEMP TABLE LowSodiumCereals AS (
    SELECT name, sodium
    FROM `centering-sweep-399611.80_cereals.dataset` 
    WHERE sodium < 100
);
-- Query the temporary table
SELECT *
FROM LowSodiumCereals;


-- Create a view to calculate the average protein content by manufacturer
CREATE VIEW `centering-sweep-399611.80_cereals.AverageProteinByMfr` AS (
  SELECT mfr, AVG(protein) AS avg_protein
  FROM `centering-sweep-399611.80_cereals.dataset`
  GROUP BY mfr
);
-- Query the view
SELECT *
FROM `centering-sweep-399611.80_cereals.AverageProteinByMfr`;


-- Find cereals with calories above the average calories using subquery
SELECT name, calories
FROM `centering-sweep-399611.80_cereals.dataset`
WHERE calories > (SELECT AVG(calories) FROM `centering-sweep-399611.80_cereals.dataset`);


-- Rank cereals by their ratings
SELECT name, rating,
       RANK() OVER(ORDER BY rating DESC) AS rating_rank
FROM `centering-sweep-399611.80_cereals.dataset`;