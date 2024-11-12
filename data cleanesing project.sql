USE world_layoffs;
Select *
from layoffs;

CREATE TABLE LAYOFFS_STAGING
LIKE LAYOFFS;

Select *
from LAYOFFS_STAGING;

INSERT LAYOFFS_STAGING
SELECT *
FROM LAYOFFS;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions )AS row_num
FROM LAYOFFS_STAGING2
order by 1;

WITH DUPLICATE_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions )AS row_num
FROM LAYOFFS_STAGING

)
SELECT *
FROM DUPLICATE_CTE
WHERE ROW_NUM > 1;

CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DELETE
FROM LAYOFFS_STAGING3
WHERE row_num > 1;


ALTER TABLE LAYOFFS_STAGING2
ADD COLUMN row_num INT;

INSERT INTO LAYOFFS_STAGING3
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions )AS row_num
FROM LAYOFFS_STAGING;

SELECT *
FROM LAYOFFS_STAGING3;


SELECT company, TRIM(company)
FROM LAYOFFS_STAGING3;

UPDATE LAYOFFS_STAGING3
SET company = TRIM(company);

SELECT*
FROM LAYOFFS_STAGING3
WHERE industry LIKE 'Crypto%';

UPDATE LAYOFFS_STAGING3
SET industry = 'Crypto'
where industry LIKE 'Crypto%';

SELECT*
FROM LAYOFFS_STAGING3
WHERE industry LIKE 'Crypto%';

select distinct location
from layoffs_staging2
order by 1;
UPDATE LAYOFFS_STAGING3
SET location = 'Dusseldorf'
WHERE location like 'DÃ¼sseldorf';

SELECT distinct country, trim(trailing'.'from country)
FROM LAYOFFS_STAGING2
order by 1;

update layoffs_staging3
SET country = trim(trailing'.'from country)
WHERE country LIKE 'United States%';

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM LAYOFFS_STAGING3;

SELECT *
FROM LAYOFFS_STAGING3
ORDER BY 1;

ALTER TABLE LAYOFFS_STAGING2
modify column `date` DATE;

update LAYOFFS_STAGING2
set `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT *
FROM LAYOFFS_STAGING2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging3
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging3
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry
FROM layoffs_staging3 t1
JOIN layoffs_staging3 t2
     ON t1.company = t2.company
     AND t1.location = t2.location 
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging3 t1
JOIN layoffs_staging3 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL; 

UPDATE layoffs_staging3
SET industry = NULL
WHERE industry = "";

SELECT *
FROM layoffs_staging3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging3;

DELETE
FROM layoffs_staging3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging3
DROP COLUMN row_num;