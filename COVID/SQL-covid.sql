SELECT *
FROM dbo.CovidDeaths$
WHERE continent is not null
order by 3,4

-- Likelihood of death if one contracted COVID, separated by day
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Rate
FROM dbo.CovidDeaths$;

-- Likelihood of death if one contracted COVID, separated by day, locations starting with 'ca'
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Rate
FROM dbo.CovidDeaths$
WHERE location like 'ca%' AND continent is not null
order by 1,2

-- Rate of death for active COVID, separated by day, in North America
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Rate
FROM dbo.CovidDeaths$
WHERE location = 'North America'
order by 1,2

-- Countries with highest infection rate compared to population, % infected
SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, (MAX(total_cases)/Population)*100 as Percent_Infected, Max((total_cases/population))*100 as Death_Rate
FROM dbo.CovidDeaths$
WHERE continent is not null
GROUP BY Location, Population
Order by HighestInfectionCount DESC;


--Countries with Highest Covid Deaths per Popuilation
SELECT Location, Population, MAX(cast(total_deaths as bigint)) as TotalDeathCount
FROM dbo.CovidDeaths$
GROUP BY Location, Population
Order by TotalDeathCount DESC;

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM dbo.CovidDeaths0$
WHERE continent is null
AND location not in  ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TOtalDeathcount desc

SELECT *
FROM dbo.CovidDeaths$
WHERE Location = 'North America'

--Global Covid cases and deaths by day
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Rate
FROM dbo.CovidDeaths$
WHERE continent is not null
Group by date
order by 1,2

--Global Covid cases and deaths overall
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Rate
FROM dbo.CovidDeaths0$
WHERE continent is not null
order by 1,2

SELECT d.continent, d.location, d.date, population, v.new_vaccinations
FROM dbo.CovidDeaths0$ d
JOIN dbo.CovidVaccinationz$ v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent is not null
ORDER BY 1,2,3

Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) as RollingPeopleVaccinated,
(RollingPeopleVaccinated/population)*100
FROM dbo.CovidDeaths0$ d
JOIN dbo.CovidVaccinationz$ v
	ON d.location = v.location
	and d.date = v.date
WHERE d.continent is not null
order by 2,3;

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) as RollingPeopleVaccinated
FROM dbo.CovidDeaths0$ d
JOIN dbo.CovidVaccinationz$ v
	ON d.location = v.location
	and d.date = v.date
WHERE d.continent is not null
)
SELECT *, (RollingPeopleVaccinated/population)100
FROM PopvsVac