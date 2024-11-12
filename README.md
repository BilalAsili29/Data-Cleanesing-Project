Overview
This SQL script processes and cleans data in the world_layoffs database. It imports raw data, detects and removes duplicates, standardizes text values, and formats date fields. It aims to produce a clean dataset of layoff records, focusing on uniformity in industry terms, location names, and formatting consistency.

Prerequisites
Access to the world_layoffs database.
SQL RDBMS supporting window functions and CTEs (Common Table Expressions), such as MySQL or MariaDB.
Basic understanding of SQL data types, especially for text, integer, and date.
Summary of Key Steps
Data Loading

The initial layoff data is loaded from the LAYOFFS table and copied into LAYOFFS_STAGING.
Duplicate Detection

Using ROW_NUMBER with partitioning, duplicate rows are flagged within LAYOFFS_STAGING by assigning unique row_num values to potential duplicates.
Duplicate entries (rows with row_num > 1) are then identified and removed from the staging table (LAYOFFS_STAGING3).
Data Cleaning & Transformation

Text Standardization:
company names are trimmed of whitespace.
industry values are standardized, particularly focusing on variations like "Crypto" (e.g., converting "Crypto..." terms to "Crypto").
Location values are corrected (e.g., "Düsseldorf" corrected to "Dusseldorf").
Date Standardization:
Date formats are converted from strings to SQL date format using STR_TO_DATE in LAYOFFS_STAGING3.
Country Name Formatting:
Removes trailing periods from country values.
Missing Data Handling:
Checks for missing industry values and, where possible, fills them based on other rows with matching company and location.
Final Cleanup

Removes rows with missing values in total_laid_off and percentage_laid_off.
Drops the temporary row_num column after all deduplication steps are complete.
