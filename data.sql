----------------------------------------
-- Jeu de données pour les tests
----------------------------------------

SET LINESIZE 160
SET ECHO ON

SPOOL data.out;

INSERT INTO SessionUniversitaire
VALUES(1, 'Hiver', 2016, SYSDATE)
/

INSERT INTO SessionUniversitaire
VALUES(2, 'Ete', 2016, SYSDATE)
/

INSERT INTO SessionUniversitaire
VALUES(3, 'Automne', 2016, SYSDATE)
/

INSERT INTO Departement
VALUES(1, 'Informatique')
/

INSERT INTO Departement
VALUES(2, 'Biologie')
/

INSERT INTO Departement
VALUES(3, 'Mathématique')
/

INSERT INTO Cours
VALUES(1, 'INF5180', 'Base de données', 1, 1)
/

INSERT INTO Cours
VALUES(2, 'INF5151', 'Modelisation', 1, 1)
/

INSERT INTO Cours
VALUES(3, 'INF7180', 'Base de données avancé', 2, 1)
/

INSERT INTO Cours
VALUES(4, 'INF9180', 'Base de données nucléaire', 3, 1)
/

INSERT INTO Cours
VALUES(5, 'BIO1111', 'Anatomie', 1, 2)
/

INSERT INTO Cours
VALUES(6, 'BIO3111', 'Anatomie II', 1, 2)
/

INSERT INTO Cours
VALUES(7, 'BIO7111', 'Anatomie avancé', 2, 2)
/

INSERT INTO Cours
VALUES(8, 'MAT1111', 'Calcul', 1, 3)
/

INSERT INTO Cours
VALUES(9, 'MAT3111', 'Calcul II', 1, 3)
/

INSERT INTO Cours
VALUES(10, 'MAT7111', 'Calcul avancé', 2, 3)
/

INSERT INTO Cours
VALUES(11, 'MAT9111', 'Calcul nucléaire', 3, 3)
/

INSERT INTO Employe
VALUES(1, 'AAAAAAAAAA_A', 'AAAAAAAA', 1)
/

INSERT INTO Employe
VALUES(2, 'BBBBBBBBBB_B', 'BBBBBBBB', 1)
/

INSERT INTO Employe
VALUES(3, 'CCCCCCCCCC_C', 'CCCCCCCC', 2)
/

INSERT INTO Employe
VALUES(4, 'DDDDDDDDDD_D', 'DDDDDDDD', 2)
/

INSERT INTO Employe
VALUES(5, 'EEEEEEEEEE_E', 'EEEEEEEE', 3)
/

INSERT INTO Employe
VALUES(6, 'FFFFFFFFFF_F', 'FFFFFFFF', 3)
/

INSERT INTO Enseignant
VALUES(1, 'Pitel', 'Frédéric', 1)
/

INSERT INTO Enseignant
VALUES(2, 'Blanchette', 'Patrick', 2)
/

INSERT INTO Enseignant
VALUES(3, 'Zakaib', 'Julien', 3)
/

INSERT INTO Enseignant
VALUES(4, 'Chieze', 'Emmanuel', 5)
/

INSERT INTO GroupeCours
VALUES(1, 10, 'Non', 'N', 1, 1, 1)
/

INSERT INTO GroupeCours
VALUES(2, 20, 'Non', 'N', 2, 1, 1)
/

INSERT INTO GroupeCours
VALUES(3, 10, 'Depart', 'N', NULL, 5, 2)
/

INSERT INTO GroupeCours
VALUES(4, 10, 'Traite', 'O', 4, 9, 3)
/

INSERT INTO Programme
VALUES(1, 7316, 'Génie Logiciel')
/

INSERT INTO Programme
VALUES(2, 7777, 'Génie Électrique')
/

INSERT INTO Programme
VALUES(3, 1111, 'Finances')
/

INSERT INTO Etudiant
VALUES(1, 'AAAA11111111', 'aaa', 'aaa', '11111', 0, SYSDATE, 1)
/

INSERT INTO Etudiant
VALUES(2, 'BBBB11111111', 'bbb', 'bbb', '22222', 3, SYSDATE, 1)
/

INSERT INTO Etudiant
VALUES(3, 'CCCC11111111', 'ccc', 'ccc', '33333', 0, SYSDATE, 1)
/

INSERT INTO Etudiant
VALUES(4, 'AAAA22222222', 'aaa', 'bbb', '11111', 0, SYSDATE, 2)
/

INSERT INTO Etudiant
VALUES(5, 'BBBB22222222', 'aaa', 'bbb', '11111', 0, SYSDATE, 2)
/

