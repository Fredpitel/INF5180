----------------------------------
-- Triggers associés aux séquences
----------------------------------

CREATE OR REPLACE TRIGGER trSessionUni_BIR_PK
BEFORE INSERT ON SessionUniversitaire
FOR EACH ROW
BEGIN
	:NEW.idSessionUni := seqSessionUniversitaire.nextval;
END;
/

CREATE OR REPLACE TRIGGER trDepartement_BIR_PK
BEFORE INSERT ON Departement
FOR EACH ROW
BEGIN
	:NEW.idDepartement := seqDepartement.nextval;
END;
/

CREATE OR REPLACE TRIGGER trCours_BIR_PK
BEFORE INSERT ON Cours
FOR EACH ROW
BEGIN
	:NEW.idCours := seqCours.nextval;
END;
/

CREATE OR REPLACE TRIGGER trEmploye_BIR_PK
BEFORE INSERT ON Employe
FOR EACH ROW
BEGIN
	:NEW.idEmploye := seqEmploye.nextval;
END;
/

CREATE OR REPLACE TRIGGER trEnseignant_BIR_PK
BEFORE INSERT ON Enseignant
FOR EACH ROW
BEGIN
	:NEW.idEnseignant := seqEnseignant.nextval;
END;
/

CREATE OR REPLACE TRIGGER trGroupeCours_BIR_PK
BEFORE INSERT ON GroupeCours
FOR EACH ROW
BEGIN
	:NEW.idGroupeCours := seqGroupeCours.nextval;
END;
/

CREATE OR REPLACE TRIGGER trProgramme_BIR_PK
BEFORE INSERT ON Programme
FOR EACH ROW
BEGIN
	:NEW.idProgramme := seqProgramme.nextval;
END;
/

CREATE OR REPLACE TRIGGER trEtudiant_BIR_PK
BEFORE INSERT ON Etudiant
FOR EACH ROW
BEGIN
	:NEW.idEtudiant := seqEtudiant.nextval;
END;
/

CREATE OR REPLACE TRIGGER trStatutInscription_BIR_PK
BEFORE INSERT ON StatutInscription
FOR EACH ROW
BEGIN
	:NEW.idStatutInscription := seqStatutInscription.nextval;
END;
/

CREATE OR REPLACE TRIGGER trNoteLettree_BIR_PK
BEFORE INSERT ON NoteLettree
FOR EACH ROW
BEGIN
	:NEW.idNoteLettree := seqNoteLettree.nextval;
END;
/

CREATE OR REPLACE TRIGGER trInscriptionCours_BIR_PK
BEFORE INSERT ON InscriptionCours
FOR EACH ROW
BEGIN
	:NEW.idInscriptionCours := seqInscriptionCours.nextval;
END;
/

CREATE OR REPLACE TRIGGER trEvaluation_BIR_PK
BEFORE INSERT ON Evaluation
FOR EACH ROW
BEGIN
	:NEW.idEvaluation := seqEvaluation.nextval;
END;
/

CREATE OR REPLACE TRIGGER trResultatEvaluation_BIR_PK
BEFORE INSERT ON ResultatEvaluation
FOR EACH ROW
BEGIN
	:NEW.ididResultatEval := seqResultatEvaluation.nextval;
END;
/

CREATE OR REPLACE TRIGGER trBorne_BIR_PK
BEFORE INSERT ON Borne
FOR EACH ROW
BEGIN
	:NEW.idBorne := seqBorne.nextval;
END;
/

---------------------------------------------
-- Empêche la modification des clés primaires
---------------------------------------------

