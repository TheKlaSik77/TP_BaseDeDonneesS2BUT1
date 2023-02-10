-------------------
-- Kylian Lasik
-- TP 1
-------------------
-- Commande pour accéder à psql : sudo -u postgres psql si déjà un rôle : psql kylian_database

--------------
-- Exercice 1:
--------------
-- a)
DROP SCHEMA IF EXISTS etudes cascade;
CREATE SCHEMA etudes;

-- d)
CREATE TABLE etudes.univ (
        idEtud SERIAL,
        nomEtud VARCHAR(64),
        fraisScol INT,
        discipline VARCHAR(32),
        cours VARCHAR(32),
        cours2 VARCHAR(32),
        cours3 VARCHAR(32),
    CONSTRAINT pk_univ PRIMARY KEY (idEtud)
);

-- e)
INSERT INTO univ VALUES (DEFAULT,'Alice Dubois',200,'Economie','Economie1','Biologie1',NULL);
INSERT INTO univ VALUES (DEFAULT,'Bob Dupont',500,'Informatique','Biologie1','Intro Business','Programmation2');
INSERT INTO univ VALUES (DEFAULT,'Chris Durand',400,'Médecine','Biologie2',NULL,NULL);
INSERT INTO univ VALUES (DEFAULT,'Diana Duclos',850,'Dentaire',NULL,NULL,NULL);

-- On affiche avec : 
SELECT * 
FROM etudes.univ;

-- f)
INSERT INTO univ VALUES (DEFAULT,'Eliot Martin',0,NULL,NULL,NULL,NULL);

-- On affiche avec : 
SELECT * 
FROM etudes.univ;

-- g)
BEGIN;
UPDATE univ
SET cours = 'Intro Biologie'
WHERE cours = 'Biologie1';  

UPDATE univ
SET cours2 = 'Intro Biologie'
WHERE cours2 = 'Biologie1';

UPDATE univ
SET cours3 = 'Intro Biologie'
WHERE cours3 = 'Biologie1';

-- puis pour valider :
COMMIT;
-- Ou ROLLBACK; pour revenir en arrière

-- h)
BEGIN;
DELETE
FROM etudes.univ
WHERE nomEtud='Chris Durand';

COMMIT;

SELECT * 
FROM etudes.univ;

-- i)
/*
On constate que la conception de la table Univ n'est vraiment pas bonne car en supprimant un nom, on a supprimé d'autres données essentielles comme le cours biologie2, de plus en ajoutant un élève sur qui nous n'avons pas d'informations, la table va afficher énormément de cases qui vaudront NULL.
*/

---------------
-- Exercice 2 :
---------------

-- a)

DROP SCHEMA IF EXISTS etudiants cascade;
CREATE SCHEMA etudiants;

CREATE TABLE etudes.etudiants (

        nomEtud VARCHAR(32),
        fraisScol INT,
        dateNaiss DATE,
        cours1 VARCHAR(64),
        cours2 VARCHAR(64),
        cours3 VARCHAR(64),
        cours4 VARCHAR(64),
        nomProf VARCHAR(32),
        discipline VARCHAR(32)
);

-- b)

/*
L'attribut pourrait etre nomEtud mais c'est risqué car il ne faut pas qu'il y ait d'homonymes. Le meilleur choix serait le rajout d'un attribut id.
*/

-- c)
BEGIN;
ALTER TABLE etudes.etudiants
ADD idEtud SERIAL;

ALTER TABLE etudes.etudiants 
ADD CONSTRAINT pk_etudiants PRIMARY KEY (idEtud);

COMMIT;

-- d)
\d etudes.etudiants
/*
                                           Table "etudes.etudiants"
   Column   |         Type          | Collation | Nullable |                     Default                      
------------+-----------------------+-----------+----------+--------------------------------------------------
 nometud    | character varying(32) |           |          | 
 fraisscol  | integer               |           |          | 
 datenaiss  | date                  |           |          | 
 cours1     | character varying(64) |           |          | 
 cours2     | character varying(64) |           |          | 
 cours3     | character varying(64) |           |          | 
 cours4     | character varying(64) |           |          | 
 nomprof    | character varying(32) |           |          | 
 discipline | character varying(32) |           |          | 
 idetud     | integer               |           | not null | nextval('etudes.etudiants_idetud_seq'::regclass)
*/

-- e)
/*
Oui c'est en 1FN.
*/

-- f)
/*
Tous les attributs dépendent de idEtud.
*/

--------------
-- Exercice 3:
--------------

-- a)

BEGIN;
CREATE TABLE etudes.cours (
                idCours SERIAL,
                nomCours VARCHAR(64),
        CONSTRAINT pk_cours PRIMARY KEY (idCours)
);

