-----------------------------------------------------------
-- Tests du système, voir résultats des tests dans test.out
-----------------------------------------------------------

SET LINESIZE 160
SET ECHO ON

SPOOL test.out;

-------------------------------------------------------------------
-- Tests des contraintes CHECK utilisant des expressions régulières
-------------------------------------------------------------------

-- Test ck_Cours_sigle
-- Vérifie la structure des sigle de cours: 3 lettres majuscules ou minuscules non accentuées suivies de 4 nombres

-- OK

INSERT INTO Cours
VALUES(1, 'aaa1234', 'testOk1', 1, 1)
/
ROLLBACK
/

INSERT INTO Cours
VALUES(1, 'AAA1234', 'testOk2', 1, 1)
/
ROLLBACK
/

INSERT INTO Cours
VALUES(1, 'aAA1234', 'testOk3', 1, 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Cours
VALUES(1, 'aa1234', 'testNok1', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaaa1234', 'testNok2', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaa123', 'testNok3', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaa12345', 'testNok4', 1, 1)
/

-- Test ck_Employe_codeMS
-- Vérifie la structure des codeMS d'employés: 10 lettres majuscules non accentuées suivies d'un souligné suivi d'une lettre majuscule non accentuée
-- OK

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '12345678', 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '12345678', 1)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAAAA_A', '12345678', 1)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAAA_', '12345678', 1)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAAA_AA', '12345678', 1)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAAAA', '12345678', 1)
/

-- Test ck_Employe_motDePasse
-- Vérifie la structure des mots de passe d'employés: 8 caractères alphanumériques non accentués

-- OK

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '12345678', 1)
/
ROLLBACK
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', 'aaaaaaaa', 1)
/
ROLLBACK
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', 'AAAAAAAA', 1)
/
ROLLBACK
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '1234AAaa', 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '1234567', 1)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAA_A', '123456789', 1)
/

-- Test ck_Programme_codeProg
-- Vérifie la structure des codes de programmes: 4 nombres

-- OK

INSERT INTO Programme
VALUES(1, '1234', 'TestOk1')
/
ROLLBACK
/

-- NOK

INSERT INTO Programme
VALUES(1, '123', 'TestNok1')
/

INSERT INTO Programme
VALUES(1, '12345', 'TestNok1')
/

-- Test ck_Etudiant_codePermanent
-- Vérifie la structure des codes permanents d'étudiants: 4 lettres majuscules non accentuées suivies de 8 nombres

-- OK

