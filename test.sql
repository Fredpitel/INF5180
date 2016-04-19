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

-- OK
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

-- NOK
INSERT INTO Evaluation
VALUES(1, 'TP1', 25.00, 30.00, 'N', 10, 4)
/

UPDATE GroupeCours
SET statutTransfertNote = 'Depart'
WHERE idGroupeCours = 1
/

UPDATE Evaluation
SET titre = 'TP3'
WHERE idGroupeCours = 1
AND idEvaluation = 1
/

ROLLBACK
/

-- Test trEvaluation_BDR_transfert
-- Empêche la modification des évaluations une fois les notes transférées

-- NOK
DELETE FROM Evaluation
WHERE idGroupeCours = 4
/

-- Test trEvaluation_BUS_idGrCours
-- Interdit la modification du groupe cours lié à une évaluation

-- NOK
UPDATE Evaluation
SET idGroupeCours = 2
WHERE idGroupeCours = 1
/

-- Test trInscriptionCours_BIR_doublon
-- Vérifie qu'un étudiant ne s'inscrit pas deux fois au même groupe-cours

-- NOK
INSERT INTO InscriptionCours
VALUES(1, 1, 1, 1, 1)
/

-- Test trInscriptionCours_BUS_idEtud
-- Interdit la modification de l'étudiant d'une inscription

-- NOK
UPDATE InscriptionCours
SET idEtudiant = 2
WHERE idEtudiant = 1
/

-- Test trInscripCours_BUIR_noteFinaleBorne
-- Vérifie que les bornes d'un groupe cours sont choisie avant de générer les notes finales

-- OK
INSERT INTO InscriptionCours
VALUES(1, 1, 6, 1, 1)
/

UPDATE InscriptionCours
SET idNoteLettree = 1
WHERE idInscriptionCours = 1
/

ROLLBACK
/

-- NOK
INSERT INTO InscriptionCours
VALUES(1, 1, 1, 2, 1)
/

UPDATE InscriptionCours
SET idNoteLettree = 1
WHERE idInscriptionCours = 5
/

-- Test trInscripCours_BUIR_noteFinalePond
-- Vérifie que la somme des pondérations des évaluations d'un groupe cours est égale à 100.00 avant de générer les notes finales

-- OK
INSERT INTO InscriptionCours
VALUES(1, 1, 6, 1, 1)
/

UPDATE InscriptionCours
SET idNoteLettree = 1
WHERE idInscriptionCours = 1
/

ROLLBACK
/

-- NOK
INSERT INTO InscriptionCours
VALUES(1, 1, 1, 2, 1)
/

UPDATE InscriptionCours
SET idNoteLettree = 1
WHERE idInscriptionCours = 5
/

-- Test trGrCours_BIUR_enseignantDep
-- Vérifie qu'un enseignant donne un cours de son département

-- OK
INSERT INTO GroupeCours
VALUES(5, 20, 'Non', 'N', 2, 7, 1)
/

UPDATE GroupeCours
SET idEnseignant = 2
WHERE idGroupeCours = 3
/

ROLLBACK
/

-- NOK
INSERT INTO GroupeCours
VALUES(5, 20, 'Non', 'N', 1, 7, 1)
/

UPDATE GroupeCours
SET idEnseignant = 1
WHERE idGroupeCours = 3
/

-- Test trGrCours_BUR_statTransNote
-- Vérifie que les notes finales d'un groupe cours sont générées avant d'être transférées ou diffusées

-- OK
CALL generer_notes(1)
/

UPDATE GroupeCours
SET statutTransfertNote = 'Depart'
WHERE idGroupeCours = 1
/

UPDATE GroupeCours
SET diffusionNoteFinale = 'O'
WHERE idGroupeCours = 1
/

ROLLBACK
/

-- NOK
UPDATE GroupeCours
SET statutTransfertNote = 'Depart'
WHERE idGroupeCours = 2
/

UPDATE GroupeCours
SET diffusionNoteFinale = 'O'
WHERE idGroupeCours = 2
/

-- Test trGrCours_BUS_idCours
-- Interdit la modification du cours lié à un groupe cours

-- NOK
UPDATE GroupeCours
SET idCours = 2
WHERE idGroupeCours = 1


-- Test trGrCours_BUS_idSession
-- Interdit la modification de la session liée à un groupe cours

-- NOK
UPDATE GroupeCours
SET idSessionUni = 2
WHERE idGroupeCours = 1

-- Test trResultatEval_BIUR_noteMax
-- Vérifie qu'un résultat d'évaluation ne dépasse pas la note maximale de cette évaluation

-- OK
INSERT INTO ResultatEvaluation
VALUES(5, 95.00, 1, 4)
/

UPDATE ResultatEvaluation
SET note = 100.00
WHERE idResultatEvaluation = 5
/

ROLLBACK
/

-- NOK
INSERT INTO ResultatEvaluation
VALUES(5, 95.00, 1, 1)
/

UPDATE ResultatEvaluation
SET note = 100.00
WHERE idResultatEvaluation = 1
/

-- Test trResultaEval_BIR_doublon
-- Vérifie qu'un étudiant ne recoit pas deux résulats pour la même évaluation

-- NOK

INSERT INTO ResultatEvaluation
VALUES(1, 26.00, 1, 1)
/

-- Test trResultatEval_BUS_idInscr
-- Interdit la modification de l'étudiant d'un résultat d'évaluation

-- NOK
UPDATE ResultatEvaluation
SET idInscriptionCours = 2
WHERE idResultatEvaluation = 1
/

-- Test trResultatEval_BUS_idEval
-- Interdit la modification de l'évaluation d'un résultat d'évaluation

-- NOK
UPDATE ResultatEvaluation
SET idEvaluation = 2
WHERE idResultatEvaluation = 1
/

-- Test trResultaEval_BIR_coursCoherent
-- Vérifie que l'étudiant concerné par le résultat d'évaluation est inscrit au groupe cours de l'évaluation

-- OK
INSERT INTO ResultatEvaluation
VALUES(1, 26.00, 2, 2)
/

ROLLBACK
/

-- NOK
INSERT INTO ResultatEvaluation
VALUES(1, 70.00, 1, 5)
/

-- Test trEnseignant_BUS_idEmploye
-- Interdit la modification de l'idEmploye lié à un enseignant

-- NOK
UPDATE Enseignant
SET idEmploye = 2
WHERE idEnseignant = 1
/

--------------------------------
-- Tests de la procédure stockée
--------------------------------

CALL generer_notes(1)
/

SELECT *
FROM InscriptionCours
WHERE idInscriptionCours = 1
/

SPOOL OFF;
SET ECHO OFF
SET PAGESIZE 30