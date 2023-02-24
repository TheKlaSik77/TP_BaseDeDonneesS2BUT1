-- Création de tables sans contraintes
DROP SCHEMA IF EXISTS vac CASCADE;
CREATE SCHEMA vac;

DROP TABLE IF EXISTS Club, Pers, Groupe, GroupePers, Resa; 

CREATE TABLE Club (
   idClub INTEGER, 
   nom VARCHAR(30),
   ville VARCHAR(30),
   etoile INTEGER,
   capacite INTEGER,

   CONSTRAINT pk_club PRIMARY KEY (idClub)
);

CREATE TABLE Pers (
   idPers INTEGER  , 
   nom VARCHAR(30),
   age INTEGER,
   ville VARCHAR(30),
   CONSTRAINT pk_pers PRIMARY KEY (idPers)
);

CREATE TABLE Groupe (
   idGrp INTEGER,
   activite VARCHAR(30),
   CONSTRAINT pk_groupe PRIMARY KEY (idGrp)
);

CREATE TABLE GroupePers (
   idGrp INTEGER ,
   idPers INTEGER,
   CONSTRAINT fk_groupepers_groupe FOREIGN KEY (idGrp) REFERENCES vac.Groupe (idGrp),
   CONSTRAINT fk_groupepers_pers FOREIGN KEY (idPers) REFERENCES vac.Pers (idPers),
   CONSTRAINT pk_groupepers PRIMARY KEY (idGrp,idPers)
);

CREATE TABLE Resa (
   idGrp INTEGER,
   idClub INTEGER,
   nbJour INTEGER,
   mois VARCHAR(30),
   CONSTRAINT fk_resa_groupe FOREIGN KEY (idGrp) REFERENCES vac.Groupe (idGrp),
   CONSTRAINT fk_resa_club FOREIGN KEY (idClub) REFERENCES vac.Club (idClub),
   CONSTRAINT pk_resa PRIMARY KEY (idGrp,idClub)
);


INSERT INTO Pers VALUES (20, 'John' , 50, 'Narbonne'); 
INSERT INTO Pers VALUES (21, 'Leila' , 30, 'Narbonne'); 
INSERT INTO Pers VALUES (22, 'Fabrice' , 18, 'Lille'); 
INSERT INTO Pers VALUES (23, 'Alice' , 15, 'Narbonne'); 
INSERT INTO Pers VALUES (24, 'Marie' , 17, 'Toulon'); 
INSERT INTO Pers VALUES (25, 'Farid' , 48, 'Toulon'); 
INSERT INTO Pers VALUES (26, 'Pierre' , 60, 'Lille'); 
INSERT INTO Pers VALUES (27, 'Lydie' , 38, 'Montreuil'); 
INSERT INTO Pers VALUES (28, 'Bruno' , 33, 'Nice');

INSERT INTO Club VALUES(31,'Le soleil du midi', 'Narbonne', 4, 100);
INSERT INTO Club VALUES(32,'Le pavillon bleu', 'Narbonne', 4, 150);
INSERT INTO Club VALUES(33,'Le fun nautique', 'Narbonne', 5, 60);
INSERT INTO Club VALUES(34,'Le nordiste', 'Lille', 4, 150);
INSERT INTO Club VALUES(35,'Le vent marin', 'Toulon', 3, 100);
INSERT INTO Club VALUES(36,'Le sable fin', 'Toulon', 5, 110);

INSERT INTO Groupe VALUES(101,'Randonnée');
INSERT INTO Groupe VALUES(102,'Baignade');
INSERT INTO Groupe VALUES(103,'Pêche');
INSERT INTO Groupe VALUES(104,'Cyclisme');
INSERT INTO Groupe VALUES(105,'Pétanque');

INSERT INTO GroupePers VALUES(101,20);
INSERT INTO GroupePers VALUES(101,26);
INSERT INTO GroupePers VALUES(102,20);
INSERT INTO GroupePers VALUES(102,21);
INSERT INTO GroupePers VALUES(102,23);
INSERT INTO GroupePers VALUES(103,24);
INSERT INTO GroupePers VALUES(103,25);
INSERT INTO GroupePers VALUES(104,22);
INSERT INTO GroupePers VALUES(104,23);
INSERT INTO GroupePers VALUES(104,24);
INSERT INTO GroupePers VALUES(105,20);

INSERT INTO Resa VALUES(102, 33, 3, 'mai');
INSERT INTO Resa VALUES(105, 31, 3, 'juin');
INSERT INTO Resa VALUES(105, 32, 2, 'avril');
INSERT INTO Resa VALUES(103, 36, 2, 'avril');
INSERT INTO Resa VALUES(103, 34, 4, 'mai');
INSERT INTO Resa VALUES(103, 33, 3, 'juin');
INSERT INTO Resa VALUES(104, 32, 3, 'juin');