INSERT INTO Etudiant
VALUES(6, 'CCCC22222222', 'aaa', 'bbb', '11111', 0, SYSDATE, 2)
/

INSERT INTO Etudiant
VALUES(7, 'AAAA33333333', 'aaa', 'bbb', '11111', 0, SYSDATE, 3)
/

INSERT INTO Etudiant
VALUES(8, 'BBBB33333333', 'aaa', 'bbb', '11111', 0, SYSDATE, 3)
/

INSERT INTO Etudiant
VALUES(9, 'CCCC33333333', 'aaa', 'bbb', '11111', 0, SYSDATE, 3)
/

INSERT INTO StatutInscription
VALUES(1, 'IN', 'Inscrit')
/

INSERT INTO StatutInscription
VALUES(2, 'AB', 'Abandon')
/

INSERT INTO StatutInscription
VALUES(3, 'AE', 'Abandon sans échec')
/

INSERT INTO NoteLettree
VALUES(1, 'A+', 4.3)
/

INSERT INTO NoteLettree
VALUES(2, 'A', 4.0)
/

INSERT INTO NoteLettree
VALUES(3, 'A-', 3.7)
/

INSERT INTO NoteLettree
VALUES(4, 'B+', 3.3)
/

INSERT INTO NoteLettree
VALUES(5, 'B', 3.0)
/

INSERT INTO NoteLettree
VALUES(6, 'B-', 2.7)
/

INSERT INTO NoteLettree
VALUES(7, 'C+', 2.3)
/

INSERT INTO NoteLettree
VALUES(8, 'C', 2.0)
/

INSERT INTO NoteLettree
VALUES(9, 'C-', 1.7)
/

INSERT INTO NoteLettree
VALUES(10, 'D+', 1.3)
/

INSERT INTO NoteLettree
VALUES(11, 'D', 1.0)
/

INSERT INTO NoteLettree
VALUES(12, 'E', 0.0)
/

INSERT INTO InscriptionCours
VALUES(1, 1, 1, NULL, 1)
/

INSERT INTO InscriptionCours
VALUES(2, 1, 2, NULL, 1)
/

INSERT INTO InscriptionCours
VALUES(3, 1, 3, NULL, 2)
/

INSERT INTO InscriptionCours
VALUES(4, 2, 4, NULL, 3)
/

INSERT INTO InscriptionCours
VALUES(5, 1, 5, NULL, 4)
/

INSERT INTO Evaluation
VALUES(1, 'TP1', 25.00, 30.00, 'N', 1, 1)
/

INSERT INTO Evaluation
VALUES(2, 'TP2', 25.00, 30.00, 'N', 2, 1)
/

INSERT INTO Evaluation
VALUES(3, 'Intra', 25.00, 100.00, 'N', 3, 1)
/

INSERT INTO Evaluation
VALUES(4, 'Intra', 25.00, 100.00, 'N', 4, 1)
/

INSERT INTO Evaluation
VALUES(5, 'TP1', 15.00, 100.00, 'N', 1, 2)
/

INSERT INTO ResultatEvaluation
VALUES(1, 24.00, 1, 1)
/

INSERT INTO ResultatEvaluation
VALUES(2, 27.00, 1, 2)
/

INSERT INTO ResultatEvaluation
VALUES(3, 28.00, 2, 1)
/

INSERT INTO ResultatEvaluation
VALUES(4, 92.00, 1, 3)
/

INSERT INTO Borne
VALUES(1, 90.00, 1, 1)
/

INSERT INTO Borne
VALUES(2, 85.00, 1, 2)
/

INSERT INTO Borne
VALUES(3, 80.00, 1, 3)
/

INSERT INTO Borne
VALUES(4, 77.00, 1, 4)
/

INSERT INTO Borne
VALUES(5, 75.00, 1, 5)
/

INSERT INTO Borne
VALUES(6, 73.00, 1, 6)
/

INSERT INTO Borne
VALUES(7, 70.00, 1, 7)
/

INSERT INTO Borne
VALUES(8, 67.00, 1, 8)
/

INSERT INTO Borne
VALUES(9, 65.00, 1, 9)
/

INSERT INTO Borne
VALUES(10, 63.00, 1, 10)
/

INSERT INTO Borne
VALUES(11, 60.00, 1, 11)
/

INSERT INTO Borne
VALUES(12, 0.00, 1, 12)
/

COMMIT
/

SPOOL OFF;
SET ECHO OFF
SET PAGESIZE 30