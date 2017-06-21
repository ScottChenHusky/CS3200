USE starwarsFinal;



-- NOTE!!! ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*

I don't know how many test cases you need for each question, so I listed all of them.

Since workbench doesn't allow me to run all the tests at the same time, I commented out some of them.

If you wanna test other cases, just uncomment the lines, but you may need to comment out lines you don't need as well.

Thank you :)


*/
-- Q1 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS track_character;

DELIMITER $$
CREATE PROCEDURE track_character(character_name VARCHAR(45))
BEGIN
SELECT character_name, planet_name, title, (SUM(departure) - SUM(arrival)) AS screen_time
FROM timetable t JOIN movies m ON t.movie_id = m.movie_id
WHERE t.character_name = character_name
GROUP BY character_name, planet_name, title;
END $$
DELIMITER ;

CALL track_character('C-3 PO');
CALL track_character('Chewbacca');
CALL track_character('Darth Vader');
-- CALL track_character('Han Solo');
-- CALL track_character('Jabba the Hutt');
-- CALL track_character('Lando Calrissian');
-- CALL track_character('Luke Skywalker');
-- CALL track_character('Obi-Wan Kanobi');
-- CALL track_character('Owen Lars');
CALL track_character('Princess Leia');
-- CALL track_character('R2-D2');
-- CALL track_character('Rancor');
CALL track_character('Yoda');

-- Q2 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS track_planet;

DELIMITER $$
CREATE PROCEDURE track_planet(planet_name VARCHAR(45))
BEGIN
SELECT planet_name, title, COUNT(DISTINCT character_name) AS number_of_character 
FROM timetable t JOIN movies m ON t.movie_id = m.movie_id
WHERE t.planet_name = planet_name
GROUP BY title;

END $$
DELIMITER ;

CALL track_planet('Alderaan');
CALL track_planet('Bespin');
CALL track_planet('Corellia');
CALL track_planet('Dagobah');
-- CALL track_planet('Death Star');
-- CALL track_planet('Endor');
-- CALL track_planet('Hoth');
-- CALL track_planet('Kashyyyk');
-- CALL track_planet('Star Destroyer');
CALL track_planet('Tatooine');
-- CALL track_planet('Unknown');


-- Q3 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION  IF EXISTS planet_hopping;

DELIMITER $$
CREATE FUNCTION planet_hopping(character_name VARCHAR(45))
RETURNS INT
BEGIN
DECLARE number_of_planet INT;

SELECT COUNT(DISTINCT planet_name) INTO number_of_planet FROM timetable t
WHERE t.character_name = character_name;
RETURN (number_of_planet);

END $$
DELIMITER ;

SELECT planet_hopping('Chewbacca');
SELECT planet_hopping('C-3 PO');
SELECT planet_hopping('Chewbacca');
-- SELECT planet_hopping('Darth Vader');
-- SELECT planet_hopping('Han Solo');
-- SELECT planet_hopping('Jabba the Hutt');
-- SELECT planet_hopping('Lando Calrissian');
-- SELECT planet_hopping('Luke Skywalker');
-- SELECT planet_hopping('Obi-Wan Kanobi');
-- SELECT planet_hopping('Owen Lars');
-- SELECT planet_hopping('Princess Leia');
-- SELECT planet_hopping('R2-D2');
-- SELECT planet_hopping('Rancor');
-- SELECT planet_hopping('Yoda');


-- Q4 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS planet_most_visited;

DELIMITER $$
CREATE FUNCTION planet_most_visited(character_name VARCHAR(45))
RETURNS VARCHAR(45)
BEGIN

DECLARE planet_name_answer VARCHAR(45);

SELECT planet_name INTO planet_name_answer FROM (SELECT DISTINCT planet_name, (SUM(departure) - SUM(arrival)) AS number_of_visit
FROM timetable t WHERE t.character_name = character_name
GROUP BY planet_name) AS h
ORDER BY number_of_visit DESC
LIMIT 1;

RETURN (planet_name_answer);

END $$
DELIMITER ;

SELECT planet_most_visited('C-3 PO');
SELECT planet_most_visited('Chewbacca');
SELECT planet_most_visited('Darth Vader');
-- SELECT planet_most_visited('Han Solo');
-- SELECT planet_most_visited('Jabba the Hutt');
-- SELECT planet_most_visited('Lando Calrissian');
-- SELECT planet_most_visited('Luke Skywalker');
-- SELECT planet_most_visited('Obi-Wan Kanobi');
-- SELECT planet_most_visited('Owen Lars');
-- SELECT planet_most_visited('Princess Leia');
-- SELECT planet_most_visited('R2-D2');
-- SELECT planet_most_visited('Rancor');
-- SELECT planet_most_visited('Yoda');



