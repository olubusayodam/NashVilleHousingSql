Select *
FROM HousingProject.dbo.housing

--Standardize Date Format
Select SaleDateConverted
FROM HousingProject.dbo.housing


USE HousingProject;
ALTER TABLE housing
ADD SaleDateConverted DATE;



UPDATE housing
SET SaleDateConverted = CONVERT(DATE, SaleDate);

--Populate Property Address date
Select a.ParcelID, a.PropertyAddress,b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM HousingProject.dbo.housing a
JOIN HousingProject.dbo.housing b
on a.ParcelID =b.ParcelID
AND a.uniqueID <> b.UniqueID
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM HousingProject.dbo.housing a
JOIN HousingProject.dbo.housing b
on a.ParcelID =b.ParcelID
AND a.uniqueID <> b.UniqueID
Where a.PropertyAddress is null



--Breaking out address into individual columns
Select PropertyAddress
FROM HousingProject.dbo.housing


--
SELECT 
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS RestOfAddress
FROM HousingProject.dbo.housing;
--
USE HousingProject;
ALTER TABLE housing
ADD PropertySplitAddress Nvarchar(255);

UPDATE housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

USE HousingProject;

-- Check if the column 'PropertySplitCity' already exists in the 'housing' table
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'PropertySplitCity' AND OBJECT_ID = OBJECT_ID(N'housing'))
BEGIN
    -- Add the 'PropertySplitCity' column to the 'housing' table if it doesn't exist
    ALTER TABLE housing
    ADD PropertySplitCity NVARCHAR(255);
END


UPDATE housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress));

Select *
FROM HousingProject.dbo.housing

--
Select
PARSENAME(REPLACE(OwnerAddress,',', '.'),3)
,PARSENAME(REPLACE(OwnerAddress,',', '.'),2)
,PARSENAME(REPLACE(OwnerAddress,',', '.'),1)
FROM HousingProject.dbo.housing

UPDATE housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

USE HousingProject;

-- Check if the column 'PropertySplitCity' already exists in the 'housing' table
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'PropertySplitCity' AND OBJECT_ID = OBJECT_ID(N'housing'))
BEGIN
    -- Add the 'PropertySplitCity' column to the 'housing' table if it doesn't exist
    ALTER TABLE housing
    ADD PropertySplitCity NVARCHAR(255);
END


UPDATE housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress));


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From HousingProject.dbo.housing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From HousingProject.dbo.housing


Update housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From HousingProject.dbo.housing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From HousingProject.dbo.housing



-- Delete Unused Columns



Select *
From HousingProject.dbo.housing


ALTER TABLE HousingProject.dbo.housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate













