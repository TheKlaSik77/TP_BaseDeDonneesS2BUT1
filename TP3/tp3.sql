---------------------------------------
-- Kylian Lasik
-- TP3
---------------------------------------

-- 1/
SELECT DISTINCT club.nom
FROM vac.club INNER JOIN vac.pers USING (ville);
/*
        nom        
-------------------
 Le nordiste
 Le vent marin
 Le fun nautique
 Le pavillon bleu
 Le soleil du midi
 Le sable fin
(6 rows)
*/
-- 2/
(SELECT club.nom
FROM vac.club
LIMIT 4)
UNION
(SELECT pers.nom
FROM vac.pers
WHERE pers.nom LIKE '%e');
/*
        nom        
-------------------
 Le fun nautique
 Le nordiste
 Alice
 Fabrice
 Pierre
 Marie
 Le pavillon bleu
 Le soleil du midi
 Lydie
(9 rows)
*/

-- 3/
SELECT club.nom
FROM vac.club
EXCEPT
SELECT club.nom
FROM vac.resa NATURAL JOIN vac.club;

/*
      nom      
---------------
 Le vent marin
(1 row)
*/

-- 4/
SELECT resa.idGrp
FROM vac.resa NATURAL JOIN vac.club
WHERE club.ville = 'Narbonne'
EXCEPT
SELECT resa.idGrp
FROM vac.resa NATURAL JOIN vac.club
WHERE club.ville <> 'Narbonne';

/*
 idgrp 
-------
   105
   102
   104
(3 rows)
*/

-- 5/
SELECT club.nom
FROM vac.resa NATURAL JOIN vac.club
GROUP BY club.nom
HAVING COUNT(*) >= 2;
/*
       nom        
------------------
 Le fun nautique
 Le pavillon bleu
(2 rows)
*/

-- 6/
SELECT pers.nom
FROM vac.pers
EXCEPT
SELECT pers.nom
FROM vac.pers NATURAL JOIN vac.GroupePers INNER JOIN vac.resa USING (idGrp)
WHERE idClub IN (
    SELECT resa.idClub
    FROM vac.resa NATURAL JOIN vac.GroupePers INNER JOIN vac.pers USING (idPers)
    WHERE pers.nom = 'Leila'
);

/*
   nom   
---------
 Bruno
 Fabrice
 Pierre
 Lydie
(4 rows)
*/

-- 7/
SELECT pers.nom
FROM vac.pers NATURAL JOIN vac.GroupePers INNER JOIN vac.resa USING (idgrp)
GROUP BY pers.nom
HAVING COUNT(*) > 1;
/*
  nom  
-------
 Farid
 Alice
 John
 Marie
(4 rows)
*/

-- 8/
SELECT r1.idGrp
FROM vac.resa r1 INNER JOIN vac.resa r2 ON r1.nbJour = r2.nbJour AND r1.mois = r2.mois
WHERE r1.idgrp > r2.idGrp;

-- 9/
SELECT resa.idGrp
FROM vac.resa NATURAL JOIN vac.club
GROUP BY resa.idgrp
HAVING COUNT(DISTINCT club.ville ) = (
    SELECT COUNT(DISTINCT club.ville)
    FROM vac.club
);

/*
 idgrp 
-------
   103
(1 row)
*/

-- 10/
SELECT DISTINCT pers.nom 
FROM vac.pers INNER JOIN vac.club USING (ville);
