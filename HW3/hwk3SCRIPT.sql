DROP DATABASE IF EXISTS starwarsChenZ;

CREATE DATABASE starwarsChenZ;

USE starwarsChenZ;

CREATE TABLE planets
(
	planet_name				VARCHAR(45)		PRIMARY KEY,
    planet_type					VARCHAR(45)		NOT NULL,
    affiliation						ENUM('rebels', 'empire', 'neutral', 'free-lancer', 'Unknown')		NOT NULL
);


CREATE TABLE characters
(
	character_name 			VARCHAR(45)		PRIMARY KEY,
    race								VARCHAR(45)		NOT NULL,
    home_world				VARCHAR(45)		NOT NULL,
    affiliation						ENUM('rebels', 'empire', 'neutral', 'free-lancer')		NOT NULL,
    
    CONSTRAINT characters_fk_planets
		FOREIGN KEY (home_world)
        REFERENCES planets (planet_name)	ON UPDATE CASCADE
);


CREATE TABLE movies
(
	movie_id						INT							AUTO_INCREMENT				PRIMARY KEY,
    tile								VARCHAR(45)		NOT NULL,
    scene_in_db				INT							NOT NULL,
    scene_in_movie			INT							NOT NULL
);


CREATE TABLE time_table
(
	time_table_id				INT							AUTO_INCREMENT				PRIMARY KEY,
    character_name			VARCHAR(45)		NOT NULL,
    planet_name				VARCHAR(45)		NOT NULL,
    movie_id						INT							NOT NULL,
    time_of_arrival			INT							NOT NULL,
    time_of_departure		INT							NOT NULL,
    CONSTRAINT time_table_fk_characters
		FOREIGN KEY (character_name)
        REFERENCES characters (character_name) 	ON UPDATE CASCADE,
    CONSTRAINT time_table_fk_planets
		FOREIGN KEY (planet_name)
        REFERENCES planets (planet_name) 				ON UPDATE CASCADE,
    CONSTRAINT time_table_fk_movies
		FOREIGN KEY (movie_id)
        REFERENCES movies (movie_id) 					ON UPDATE CASCADE
);