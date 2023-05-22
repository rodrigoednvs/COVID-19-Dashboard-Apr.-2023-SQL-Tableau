/*

Queries used for Tableau Dashboard COVID-19 - April 2023
https://public.tableau.com/app/profile/rodrigonvs/viz/COVID-19Dashboard-April2023/Dashboard1
*/

-- 1. Global Total Cases, Total Deaths and Death Percentage

SELECT 
  SUM(new_cases) AS total_cases, 
  SUM(new_deaths) AS total_deaths, 
  ROUND(SUM(new_deaths) / NULLIF(SUM(new_cases), 0)*100, 2) AS death_percentage
FROM `portifolio-project-05042023.covid_dataset.covid_deaths`
WHERE continent IS NOT NULL
ORDER BY 1,2

-- 2. Total Death per Continent

SELECT 
  location, SUM(new_deaths) as TotalDeathCount
FROM `portifolio-project-05042023.covid_dataset.covid_deaths`
WHERE continent is null 
AND location IN ('Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania')
GROUP BY location
ORDER BY TotalDeathCount DESC

-- 3. Percentage of Infections by Country

SELECT 
  Location, 
  Population, 
  MAX(total_cases) AS HighestInfectionCount,  
  ROUND(MAX((total_cases/population))*100, 2) AS PercentPopulationInfected
FROM `portifolio-project-05042023.covid_dataset.covid_deaths`
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- 4. Percentage of Infections by Country per month

SELECT 
  Location, 
  Population, 
  date, 
  MAX(total_cases) as HighestInfectionCount, 
  ROUND(MAX((total_cases/population))*100, 2) as PercentPopulationInfected
FROM `portifolio-project-05042023.covid_dataset.covid_deaths`
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC
