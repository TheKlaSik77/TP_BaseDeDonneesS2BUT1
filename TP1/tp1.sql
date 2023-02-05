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
