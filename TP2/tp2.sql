-----------------------------------------------
-- Kylian Lasik
-- TP 2
------------------------------------------------

-- PARTIE 1

-- 1) & 2)

DROP SCHEMA IF EXISTS vac CASCADE;
CREATE SCHEMA vac;

DROP TABLE IF EXISTS Club, Pers, Groupe, GroupePers, Resa; 

CREATE TABLE Club (
   idClub INTEGER, 
   nom VARCHAR(30),
   ville VARCHAR(30),
   etoile INTEGER,
   capacite INTEGER
);

CREATE TABLE Pers (
   idPers INTEGER  , 
   nom VARCHAR(30),
   age INTEGER,
   ville VARCHAR(30) 
);

CREATE TABLE Groupe (
   idGrp INTEGER,
   activite VARCHAR(30) 
);

CREATE TABLE GroupePers (
   idGrp INTEGER ,
   idPers INTEGER 
);

CREATE TABLE Resa (
   idGrp INTEGER,
   idClub INTEGER,
   nbJour INTEGER,
   mois VARCHAR(30)
);

-- 3)
INSERT INTO Pers VALUES (20, 'John' , 50, 'Narbonne'); 
INSERT INTO Pers VALUES (21, 'Leila' , 30, 'Narbonne'); 
INSERT INTO Pers VALUES (22, 'Fabrice' , 18, 'Lille'); 
INSERT INTO Pers VALUES (23, 'Alice' , 15, 'Narbonne'); 
INSERT INTO Pers VALUES (24, 'Marie' , 17, 'Toulon'); 
INSERT INTO Pers VALUES (25, 'Farid' , 48, 'Toulon'); 
INSERT INTO Pers VALUES (26, 'Pierre' , 60, 'Lille'); 
INSERT INTO Pers VALUES (27, 'Lydie' , 38, 'Montreuil'); 


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

-- PARTIE 2

-- 1.
INSERT INTO Pers VALUES (28, 'Bruno' , 33, 'Nice');

-- 2.
SELECT nom FROM vac.Club NATURAL JOIN vac.Resa WHERE club.etoile >= 3 AND resa.nbJour <= 4 AND resa.mois = 'juin';

-- 3.
SELECT Pers.nom FROM vac.Pers NATURAL JOIN vac.GroupePers INNER JOIN vac.Resa USING (idGrp) WHERE Resa.nbJour >= 4; 

-- 4.
SELECT Pers.nom FROM vac.Pers NATURAL JOIN vac.GroupePers INNER JOIN vac.Resa USING (idGrp) INNER JOIN vac.Club USING (idClub) WHERE Club.nom like '%soleil%';

-- 5.
SELECT mois,count(idPers) FROM vac.Pers NATURAL JOIN vac.GroupePers INNER JOIN vac.Resa USING (idGrp) GROUP BY mois;

-- 6.
UPDATE vac.Pers
SET nom = 'Anna', age = 49, ville = 'Bordeaux'
WHERE idPers = 28;

-- 7.
SELECT pers.ville, avg(pers.age) FROM vac.pers GROUP BY Pers.ville HAVING count(*) >= 2; 

-- 8.
SELECT club.nom,resa.mois FROM vac.club LEFT JOIN vac.resa USING (idClub);