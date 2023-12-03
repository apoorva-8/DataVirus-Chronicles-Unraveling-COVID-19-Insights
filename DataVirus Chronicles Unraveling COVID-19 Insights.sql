select * from coviddeath where continent is not null;
select location,date,total_cases,new_cases,total_deaths,population from coviddeath;

-- Calculating death percentage
select location,date,total_cases,total_deaths,population,(total_deaths/total_cases)*100 as deathpercentage from coviddeath ;


-- Total cases vs population
-- What percentage of population has covid
SELECT location,date,total_cases , population,(total_cases/population)*100 as Casespercentage from coviddeath;


-- Countries with hieghest infection rate compared to population
SELECT location,population , MAX(total_cases) as HieghestInfectionCount , MAX((total_cases/population))*100 as percentageofpopulationinfected from coviddeath 
group by location , population  order by percentageofpopulationinfected desc;
-- The above query gives us that Andorra Country has the most infected percentage

--  Countries with hieghest death count.

SELECT location , MAX(total_deaths) as Total_death_count FROM coviddeath GROUP BY location ORDER BY Total_death_count DESC;
select * from coviddeath where continent is not null;

-- SHOWING THE CONTINENT WITH HIEGHEST DEATH COUNT
SELECT continent,MAX(total_deaths ) as totaldeathcount
FROM coviddeath
WHERE continent is not  null
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- GLOBAL NUMBERS
select location , date , total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
from coviddeath
where continent is not null
order by 1,2;

-- GLOBAL SUM NUMBERS
SELECT date, SUM(new_cases) as totalcases , SUM(new_deaths) as totaldeaths,SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from coviddeath
where continent is not null
group by date
order by 1,2;

-- CALCULATING OVERALL DEATHS VS OVERALL CASES
SELECT  SUM(new_cases) as totalcases , SUM(new_deaths) as totaldeaths,SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from coviddeath
where continent is not null
order by 1,2;
-- From above query we get that total death percentage i.e. total cases vs total death is 1.7 percent.

-- JOINING COVID DEATH AND COVID VACCINE TABLES.
SELECT * FROM coviddeath
JOIN covidvaccine ON coviddeath.location = covidvaccine.location;

-- TOTAL POPULATION VS VACCINATIONS
SELECT coviddeath.continent,coviddeath.location,coviddeath.date,coviddeath.population,covidvaccine.new_vaccinations
FROM coviddeath
JOIN covidvaccine ON coviddeath.location = covidvaccine.location and coviddeath.date = covidvaccine.date;

-- SUM OF NEW VACCINATION
SELECT coviddeath.continent,coviddeath.location,coviddeath.date,coviddeath.population,covidvaccine.new_vaccinations,
SUM(covidvaccine.new_vaccinations) OVER (partition by coviddeath.location ORDER BY coviddeath.location AND coviddeath.date) as consecutiveaddition
FROM coviddeath
JOIN covidvaccine ON coviddeath.location = covidvaccine.location and coviddeath.date = covidvaccine.date;

-- MAXIMUM NO OF PEOPLE VACCINATED VS POPULATION
SELECT coviddeath.continent,coviddeath.location,coviddeath.date,coviddeath.population,covidvaccine.new_vaccinations,
SUM(covidvaccine.new_vaccinations) OVER (partition by coviddeath.location ORDER BY coviddeath.location AND coviddeath.date) as consecutiveaddition
-- (consecutiveaddition/population)*100 as 
FROM coviddeath
JOIN covidvaccine ON coviddeath.location = covidvaccine.location and coviddeath.date = covidvaccine.date;




































 