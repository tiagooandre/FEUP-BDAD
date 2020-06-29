PRAGMA foreign_keys = true;

DROP TABLE IF EXISTS Duel;
DROP TABLE IF EXISTS Pilot;
DROP TABLE IF EXISTS Race;
DROP TABLE IF EXISTS Participation;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Aircraft;


CREATE TABLE Team (
	    name TEXT PRIMARY KEY,
	    country TEXT
);

CREATE TABLE Aircraft (
	    model TEXT PRIMARY KEY,
	    horsepower int,
	    topspeed NUMERIC,
	    width NUMERIC,
	    height NUMERIC,
	    weight NUMERIC
);

CREATE TABLE Pilot (
	    num int PRIMARY KEY,
	    firstname TEXT,
	    surname TEXT,
	    nationality TEXT,
	    birthday TEXT,
	    name TEXT,
	    model TEXT,
	    FOREIGN KEY (name) REFERENCES Team(name),
	    FOREIGN KEY (model) REFERENCES Aircraft(model)
);

CREATE TABLE Race (
	    location TEXT,
	    edition int,
	    country TEXT,
	    date TEXT UNIQUE NOT NULL,
	    gates NUMERIC,
	    eliminations NUMERIC,
	    PRIMARY KEY (location, edition)
);

CREATE TABLE Participation (
    num int,
    location TEXT,
    edition int,
    trainingpos int,
    trainingtime NUMERIC,
    trainingpenaly NUMERIC,
    qualificationpos int,
    qualificationtime NUMERIC,
    eliminationpos int,
    eliminationtime NUMERIC,
    eliminationpenalty NUMERIC,

    PRIMARY KEY (num, location, edition),

    FOREIGN KEY (num) REFERENCES Pilot,
    FOREIGN KEY (location, edition) REFERENCES Race,

    CONSTRAINT CHK_positions CHECK ( trainingpos >= 1 AND qualificationpos >= 1 AND eliminationpos >= 1 ),
    CONSTRAINT CHK_times CHECK ( trainingtime > 0 AND qualificationtime > 0 AND eliminationtime > 0),

    CONSTRAINT CHK_train CHECK ( (trainingpos IS NULL AND trainingtime IS NULL)
                                            OR
                                 (trainingpos IS NOT NULL AND trainingtime IS NOT NULL)),

    CONSTRAINT CHK_qualification CHECK ( (qualificationpos IS NULL AND qualificationtime IS NULL)
                                            OR
                                         (qualificationpos IS NOT NULL AND qualificationtime IS NOT NULL)),

    CONSTRAINT CHK_elimination CHECK ( (eliminationpos IS NULL AND eliminationtime IS NULL)
                                            OR
                                     (eliminationpos IS NOT NULL AND eliminationtime IS NOT NULL))
);

CREATE TABLE Duel (
    numpilot1 int,
    numpilot2 int,
    location TEXT,
    edition int,
    dueltype TEXT,
    timepilot1 NUMERIC,
    timepilot2 NUMERIC,
    penaltypilot1 NUMERIC,
    penaltypilot2 NUMERIC,

    PRIMARY KEY (numpilot1, numpilot2, location, edition),

    FOREIGN KEY (numpilot1) REFERENCES Pilot,
    FOREIGN KEY (numpilot2) REFERENCES Pilot,
    FOREIGN KEY (location, edition) REFERENCES Race
);


INSERT INTO Team(name, country) VALUES ('Equipa 1', 'Portugal');
INSERT INTO Team(name, country) VALUES ('Equipa 2', 'Espanha');
INSERT INTO Team(name, country) VALUES ('Equipa 3', 'França');
INSERT INTO Team(name, country) VALUES ('Equipa 4', 'Itália');

INSERT INTO Aircraft(model, horsepower, topspeed, width, height, weight)
    VALUES ('Model 1', 120, 240, 10, 10, 10);
INSERT INTO Aircraft(model, horsepower, topspeed, width, height, weight)
    VALUES ('Model 2', 200, 260, 10, 10, 10);
INSERT INTO Aircraft(model, horsepower, topspeed, width, height, weight)
    VALUES ('Model 3', 160, 340, 10, 10, 10);
INSERT INTO Aircraft(model, horsepower, topspeed, width, height, weight)
    VALUES ('Model 4', 140, 140, 10, 10, 10);

INSERT INTO Pilot(num, firstname, surname, nationality, birthday, name, model)
    VALUES('1', 'John', 'Doe', 'Portugues', '12-12-12', 'Equipa 1', 'Model 1');
INSERT INTO Pilot(num, firstname, surname, nationality, birthday, name, model)
    VALUES('2', 'Jonny', 'Doe', 'Portugues', '12-12-12', 'Equipa 2', 'Model 2');
INSERT INTO Pilot(num, firstname, surname, nationality, birthday, name, model)
    VALUES('3', 'Carl', 'Doe', 'Portugues', '12-12-12', 'Equipa 2', 'Model 3');

-- Falta completar o resto das tabelas