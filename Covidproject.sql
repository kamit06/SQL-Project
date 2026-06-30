/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Create Database Covid_Project

Use Covid_Project

Select * from Covid_Project..CovidDeaths
where continent is not null
order by 3,4

Select * from CovidDeaths

Select * from [dbo].[CovidVaccinations]

select * from [dbo].[CovidDeaths]

Select *
From Covid_Project..CovidDeaths
Where continent is not null 
order by 3,4

-- Select the Data that we are starting with

Select location, date, total_cases, new_cases, total_deaths, population
from Covid_Project..CovidDeaths
where continent is not null
Order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying parcentage

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from Covid_Project..CovidDeaths
where location like '%states%'
and continent is not null
Order by 1,2

-- Total Cases vs population
-- Shows what persentage of infected with covid

Select location, date, population, total_cases, (total_cases/population)* 100 as Percentage_Infectedpepole
from Covid_Project..CovidDeaths
-- Where location like %state%
order by Percentage_Infectedpepole desc

-- Country with highest Infection Rate Compared to popultation 

Select location, population, Max(total_cases) as highestinfectioncount, Max(total_cases/population)* 100
as Percentage_Infectedpepole
from Covid_Project..CovidDeaths
group by location, population
order by Percentage_Infectedpepole desc

-- Country with highest death per population

Select location, Max(cast(total_deaths as int)) as totaldeathcount
from Covid_Project..CovidDeaths
where continent is not null
group by location
order by totaldeathcount desc

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, Max(cast(total_deaths as int)) as totaldeathcount
from Covid_Project..CovidDeaths
where continent is not null
group by continent
order by totaldeathcount desc

-- GLOBAL NUMBERS
Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_death, sum(cast(new_deaths as int))/
Sum(New_cases)*100 as DeathPercentage
from Covid_Project..CovidDeaths
where continent is not null 
order by 1,2


Select * from Covid_Project..CovidVaccinations

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select *
from Covid_Project..CovidDeaths d
join Covid_Project..CovidVaccinations v
	on d.location=v.location
	and d.date = v.date


Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as PeopleVaccinated
--(PeopleVaccinated/population)*100
From Covid_Project..CovidDeaths d
join Covid_Project..CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
order by 2,3

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, PeopleVaccinated)
as
(Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as PeopleVaccinated
--(PeopleVaccinated/population)*100
From Covid_Project..CovidDeaths d
join Covid_Project..CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
--order by 2,3
)
Select *, (PeopleVaccinated/Population)*100
From PopvsVac

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
PeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as PeopleVaccinated
--(PeopleVaccinated/population)*100
From Covid_Project..CovidDeaths d
join Covid_Project..CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
--where d.continent is not null 
--order by 2,3

Select *,(PeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations


Create View PercentPopulationVaccinated as
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
,SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as PeopleVaccinated
--(PeopleVaccinated/population)*100
From Covid_Project..CovidDeaths d
join Covid_Project..CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 


Select * 
from PercentPopulationVaccinated