/*
Q1: 
In characrers:
The script provided the default values (null, unknown) for race and home_world, and i believe it's a good design,
since when people are filling out an application, if they leave any space as blank, 
and if the system can autofill it with some value, 
even it is null or unknown. It keeps the data consistancy, and makes sure for every single cell, there must be a value inside.
My script set the affiliation type to ENUM, and I think this is better, since the question specified this field can only have 
"rebels, empire, neutral, free-lancer" these four types. ENUM is better than VARCHAR in this case. Others are the same.

In movies and planets:
It is the same.alter

In the time_table:
The script also provid UNIQUE KEY, this is definitely a good thing to have for future implementation, 
but it's not necessary for the previous homework.
Others are the same.
*/

-- 6


-- Q2:
SELECT character_name, planet_name, title, (SUM(departure) - SUM(arrival)) AS screen_time 
FROM starwarsFINAL.timetable 
JOIN starwarsFINAL.movies ON starwarsFINAL.movies.movie_id = starwarsFINAL.timetable.movie_id 
GROUP BY character_name, planet_name, title
ORDER BY character_name, planet_name;

-- Q3:
SELECT DISTINCT character_name, COUNT(DISTINCT planet_name) AS n FROM timetable GROUP BY character_name;

-- Q4:
SELECT COUNT(*) FROM (
SELECT DISTINCT character_name, planet_type FROM starwarsFINAL.planets 
JOIN starwarsFINAL.timetable ON starwarsFINAL.timetable.planet_name = starwarsFINAL.planets.planet_name 
WHERE planet_type = 'desert') AS x;

-- Q5:
SELECT planet_name FROM (SELECT DISTINCT character_name, planet_name FROM starwarsFINAL.timetable) AS t
ORDER BY planet_name DESC
LIMIT 1;


-- Q6:
SELECT planet_name FROM (
SELECT planet_name, COUNT(DISTINCT character_name) AS x FROM starwarsFINAL.timetable
GROUP BY planet_name) AS t
WHERE x = (SELECT COUNT(*) AS y FROM starwarsFINAL.characters);


-- Q7:
CREATE TABLE Movie1Timings
AS (SELECT * FROM starwarsFINAL.timetable WHERE movie_id = 1);



-- Q8:
SELECT title FROM (SELECT title, (departure - arrival) AS difference 
FROM starwarsFINAL.timetable  
JOIN starwarsFINAL.movies ON starwarsFINAL.timetable.movie_id = starwarsFINAL.movies.movie_id 
WHERE character_name = 'Lando Calrissian' ORDER BY difference DESC) AS t LIMIT 1;

-- Q9:
SELECT DISTINCT planet_type, GROUP_CONCAT(DISTINCT character_name) FROM starwarsFINAL.timetable 
JOIN starwarsFINAL.planets ON starwarsFINAL.timetable.planet_name = starwarsFINAL.planets.planet_name
GROUP BY planet_type;

-- Q10:
SELECT planet_type FROM (SELECT DISTINCT planet_type, COUNT(DISTINCT character_name) AS x FROM starwarsFINAL.timetable 
JOIN starwarsFINAL.planets ON starwarsFINAL.timetable.planet_name = starwarsFINAL.planets.planet_name
WHERE movie_id = 2
GROUP BY planet_type
ORDER BY x
LIMIT 1) AS t;


-- Q11:
SELECT COUNT(*) FROM starwarsFINAL.characters WHERE Affiliation = 'rebels';

-- Q12:
CREATE TABLE RebelsinMovie1Timings
AS (SELECT starwarsFINAL.timetable.character_name, planet_name, movie_id, arrival, departure, time_id 
FROM starwarsFINAL.characters 
JOIN starwarsFINAL.timetable ON starwarsFINAL.timetable.character_name = starwarsFINAL.characters.character_name 
WHERE movie_id = 1 AND affiliation = 'rebels');


-- Q13:
SELECT character_name FROM starwarsFINAL.characters 
JOIN starwarsFINAL.planets ON starwarsFINAL.characters.homeworld = starwarsFINAL.planets.planet_name
WHERE starwarsFINAL.characters.affiliation = starwarsFINAL.planets.affiliation;