COMMIT;

-- b)
BEGIN;
CREATE TABLE etudes.prof (
                idProf SERIAL,
                nomProf VARCHAR(32),
        CONSTRAINT pk_prof PRIMARY KEY (idProf)
);

ALTER TABLE etudes.etudiants DROP COLUMN nomProf;

COMMIT;

-- c)
BEGIN;
CREATE TABLE etudes.discipline (
                idDisc SERIAL,
                nomDisc VARCHAR(32),
        CONSTRAINT pk_discipline PRIMARY KEY (idDisc)
);

ALTER TABLE etudes.etudiants DROP COLUMN discipline;
COMMIT;

-- d)
\dt etudes.*

/*
          List of relations
 Schema |   Name    | Type  | Owner  
--------+-----------+-------+--------
 etudes | cours     | table | kylian
 etudes | etudiants | table | kylian
 etudes | prof      | table | kylian
 etudes | univ      | table | kylian
(4 rows)
*/

-- e)

\d etudes.etudiants

/*                                      
                  Table "etudes.etudiants"
  Column   |         Type          | Collation | Nullable |                     Default                      
-----------+-----------------------+-----------+----------+--------------------------------------------------
 nometud   | character varying(32) |           |          | 
 fraisscol | integer               |           |          | 
 datenaiss | date                  |           |          | 
 idetud    | integer               |           | not null | nextval('etudes.etudiants_idetud_seq'::regclass)
 */

 -- f)

BEGIN;
INSERT INTO etudes.etudiants VALUES ('Alice Dubois',200,'2001-08-04',DEFAULT);
INSERT INTO etudes.etudiants VALUES ('Bob Dupont',500,'2002-09-10',DEFAULT);
INSERT INTO etudes.etudiants VALUES ('Chris Durand',400,'2001-01-13',DEFAULT);
INSERT INTO etudes.etudiants VALUES ('Diana Duclos',850,'2002-04-25',DEFAULT);

INSERT INTO etudes.discipline VALUES (DEFAULT,'Economie');
INSERT INTO etudes.discipline VALUES (DEFAULT,'Informatique');
INSERT INTO etudes.discipline VALUES (DEFAULT,'Médecine');
INSERT INTO etudes.discipline VALUES (DEFAULT,'Dentaire');

INSERT INTO etudes.prof VALUES (DEFAULT,'Jean Parleur');
INSERT INTO etudes.prof VALUES (DEFAULT,'Sarah Format');
INSERT INTO etudes.prof VALUES (DEFAULT,'Luc Auteur');


INSERT INTO etudes.cours VALUES (DEFAULT,'Economie1 (Business)');
INSERT INTO etudes.cours VALUES (DEFAULT,'Biologie1 (Sciences)');
INSERT INTO etudes.cours VALUES (DEFAULT,'Biologie2 (Sciences)');
INSERT INTO etudes.cours VALUES (DEFAULT,'Intro Business (Business)');
INSERT INTO etudes.cours VALUES (DEFAULT,'Programmation2 (NTIC)');

/* 
On remarque qu'il y a beaucoup de tables pour peu d'informations et qu'il n'y a pas de liens entre les tables.
*/


-- g)

BEGIN;

ALTER TABLE etudes.etudiants
ADD idDisc INT;

ALTER TABLE etudes.etudiants 
ADD CONSTRAINT fk_etudiants_discipline FOREIGN KEY (idDisc) REFERENCES etudes.discipline (idDisc);


ALTER TABLE etudes.discipline
ADD idEnseignant INT;

ALTER TABLE etudes.discipline 
ADD CONSTRAINT fk_discipline_prof FOREIGN KEY (idEnseignant) REFERENCES etudes.prof (idProf);


CREATE TABLE etudes.suitCours (
                idEtud INT,
                idCours INT,
        
        CONSTRAINT pk_suitCours PRIMARY KEY (idEtud,idDisc),
        CONSTRAINT fk_suitCours_etudiants FOREIGN KEY (idEtud) REFERENCES etudes.etudiants (idEtud),
        CONSTRAINT fk_suitCours_cours FOREIGN KEY (idCours) REFERENCES etudes.discipline (idCours)
);

-- h) 
/*
Dans la décomposition de la table intiale en 2FN, on a idEtud et idDisc qui détermine toutes les autres tables.
*/

-- Exercice 4 :


-- b) 

SELECT *
FROM etudes.cours INNER JOIN etudes.suitCours USING(idCours) INNER JOIN etudes.etudiants USING (idEtud) INNER JOIN etudes.discipline USING (idDisc) INNER JOIN etudes.prof ON discipline.idEnseignant=prof.idProf;

-- c)

/*
Non car toutes les tables sont déterminées par idDisc et idEtud
*/