-- Q5 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS home_affiliation_same;

DELIMITER $$
CREATE FUNCTION home_affiliation_same(character_name VARCHAR(45))
RETURNS VARCHAR(45)
BEGIN

DECLARE flag BOOLEAN;
DECLARE c_a VARCHAR(45);
DECLARE c_h VARCHAR(45);
DECLARE p_a VARCHAR(45);


SELECT c.affiliation, c.homeworld, p.affiliation INTO c_a, c_h, p_a
FROM characters c JOIN planets p ON c.homeworld = p.planet_name
WHERE c.character_name = character_name;

IF c_h = '' OR p_a = '' THEN SET flag = NULL;
ELSEIF c_a = p_a THEN SET flag = 1;
ELSEIF c_a != p_a THEN SET flag = 0;
END IF;

RETURN (flag);
END $$
DELIMITER ;

SELECT home_affiliation_same('C-3 PO');
SELECT home_affiliation_same('Chewbacca');
SELECT home_affiliation_same('Darth Vader');
SELECT home_affiliation_same('Han Solo');
-- SELECT home_affiliation_same('Jabba the Hutt');
-- SELECT home_affiliation_same('Lando Calrissian');
SELECT home_affiliation_same('Luke Skywalker');
-- SELECT home_affiliation_same('Obi-Wan Kanobi');
-- SELECT home_affiliation_same('Owen Lars');
-- SELECT home_affiliation_same('Princess Leia');
-- SELECT home_affiliation_same('R2-D2');
-- SELECT home_affiliation_same('Rancor');
-- SELECT home_affiliation_same('Yoda');

-- Q6 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS planet_in_num_movies;

DELIMITER $$
CREATE FUNCTION planet_in_num_movies(planet_name VARCHAR(45))
RETURNS INT
BEGIN

DECLARE number_of_planet INT;

SELECT COUNT(DISTINCT movie_id) INTO number_of_planet FROM timetable t WHERE t.planet_name = planet_name;
RETURN number_of_planet;

END $$
DELIMITER ;

SELECT planet_in_num_movies('Chewbacca');
SELECT planet_in_num_movies('Alderaan');
SELECT planet_in_num_movies('Bespin');
SELECT planet_in_num_movies('Corellia');
SELECT planet_in_num_movies('Dagobah');
SELECT planet_in_num_movies('Death Star');
SELECT planet_in_num_movies('Endor');
SELECT planet_in_num_movies('Hoth');
SELECT planet_in_num_movies('Kashyyyk');
SELECT planet_in_num_movies('Star Destroyer');
SELECT planet_in_num_movies('Tatooine');
SELECT planet_in_num_movies('Unknown');


-- Q7 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS character_with_affiliation;

DELIMITER $$
CREATE PROCEDURE character_with_affiliation(affiliation VARCHAR(45))
BEGIN

SELECT * FROM characters c WHERE c.affiliation = affiliation;

END $$
DELIMITER ;

CALL character_with_affiliation('rebels');
CALL character_with_affiliation('empire');
CALL character_with_affiliation('neutral');

-- Q8 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS timetable_after_insert;

DELIMITER $$
CREATE TRIGGER timetable_after_insert AFTER INSERT ON timetable
FOR EACH ROW
BEGIN

UPDATE movies
SET scenes_in_db = (SELECT MAX(t.departure) FROM timetable t WHERE movie_id = NEW.movie_id)
WHERE movie_id  = NEW.movie_id;

END $$
DELIMITER ;

INSERT INTO timetable (character_name, planet_name, movie_id, arrival, departure) VALUES ('Chewbacca', 'Endor', 3, 11, 12);
INSERT INTO timetable (character_name, planet_name, movie_id, arrival, departure) VALUES ('Princess Leia', 'Endor', 3, 11, 12);



-- Q9 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @character_name := "'Princess Leia'";
SET @proc_name := "track_character";
SET @s9 := CONCAT("CALL ", @proc_name, "(", @character_name, ")");

PREPARE stmt9 FROM @s9;
EXECUTE stmt9;
DEALLOCATE PREPARE stmt9;


-- Q10 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET @func_name := "planet_in_num_movies";
SET @target := "'Bespin'";
SET @s10 := CONCAT ("SELECT ", @func_name, "(", @target, ")");
PREPARE stmt10 FROM @s10;
EXECUTE stmt10;
DEALLOCATE PREPARE stmt10;













