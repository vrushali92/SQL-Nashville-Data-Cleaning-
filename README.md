# SQL-Nashville-Data-Cleaning

# Cleaning the Nashville Housing Dataset using SQL.

I have cleaned this data using SQL statements. Here the data was retrieved, understood and then accordingly updated.

# What was done?
- Converting String Date to Date datatype.
- Updating missing values in Address Column.
- Formating ParcelID, Acreage, LandValue
- Breaking out PropertyAddress, Owner Address into individual columns
- Change Y and N to Yes and No in 'SoldasVacant' field.
- Removing Duplicates and redudndant columns

# Credits

This is a guided project from AlextheAnalyst: https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx

# Files
- Dataset: Nashville_Housing_Data.xlsx in `.csv `  
- Code: Nashville_Data_Cleaning.sql `.sql` 

# Setup
- Docker
- Azure Data Studio

# Dataset

This dataset has 54403 records. It primarily describes the Nashville property's detail containing the Owner and its property details.

Description of the variables:

- `UniqueID`: Primary key
- `ParcelID` : varchar
- `LandUse` : varchar, Type of the property e.g Condo, Church, Apartment, Daycare
- `PropertyAddress` : varchar
- `SaleDate`: Date
- `SalePrice`: Integer
- `LegalReference` : varchar 
- `SoldAsVacant` : Bool, Yes/ No
- `OwnerName`: varchar
- `OwnerAddress` : varchar
- `Acreage` : Float
- `TaxDistrict` : varchar
- `LandValue` : Integer
- `BuildingValue` : Integer
- `TotalValue` : Integer
- `YearBuilt` : Integer
- `Bedrooms` : Integer
- `FullBath` : Integer
- `HalfBath` : Integer

				