CREATE OR REPLACE TRIGGER trSessionUni_BUR_PK
BEFORE UPDATE OF idSessionUni ON SessionUniversitaire
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trDepartement_BUR_PK
BEFORE UPDATE OF idDepartement ON Departement
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trCours_BUR_PK
BEFORE UPDATE OF idCours ON Cours
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trEmploye_BUR_PK
BEFORE UPDATE OF idEmploye ON Employe
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trEnseignant_BUR_PK
BEFORE UPDATE OF idEnseignant ON Enseignant
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trGroupeCours_BUR_PK
BEFORE UPDATE OF idGroupeCours ON GroupeCours
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trProgramme_BUR_PK
BEFORE UPDATE OF idProgramme ON Programme
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trEtudiant_BUR_PK
BEFORE UPDATE OF idEtudiant ON Etudiant
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trStatutInscription_BUR_PK
BEFORE UPDATE OF idStatutInscription ON StatutInscription
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trNoteLettree_BUR_PK
BEFORE UPDATE OF idNoteLettree ON NoteLettree
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trInscriptionCours_BUR_PK
BEFORE UPDATE OF idInscriptionCours ON InscriptionCours
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trEtudiant_BUR_PK
BEFORE UPDATE OF idEtudiant ON Etudiant
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trEvaluation_BUR_PK
BEFORE UPDATE OF idEvaluation ON Evaluation
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trResultatEvaluation_BUR_PK
BEFORE UPDATE OF idResultatEval ON ResultatEvaluation
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

CREATE OR REPLACE TRIGGER trBorne_BUR_PK
BEFORE UPDATE OF idBorne ON Borne
FOR EACH ROW
BEGIN
	RAISE_APPLICATION_ERROR (-20000, 'Il est interdit de modifier la cle primaire d''une table');
END;
/

-------------------------------------------------------------------
-- Garantie que ParametresGeneraux contient une et une seule entrée
-------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trParamGen_BIS_unique
BEFORE INSERT ON ParametresGeneraux
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'Il est interdit d''insérer de nouvelles valeurs dans cette table.');
END trParamGen_BIS_unique;
/

CREATE OR REPLACE TRIGGER trParamGen_BDS_unique
BEFORE DELETE ON ParametresGeneraux
BEGIN
  RAISE_APPLICATION_ERROR(-20002, 'Il est interdit de supprimer les valeurs dans cette table.');
END trParamGen_BDS_unique;
/

--------------------------------------------------------
-- Vérifie la cohérence des valeurs entrées comme bornes
--------------------------------------------------------

CREATE OR REPLACE TRIGGER trBorne_BIUR_borneCoherentes
BEFORE INSERT OR UPDATE OF borneInferieure ON Borne
FOR EACH ROW
DECLARE
  v_valeurNote  NoteLettree.valeur%TYPE;
  v_valeurNoteAutre NoteLettree.valeur%TYPE;
BEGIN
  SELECT valeur INTO v_valeurNote
  FROM NoteLettree
  WHERE idNoteLettree = :NEW.idNoteLettree;
  
  FOR borne IN (SELECT borneInferieure, idNoteLettree
                FROM Borne
                WHERE idGroupeCours = :NEW.idGroupeCours)
  LOOP
    SELECT valeur INTO v_valeurNoteAutre
    FROM NoteLettree
    WHERE idNoteLettree = borne.idNoteLettree;
    
    IF(borne.borneInferieure > :NEW.borneInferieure AND v_valeurNoteAutre < v_valeurNote)
    THEN RAISE_APPLICATION_ERROR(-20003, 'La valeur de la note lettrée d''une borne inférieure ne peut pas dépasser la valeur de la note lettrée d''une borne supérieure.');
    END IF;
    
    IF(borne.borneInferieure < :NEW.borneInferieure AND v_valeurNoteAutre > v_valeurNote)
    THEN RAISE_APPLICATION_ERROR(-20004, 'La valeur de la note lettrée d''une borne supérieure ne peut pas être plus basse que la valeur de la note lettrée d''une borne inférieure.');
    END IF;
    
    IF(borne.borneInferieure = :NEW.borneInferieure)
    THEN RAISE_APPLICATION_ERROR(-20005, 'Une borne de cette valeur existe déjà pour ce cours.');
    END IF;
	 
	 IF(v_valeurNoteAutre = v_valeurNote)
	 THEN RAISE_APPLICATION_ERROR(-20006, 'Cette note lettrée déjà été attribuée à une borne pour ce groupe cours.');
    END IF;
  END LOOP;
END trBorne_BIUR_borneCoherentes;
/

-----------------------------------------------------------
-- Interdit la modification du groupe cours lié à une borne
-----------------------------------------------------------

CREATE OR REPLACE TRIGGER  trBorne_BUS_idGrCours
BEFORE UPDATE OF idGroupeCours ON Borne
BEGIN
  RAISE_APPLICATION_ERROR(-20007, 'Il est interdit de modifier le groupe cours lié à une borne, veuillez la supprimer et créer une borne différente.');
END trBorne_BUS_idGrCours;
/

---------------------------------------------------------------
-- Interdit la modification de la note lettrée liée à une borne
---------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trBorne_BUS_idNoteLettree
BEFORE UPDATE OF idNoteLettree ON Borne
BEGIN
  RAISE_APPLICATION_ERROR(-20008, 'Il est interdit de modifier la note lettrée liée à une borne, veuillez la supprimer et créer une borne différente.');
END trBorne_BUS_idNoteLettree;
/

-------------------------------------------------------------------------------
-- Vérifie que la note lettrée peut être utiliser pour un cours selon son cycle
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trBorne_BIR_cycle
BEFORE INSERT ON Borne
FOR EACH ROW
DECLARE
  v_cycle Cours.cycleUni%TYPE;
  v_lettre NoteLettree.lettre%TYPE;
BEGIN
  SELECT cycleUni INTO v_cycle
  FROM Cours NATURAL JOIN GroupeCours
  WHERE GroupeCours.idCours = Cours.idCours;
  
  SELECT lettre INTO v_lettre
  FROM NoteLettree
  WHERE idNoteLettree = :NEW.idNoteLettree;
  
  IF(v_cycle > 1 AND (v_lettre = 'C-' OR v_lettre = 'D+' OR v_lettre = 'D'))
  THEN RAISE_APPLICATION_ERROR(-20009, 'Il est interdit d''attribuer la note lettre "C-", "D+" ou "D" pour ce cours.');
  END IF;
END trBorne_BIR_cycle;
/

-----------------------------------------------------------------------------------------------
-- Vérifie que la somme des pondérations des évaluations d'un groupe cous ne dépasse pas 100.00
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trEvaluation_BUIR_ponderation
FOR INSERT OR UPDATE OF ponderation ON Evaluation
COMPOUND TRIGGER
  TYPE 	ttab_sommePonderation IS 
		TABLE OF Evaluation.ponderation%TYPE INDEX BY BINARY_INTEGER;
  CURSOR cu_evaluation IS SELECT SUM(ponderation) AS sommePonderation, idGroupeCours
                          FROM Evaluation
                          GROUP BY idGroupeCours;
  tab_sommePonderation ttab_sommePonderation;
BEFORE STATEMENT IS
BEGIN
  	FOR rt_enreg IN cu_evaluation 
   LOOP
      tab_sommePonderation(rt_enreg.idGroupeCours) := rt_enreg.sommePonderation;
	END LOOP;
END BEFORE STATEMENT;
BEFORE EACH ROW IS                                               
BEGIN
  IF(tab_sommePonderation(:NEW.idGroupeCours) + :NEW.ponderation > 100.00)
  THEN RAISE_APPLICATION_ERROR(-20010, 'La somme des pondérations des évaluations d''un groupe cours ne peut pas dépasser 100.00');
  END IF;
END BEFORE EACH ROW;
END trEvaluation_BUIR_ponderation;
/

------------------------------------------------------------------
-- Force l'ordre d'apparition lors de l'insertion d'une évaluation
------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trEvaluation_BIR_ordreEval
BEFORE INSERT ON Evaluation
FOR EACH ROW
DECLARE v_ordreMax Evaluation.ordreApparition%TYPE;
BEGIN
  SELECT MAX(ordreApparition) INTO v_ordreMax
  FROM Evaluation
  WHERE idGroupeCours = :NEW.idGroupeCours;
  
  IF(v_ordreMax IS NULL)
  THEN   :NEW.ordreApparition := 1;
  ELSE   :NEW.ordreApparition := v_ordreMax + 1;
  END IF;
  
END trEvaluation_BIR_ordreEval;
/

-------------------------------------------------------------------------
-- Empêche la modification des évaluations une fois les notes transférées
-------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trEvaluation_BIUR_transfert
BEFORE INSERT OR UPDATE ON Evaluation
FOR EACH ROW
DECLARE 
  v_statut GroupeCours.statutTransfertNote%TYPE;
