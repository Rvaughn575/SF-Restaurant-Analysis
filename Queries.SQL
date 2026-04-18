HIGH RISK BUSINESSES
SELECT business_name, business_address, business_postal_code, 
COUNT(*) AS inspection_count,
ROUND(AVG(inspection_score), 1) AS avg_score, MIN(inspection_score) AS lowest_score
FROM `Restaurant_Data.Inspections`
WHERE inspection_score IS NOT NULL
GROUP BY business_name, business_address, business_postal_code
HAVING inspection_count >= 3 AND avg_score < 75
ORDER BY avg_score ASC
LIMIT 50

INSPECTION TRENDS
SELECT
  EXTRACT(YEAR FROM PARSE_TIMESTAMP('%Y %b %d %I:%M:%S %p', inspection_date)) AS year,
  ROUND(AVG(inspection_score), 1) AS avg_score,
  COUNT(*) AS total_inspections
FROM `sf-portfolio-493619.Restaurant_Data.Inspections`
WHERE inspection_score IS NOT NULL
  AND inspection_date IS NOT NULL
GROUP BY year
ORDER BY year;

SCORE DISTRIBUTION BY ZIP CODE
SELECT business_postal_code As zip_code,
count(*) AS total_inspections,
round(AVG(inspection_score), 1) AS avg_score,
countif(inspection_score < 70) AS low_score_count
 FROM `sf-portfolio-493619.Restaurant_Data.Inspections` 
 WHERE inspection_score IS NOT NULL
 AND business_postal_code IS NOT NULL
 GROUP BY Zip_Code
 ORDER BY avg_score ASC
 LIMIT 30

VIOLATION TYPES
SELECT violation_description,
  COUNT(*) AS violation_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total
 FROM `sf-portfolio-493619.Restaurant_Data.Inspections` 
 WHERE violation_description IS NOT NULL
GROUP BY violation_description
ORDER BY violation_count DESC
LIMIT 200
