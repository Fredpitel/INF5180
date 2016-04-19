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
VALUES(1, 'aaa1111', 'testOk1', 1, 1)
/
ROLLBACK
/

INSERT INTO Cours
VALUES(1, 'AAA1111', 'testOk2', 1, 1)
/
ROLLBACK
/

INSERT INTO Cours
VALUES(1, 'aAA1111', 'testOk3', 1, 1)
/
ROLLBACK
/

-- NOK

INSERT INTO Cours
VALUES(1, 'aa1111', 'testNok1', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaaa1111', 'testNok2', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaa111', 'testNok3', 1, 1)
/

INSERT INTO Cours
VALUES(1, 'aaa11111', 'testNok4', 1, 1)
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
VALUES(1, '1111', 'TestOk1')
/
ROLLBACK
/

-- NOK

INSERT INTO Programme
VALUES(1, '111', 'TestNok1')
/

INSERT INTO Programme
VALUES(1, '11111', 'TestNok1')
/