BEGIN
  SELECT statutTransfertNote INTO v_statut
  FROM GroupeCours
  WHERE idGroupeCours = :NEW.idGroupeCours;
  
  IF(v_statut <> 'Non')
  THEN RAISE_APPLICATION_ERROR(-20011, 'Il est interdit de modifier les évaluations une fois qu''elles ont étés transférées.');
  END IF;
END trEvaluation_BIUR_transfert;
/

CREATE OR REPLACE TRIGGER trEvaluation_BDR_transfert
BEFORE DELETE ON Evaluation
FOR EACH ROW
DECLARE 
  v_statut GroupeCours.statutTransfertNote%TYPE;
BEGIN
  SELECT statutTransfertNote INTO v_statut
  FROM GroupeCours
  WHERE idGroupeCours = :OLD.idGroupeCours;
  
  IF(v_statut <> 'Non')
  THEN RAISE_APPLICATION_ERROR(-20011, 'Il est interdit de modifier les évaluations une fois qu''elles ont étés transférées.');
  END IF;
END trEvaluation_BDR_transfert;
/

----------------------------------------------------------------
-- Interdit la modification du groupe cours lié à une évaluation
----------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trEvaluation_BUS_idGrCours
BEFORE UPDATE OF idGroupeCours ON Evaluation
BEGIN
  RAISE_APPLICATION_ERROR(-20012, 'Il est interdit de modifier le groupe cours lié à une évaluation, veuillez la supprimer et créer une évaluation différente.');
END trEvaluation_BUS_idGrCours;
/

-------------------------------------------------------------------------
-- Vérifie qu'un étudiant ne s'inscrit pas deux fois au même groupe-cours
-------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BIR_doublon
BEFORE INSERT ON InscriptionCours
FOR EACH ROW
DECLARE v_idEtud Etudiant.idEtudiant%TYPE;
BEGIN
  SELECT idEtudiant INTO v_idEtud
  FROM InscriptionCours
  WHERE idEtudiant = :NEW.idEtudiant
  AND idGroupeCours = :NEW.idGroupeCours;
  
  RAISE_APPLICATION_ERROR(-20013, 'Un étudiant ne peut s''inscrire plus d''une fois au même groupe cours.');

  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END trInscriptionCours_BIR_doublon;
/

-----------------------------------------------------------
-- Interdit la modification de l'étudiant d'une inscription
-----------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BUS_idEtud
BEFORE UPDATE OF idEtudiant ON InscriptionCours
BEGIN
  RAISE_APPLICATION_ERROR(-20014, 'Il est interdit de modifier l''étudiant lié à une inscription, veuillez la supprimer et créer une inscription différente.');
END trInscriptionCours_BUS_idEtud;
/

-------------------------------------------------------------------------------------------
-- Vérifie que les bornes d'un groupe cours sont choisie avant de générer les notes finales
-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trInscripCours_BUIR_noteFinaleBorne
BEFORE INSERT OR UPDATE OF idNoteLettree ON InscriptionCours
FOR EACH ROW
DECLARE 
  v_borneMin Borne.borneInferieure%TYPE;
  v_nombreBorne INTEGER;
  v_cycle Cours.cycleUni%TYPE;
BEGIN
  IF(:NEW.idNoteLettree IS NOT NULL)
	  SELECT COUNT(idBorne) INTO v_nombreBorne
	  FROM Borne
	  WHERE idGroupeCours = :NEW.idGroupeCours;
	  
	  SELECT cycleUni INTO v_cycle
	  FROM Cours NATURAL JOIN GroupeCours
	  WHERE GroupeCours.idCours = Cours.idCours;
	  
	  IF((v_cycle = 1 AND v_nombreBorne <> 12) OR (v_cycle > 1 AND v_nombreBorne <> 9))
	  THEN THEN RAISE_APPLICATION_ERROR(-20015, 'Vous ne pouvez générer les notes finales sans avoir choisi toutes les bornes pour ce groupe cours au préalable.');
	  END IF;
	  
	  SELECT MIN(borneInferieure) INTO v_borneMin
	  FROM Borne
	  WHERE idGroupeCours = :NEW.idGroupeCours;
	  
	  IF(v_borneMin <> 0.00)
	  THEN RAISE_APPLICATION_ERROR(-20016, 'Les bornes choisies ne couvrent pas l''ensemble des notes possibles.');
	  END IF;
	END IF;