INSERT INTO Etudiant
VALUES(1, 'AAAA12345678', 'Test', 'Ok1', '12345', 0, 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Etudiant
VALUES(1, 'aAAA12345678', 'Test', 'Nok1', '12345', 0, 1)
/

INSERT INTO Etudiant
VALUES(1, 'AAA12345678', 'Test', 'Nok2', '12345', 0, 1)
/

INSERT INTO Etudiant
VALUES(1, 'AAAAA12345678', 'Test', 'Nok3', '12345', 0, 1)
/

INSERT INTO Etudiant
VALUES(1, 'AAAAA1234567', 'Test', 'Nok4', '12345', 0, 1)
/

INSERT INTO Etudiant
VALUES(1, 'AAAAA123456789', 'Test', 'Nok5', '12345', 0, 1)
/

-- Test ck_Etudiant_nip
-- Vérifie la structure des nips d'étudiants: 5 nombres

-- OK

INSERT INTO Etudiant
VALUES(1, 'AAAA12345678', 'Test', 'Ok1', '12345', 0, 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Etudiant
VALUES(1, 'AAAA12345678', 'Test', 'Nok1', '1234', 0, 1)
/

INSERT INTO Etudiant
VALUES(1, 'AAAA12345678', 'Test', 'Nok2', '123456', 0, 1)
/

-- Les expressions régulières utilisées dans les CHECK de la table InterfaceRegistrariat sont les mêmes que dans les tables Etudiant et Cours respectivement et donc déjà testées.


---------------------
-- Tests des triggers
---------------------

-- Test trSessionUni_BUR_PK et tous les autres triggers similaires
-- Empêche la modification des clés primaires

-- NOK

UPDATE SessionUniversitaire
SET idSessionUni = 99
WHERE idSessionUni = 10
/

-- Test trParamGen_BIS_unique
-- Garantie que ParametresGeneraux contient une et une seule entrée

-- NOK

INSERT INTO ParametresGeneraux
VALUES(2,1)
/

-- Test trParamGen_BDS_unique
-- Garantie que ParametresGeneraux contient une et une seule entrée

-- NOK

DELETE FROM ParametresGeneraux
WHERE nbTentativeMax = 1
/

-- Test trBorne_BIUR_borneCoherentes
-- Vérifie la cohérence des valeurs entrées comme bornes

-- OK

-- A+ = 95.00, A = 94.99
INSERT INTO Borne
VALUES(1, 95.00, 2, 1)
/

INSERT INTO Borne
VALUES(1, 94.99, 2, 2)
/

ROLLBACK
/

-- NOK
-- A+ = 90.00, A = 95.00
INSERT INTO Borne
VALUES(1, 90.00, 2, 1)
/

INSERT INTO Borne
VALUES(1, 95.00, 2, 2)
/

UPDATE Borne
SET borneInferieure = 95.00
WHERE idNoteLettree = 2
AND idGroupeCours = 1
/

ROLLBACK
/

-- A = 85.00, A+ = 80.00
INSERT INTO Borne
VALUES(1, 85.00, 2, 2)
/

INSERT INTO Borne
VALUES(1, 80.00, 2, 1)
/

UPDATE Borne
SET borneInferieure = 80.00
WHERE idNoteLettree = 1
AND idGroupeCours = 1
/

ROLLBACK
/

-- A+ = 90.00, A = 90.00
INSERT INTO Borne
VALUES(1, 90.00, 2, 1)
/

INSERT INTO Borne
VALUES(1, 90.00, 2, 2)
/

UPDATE Borne
SET borneInferieure = 90.00
WHERE idNoteLettree = 2
AND idGroupeCours = 1
/

ROLLBACK
/

-- A+ = 90.00, A+ = 95.00
INSERT INTO Borne
VALUES(1, 95.00, 1, 1)
/

-- Test trBorne_BUS_idGrCours
-- Interdit la modification du groupe cours lié à une borne

-- NOK

UPDATE Borne
SET idGroupeCours = 2
WHERE idBorne = 1
/

-- Test trBorne_BUS_idNoteLettree
-- Interdit la modification de la note lettrée liée à une borne

-- NOK

UPDATE Borne
SET idNoteLettree = 2
WHERE idBorne = 1
/

-- Test trBorne_BIR_cycle
-- Vérifie que la note lettrée peut être utiliser pour un cours selon son cycle

-- OK
-- Cyle = 1, Lettre = D
INSERT INTO Borne
VALUES(1, 60.00, 11, 2)
/ 

-- Cyle = 2, Lettre = C
INSERT INTO Borne
VALUES(1, 60.00, 8, 3)
/

ROLLBACK
/

-- NOK

-- Cyle = 2, Lettre = D
INSERT INTO Borne
VALUES(1, 60.00, 11, 3)
/

-- Test trEvaluation_BUIR_ponderation
-- Vérifie que la somme des pondérations des évaluations d'un groupe cous ne dépasse pas 100.00

-- OK

INSERT INTO Evaluation
VALUES(1, 'TP1', 25.00, 30.00, 'N', 1, 3)
/

INSERT INTO Evaluation
VALUES(1, 'TP2', 25.00, 30.00, 'N', 1, 3)
/

INSERT INTO Evaluation
VALUES(1, 'Intra', 49.99, 100.00, 'N', 1, 3)
/

-- NOK
INSERT INTO Evaluation
VALUES(1, 'Final', 5.00, 100.00, 'N', 1, 3)
/

UPDATE Evaluation
SET ponderation = 50.00
WHERE ponderation = 49.99
AND idGroupeCours = 3
/

ROLLBACK
/

-- Test trEvaluation_BIR_ordreEval
-- Force l'ordre d'apparition lors de l'insertion d'une évaluation

-- Ordre 10, 25, 99
INSERT INTO Evaluation
VALUES(1, 'TP1', 25.00, 30.00, 'N', 10, 3)
/

INSERT INTO Evaluation
VALUES(1, 'TP2', 25.00, 30.00, 'N', 25, 3)
/

INSERT INTO Evaluation
VALUES(1, 'Intra', 30.00, 100.00, 'N', 99, 3)
/

SELECT *
FROM Evaluation
WHERE idGroupeCours = 3
/

ROLLBACK
/

-- Test trEvaluation_BIUR_transfert
-- Empêche la modification des évaluations une fois les notes transférées

