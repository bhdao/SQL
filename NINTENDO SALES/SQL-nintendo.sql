--The data came in 10,000s, so dividing by 100 converts to millions.
--Source of data below:
--https://www.nintendo.co.jp/ir/en/finance/hard_soft/index.html

--Get Total Switch units (model independent) sold overall by location
SELECT Location, SUM(Units)/100 as 'Total Units Sold (millions)'
FROM dbo.HardwareSales0$
GROUP BY Location
ORDER BY 'Total Units Sold (Millions)' DESC

--Get Total Switch units sold by Model and Location (3/2018 - 3/2022)
SELECT Model, Location, SUM(Units)/100 as 'Total Units Sold (millions)'
FROM dbo.HardwareSales0$
GROUP BY Location, Model
ORDER BY 'Total Units Sold (millions)' DESC

--Get Total Switch units sold by Model and Location in 3/2022
SELECT Location, SUM(Units)/100 as 'Total Units Sold (millions)', SUM(Units) as 'Total Units Sold (ten thousands)'
FROM dbo.HardwareSales0$
WHERE Date = '3/2022'
GROUP BY Location
ORDER BY 'Total Units Sold (millions)' DESC

--Get Total Switch units sold by Model and Location in 3/2022
SELECT Model, Location, SUM(Units)/100 as 'Total Units Sold (millions)', SUM(Units) as 'Total Units Sold (ten thousands)'
FROM dbo.HardwareSales0$
WHERE Date = '3/2022'
GROUP BY Location, Model
ORDER BY 'Total Units Sold (millions)' DESC

--
--Total Model Units Sold up to 3/2022
SELECT Model, SUM(Units)/100 as 'Total Units Sold (millions)', SUM(Units) as 'Total Units Sold (ten thousands)'
FROM dbo.HardwareSales0$
GROUP BY Model
ORDER BY 'Total Units Sold (millions)' DESC

--Total Model Units Sold in 3/2022
SELECT Model, SUM(Units)/100 as 'Total Units Sold (millions)', SUM(Units) as 'Total Units Sold (ten thousands)'
FROM dbo.HardwareSales0$
WHERE date = '3/2022'
GROUP BY Model
ORDER BY 'Total Units Sold (millions)' DESC

--Get Top 3 Best Selling Models, Separated by Year
SELECT TOP 3 Model, SUM(Units)/100 'Total Units Sold (millions)', Date
FROM dbo.HardwareSales0$
GROUP BY Model, Date
ORDER BY 'Total Units Sold (millions)' DESC

--Get Total Units Sold by Year
SELECT Date, SUM(Units)/100 as 'Total Units Sold (millions)'
FROM dbo.HardwareSales0$
GROUP BY Date
ORDER BY Date DESC

--Get Total Units Sold overall from 3.2018 - 3.2022
SELECT SUM(Units)/100 as 'Total Units Sold (millions)'
FROM dbo.HardwareSales0$

SELECT Model, Date, SUM(Units/100) as 'Total Units Sold (millions)'
FROM dbo.HardwareSales0$
GROUP BY Model, Date
ORDER BY Date DESC