END trInscripCours_BUIR_noteFinaleBorne;
/

--------------------------------------------------------------------------------------------------------------------------------
-- Vérifie que la somme des pondérations des évaluations d'un groupe cours est égale à 100.00 avant de générer les notes finales
--------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trInscripCours_BUIR_noteFinalePond
BEFORE INSERT OR UPDATE OF idNoteLettree ON InscriptionCours
FOR EACH ROW
DECLARE v_sommePonderation Evaluation.ponderation%TYPE;
BEGIN
  SELECT SUM(ponderation) INTO v_sommePonderation
  FROM Evaluation
  WHERE idGroupeCours = :NEW.idGroupeCours;
  
  IF(v_sommePonderation <> 100.00)
  THEN RAISE_APPLICATION_ERROR(-20017, 'Impossible de générer la note finale car la somme des pondérations des évaluations pour ce groupe cours n''atteint pas 100.00.');
  END IF;
  
  EXCEPTION WHEN NO_DATA_FOUND
  THEN RAISE_APPLICATION_ERROR(-20017, 'Impossible de générer la note finale car la somme des pondérations des évaluations pour ce groupe cours n''atteint pas 100.00.');
END trInscripCours_BUIR_noteFinalePond;

-------------------------------------------------------------
-- Vérifie qu'un enseignant donne un cours de son département
-------------------------------------------------------------

CREATE OR REPLACE TRIGGER trGrCours_BIUR_enseignantDep
BEFORE INSERT OR UPDATE OF idEnseignant ON GroupeCours
FOR EACH ROW
DECLARE
  v_idEmploye Enseignant.idEmploye%TYPE;
  v_depEnseignant Cours.idDepartement%TYPE;
BEGIN
  SELECT idDepartement INTO v_depCours
  FROM Cours
  WHERE idCours = :NEW.idCours;
  
  SELECT idDepartement INTO v_depEnseignant
  FROM Employe NATURAL JOIN Enseignant
  WHERE Employe.idEmploye = Enseignant.idEmploye;

  IF(v_depCours <> v_depEnseignant)
  THEN RAISE_APPLICATION_ERROR(-20018, 'Un enseignant doit donner un cours rattaché à son département.');
  END IF;
END trGrCours_BIUR_enseignantDep;
/

------------------------------------------------------------------------------------------------------
-- Vérifie que les notes finales d'un groupe cours sont générées avant d'être transférées ou diffusées
------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trGrCours_BUR_statTransNote
BEFORE UPDATE OF statutTransfertNote OR diffusionNoteFinale ON GroupeCours
FOR EACH ROW
BEGIN
  IF(:NEW.statutTransfertNote <> 'Non' OR :NEW.diffusionNoteFinale <> 'N')
  THEN
    FOR note IN (SELECT idNoteLettree
                 FROM InscriptionCours
                 WHERE idGroupeCours = :NEW.idGroupeCours)
    LOOP
      IF(note.idNoteLettree IS NULL)
      THEN RAISE_APPLICATION_ERROR(-20019, 'Les notes finales d''un groupe cours doivent être générées avant d''être transférées ou diffusées.');
      END IF;
    END LOOP;
  END IF;
END trGrCours_BUR_statTransNote;
/

----------------------------------------------------------
-- Interdit la modification du cours lié à un groupe cours
----------------------------------------------------------

CREATE OR REPLACE TRIGGER  trGrCours_BUS_idCours
BEFORE UPDATE OF idCours ON GroupeCours
BEGIN
  RAISE_APPLICATION_ERROR(-20020, 'Il est interdit de modifier le lié à un groupe cours, veuillez le supprimer et créer un groupe cours différent.');
END trGrCours_BUS_idCours;
/

----------------------------------------------------------------
-- Interdit la modification de la session liée à un groupe cours
----------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trGrCours_BUS_idSession
BEFORE UPDATE OF idSessionUni ON GroupeCours
BEGIN
  RAISE_APPLICATION_ERROR(-20021, 'Il est interdit de modifier la session liée à un groupe cours, veuillez le supprimer et créer un groupe cours différent.');
