SELECT *
FROM Nashville_Housing

-- Standardize Date Format
-- Below query is for reference as SaleDate column is already in Date format.

UPDATE Nashville_Housing
SET SaleDate = CONVERT(date, SaleDate)

ALTER TABLE Nashville_Housing
ADD SaleDateConverted DATE


UPDATE Nashville_Housing
SET SaleDateConverted = CONVERT(date, SaleDate)

SELECT SaleDateConverted,
       SaleDate
FROM Nashville_Housing

-- Populate Property Address Column

SELECT COUNT(*)
FROM Nashville_Housing
WHERE PropertyAddress is NULL

-- Answer: 29

SELECT a.parcelID,
       a.propertyaddress, 
       b.parcelID, 
       b.propertyaddress, 
       ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing as a
JOIN Nashville_Housing as b
ON a.parcelID = b.parcelID
AND a.uniqueID <> b.uniqueID
Where a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing as a
JOIN Nashville_Housing as b
ON a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL

-- Replace '.00' from the ParcelID

Select REPLACE(ParcelID, '.00', '')
from Nashville_Housing

UPDATE Nashville_Housing
SET ParcelID = REPLACE(ParcelID, '.00', '')

SELECT ParcelID
From Nashville_Housing

-- Breaking out PropertyAddress into individual columns (Address, City) [USING SUBSTRING()]

SELECT PropertyAddress
FROM Nashville_Housing

SELECT PropertyAddress, 
       SUBSTRING(PropertyAddress, 
                1,
                CHARINDEX(',', PropertyAddress) -1
                ) as Address, -- Subtracting 1 from the length returned from CHARINDEX to remove ',' from the address
       SUBSTRING(PropertyAddress,
                 CHARINDEX(',', PropertyAddress) +1,
                 LEN(PropertyAddress)) as [City/State]
FROM Nashville_Housing

ALTER TABLE Nashville_Housing
ADD PropertyAddress1 VARCHAR(100)

ALTER TABLE Nashville_Housing
ADD PropertyCity VARCHAR(50)

UPDATE Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

UPDATE Nashville_Housing
SET PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

Select *
FROM Nashville_Housing

-- Breaking out OwnerAddress into individual columns (Address, City) [USING PARSENAME()]

SELECT OwnerAddress
FROM Nashville_Housing

SELECT OwnerAddress,
       PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerSplitAddress,
       Trim(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)) as OwnerCity,
       Trim(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)) as OwnerState
FROM Nashville_Housing

ALTER TABLE Nashville_Housing
ADD OwnerSplitAddress VARCHAR(100),
OwnerCity VARCHAR(50),
OwnerState VARCHAR(50)

UPDATE Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
OwnerCity = Trim(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)),
OwnerState = Trim(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1))

SELECT *
FROM Nashville_Housing

-- Change Y and N to Yes and No in 'SoldasVacant' field.

SELECT SoldAsVacant, COUNT(SoldAsVacant)
FROM Nashville_Housing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
END 
FROM Nashville_Housing

UPDATE Nashville_Housing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                    END 

-- Remove Duplicates

SELECT UniqueID, OwnerName
From Nashville_Housing
ORDER by UniqueID

SELECT ROW_NUMBER() OVER(PARTITION by OwnerName ORDER by UniqueID Asc) as Row_Num, UniqueID, OwnerName
FROM Nashville_Housing

SELECT COUNT(OwnerName)
From Nashville_Housing
WHERE OwnerName = 'NULL'

SELECT *
FROM Nashville_Housing

With RowNumCTE as 
(
    SELECT *,
    ROW_NUMBER() OVER ( PARTITION BY ParcelID,PropertyAddress, SalePrice, SaleDate,LegalReference  -- Deleting records based on these fields
    order by uniqueID)row_num
    FROM Nashville_Housing
    -- ORDER by ParcelID       
)

Select * 
FROM RowNumCTE
WHERE row_num >= 2

-- Delete redundant columns

ALTER TABLE Nashville_Housing
DROP COLUMN  PropertyAddress, OwnerAddress

SELECT PropertyAddress, OwnerAddress
FROM Nashville_Housing

SELECT *
FROM Nashville_Housing

-- Replacing NULL Value in Numeric Columns to 0/0.0

-- Acreage
Select Acreage, ISNULL(Acreage, 0.0)
FROM Nashville_Housing

UPDATE Nashville_Housing
SET Acreage = ISNULL(Acreage, 0)

-- LandValue
SELECT LandValue, ISNULL(LandValue, 0)
FROM Nashville_Housing

UPDATE Nashville_Housing
SET LandValue = ISNULL(LandValue, 0)

UPDATE Nashville_Housing
SET BuildingValue = ISNULL(BuildingValue, 0),
TotalValue = ISNULL(TotalValue, 0),
Bedrooms = ISNULL(Bedrooms, 0),
FullBath = ISNULL(FullBath, 0),
HalfBath = ISNULL(HalfBath, 0)

