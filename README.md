
#  Nashville Housing Data Cleaning in SQL

----
# Project Objective:
The objective of this project is to perform data cleaning on the housing dataset to ensure data integrity and prepare it for further analysis. The dataset contains information about various housing properties, including sale dates, prices, property addresses, and other relevant attributes. By cleaning the data, my aim is to remove inconsistencies, handle missing values, and standardize data formats, making it ready for meaningful insights and decision-making.



-----
# Data Sourcing:
The housing dataset used will be attached to this repository.



----
# Data Transformation:
Below are the key data cleaning steps performed on the housing dataset:

1. Standardize Date Format:
A new column, "SaleDateConverted," was added to the dataset to store the converted sale dates. The existing "SaleDate" values were transformed into the proper date format using the SQL `CONVERT` function.

2. Populate Property Address Data:
To fill in missing "PropertyAddress" values, we utilized a self-join on the "housing" table based on common "ParcelID." Rows with missing addresses were populated with non-null addresses from other rows having the same "ParcelID."

3. Breaking Out Address into Individual Columns:
We split the "PropertyAddress" into two separate columns, "Address" and "RestOfAddress," using the comma (',') as a separator. This allowed us to analyze and extract specific address components easily.

4. Add and Update New Columns for Address:
New columns, "PropertySplitAddress" and "PropertySplitCity," were added to the "housing" table to store the split address components. These columns were populated using SQL queries with appropriate `SUBSTRING` and `CHARINDEX` functions.

5. Change "Y" and "N" to "Yes" and "No" in "SoldAsVacant" Field:
The "SoldAsVacant" column values were updated to replace "Y" with "Yes" and "N" with "No" using SQL `CASE` statements.

6. Remove Duplicates:
Duplicate rows were identified and removed based on specific columns (ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference) using a Common Table Expression (CTE) with the `ROW_NUMBER` window function.




----
# Findings & Recommendation:
After performing the data cleaning process, several insights were gained:

1. The dataset now contains standardized date formats for easier analysis of sale trends over time.

2. Missing property addresses have been populated using relevant information from other rows, ensuring a complete dataset for further analysis.

3. Address components, such as street name, city, and state, have been extracted into separate columns, making location-based analysis more convenient.

4. "SoldAsVacant" values have been transformed into a more readable format, enhancing clarity in interpreting the dataset.
----
# Conclusion:
The data cleaning process for the housing dataset was successful, resulting in a clean, consistent, and well-structured dataset. By addressing missing values, standardizing formats, and extracting address components, the dataset is now prepared for meaningful analysis and data-driven decision-making.