END trGrCours_BUS_idSession;
/

------------------------------------------------------------------------------------------
-- Vérifie qu'un résultat d'évaluation ne dépasse pas la note maximale de cette évaluation
------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trResultatEval_BIUR_noteMax
BEFORE INSERT OR UPDATE OF note ON ResultatEvaluation
FOR EACH ROW
DECLARE
v_noteMax Evaluation.noteMaximal%TYPE;
BEGIN
  SELECT noteMaximal INTO v_noteMax
  FROM Evaluation
  WHERE idEvaluation = :NEW.idEvaluation;
  
  IF(:NEW.note > v_noteMax)
  THEN RAISE_APPLICATION_ERROR(-20022, 'La note entrée dépasse la note maximale pour cette évaluation.');
  END IF;
END trResultatEval_BIUR_noteMax;
/

-----------------------------------------------------------------------------
-- Vérifie qu'un étudiant ne recoit pas deux résulats pour la même évaluation
-----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trResultaEval_BIR_doublon
BEFORE INSERT ON ResultatEvaluation
FOR EACH ROW
DECLARE v_idInscription InscriptionCours.idInscriptionCours%TYPE;
BEGIN
  SELECT idInscriptionCours INTO v_idInscription
  FROM ResultatEvaluation
  WHERE idInscriptionCours = :NEW.idInscriptionCours
  AND idGroupeCours = :NEW.idGroupeCours;
  
  RAISE_APPLICATION_ERROR(-20023, 'Cet étudiant a déjà un résultat pour cette évalutation.');

  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END trResultaEval_BIR_doublon;
/

--------------------------------------------------------------------
-- Interdit la modification de l'étudiant d'un résultat d'évaluation
--------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trResultatEval_BUS_idInscr
BEFORE UPDATE OF idInscriptionCours ON ResultatEvaluation
BEGIN
  RAISE_APPLICATION_ERROR(-20024, 'Il est interdit de modifier l''étudiant lié à un résultat d''évaluation, veuillez le supprimer et créer un résultat différent.');
END trResultatEval_BUS_idInscr;
/

----------------------------------------------------------------------
-- Interdit la modification de l'évaluation d'un résultat d'évaluation
----------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trResultatEval_BUS_idEval
BEFORE UPDATE OF idEvaluation ON ResultatEvaluation
BEGIN
  RAISE_APPLICATION_ERROR(-20025, 'Il est interdit de modifier l''évaluation liée à un résultat d''évaluation, veuillez le supprimer et créer un résultat différent.');
END trResultatEval_BUS_idEval;
/

-----------------------------------------------------------------------------------------------------------
-- Vérifie que l'étudiant concerné par le résultat d'évaluation est inscrit au groupe cours de l'évaluation
-----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trResultaEval_BIR_coursCoherent
BEFORE INSERT ON ResultatEvaluation
FOR EACH ROW
DECLARE 
  v_idGrCoursInscr GroupeCours.idGroupeCours%TYPE;
  v_idGrCoursEval Evaluation.idGroupeCours%TYPE;
BEGIN
  SELECT idGroupeCours INTO v_idGrCoursInscr
  FROM InscriptionCours
  WHERE idInscriptionCours = :NEW.idInscriptionCours;

  SELECT idGroupeCours INTO v_idGrCoursEval
  FROM Evaluation
  WHERE idEvaluation = :NEW.idEvaluation;
  
  IF(v_idGrCoursInscr <> v_idGrCoursEval)
  THEN RAISE_APPLICATION_ERROR(-20026, 'Cet étudiant n''est pas inscrit à ce groupe cours.');
  END IF;
END trResultaEval_BIR_coursCoherent;

--------------------------------------------------------------
-- Interdit la modification de l'idEmploye lié à un enseignant
--------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trEnseignant_BUS_idEmploye
BEFORE UPDATE OF idEmploye ON Enseignant
BEGIN
  RAISE_APPLICATION_ERROR(-20027, 'Il est interdit de modifier l''employé lié à un enseignant, veuillez le supprimer et créer un enseignant différent.');
END trEnseignant_BUS_idEmploye;
/