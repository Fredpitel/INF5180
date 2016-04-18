---------------------------------------------
-- Triggers associés aux séquences
---------------------------------------------

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

------------------------------------------------------------
-- Empêche la modification des clés primaires
------------------------------------------------------------

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

-------------------------------------------------------------------------------------------
-- Garantie que ParametresGeneraux contient une et une seule entrée
--------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trParamGen_BIS_unique
BEFORE INSERT ON ParametresGeneraux
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'Il est interdit d''insérer de nouvelles valeurs dans cette table. ');
END trParamGen_BIS_unique;
/

CREATE OR REPLACE TRIGGER trParamGen_BDS_unique
BEFORE DELETE ON ParametresGeneraux
BEGIN
  RAISE_APPLICATION_ERROR(-20002, 'Il est interdit de supprimer les valeurs dans cette table. ');
END trParamGen_BDS_unique;
/

---------------------------------------------------------------------------
-- Vérifie la cohérence des valeurs entrées comme bornes
---------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trBorne_CIU_borneCoherentes
FOR INSERT OR UPDATE OF borneInferieure ON Borne
COMPOUND TRIGGER
  CURSOR 	cu_borne IS 
		SELECT borneInferieure, idGroupeCours, idNoteLettree
		FROM Borne;
  v_valeurNote  NoteLettree.valeur%TYPE;
  v_valeurNoteAutre NoteLettree.valeur%TYPE;
BEFORE EACH ROW IS
BEGIN
  SELECT valeur INTO v_valeurNote
  FROM NoteLettree
  WHERE idNoteLettree = :NEW.idNoteLettree;

  FOR rt_borne IN cu_borne
  LOOP
    SELECT valeur INTO v_valeurNoteAutre
    FROM NoteLettree
    WHERE idNoteLettree = rt_borne.idNoteLettree;
    
    IF(rt_borne.borneInferieure > :NEW.borneInferieure AND v_valeurNoteAutre < v_valeurNote AND rt_borne.idGroupeCours = :NEW.idGroupeCours)
    THEN RAISE_APPLICATION_ERROR(-20003, 'La valeur de la note lettrée d''une borne inférieure ne peut pas dépasser la valeur de la note lettrée d''une borne supérieure.');
    END IF;
    
    IF(rt_borne.borneInferieure < :NEW.borneInferieure AND v_valeurNoteAutre > v_valeurNote AND rt_borne.idGroupeCours = :NEW.idGroupeCours)
    THEN RAISE_APPLICATION_ERROR(-20004, 'La valeur de la note lettrée d''une borne supérieure ne peut pas être plus basse que la valeur de la note lettrée d''une borne inférieure.');
    END IF;
    
    IF(rt_borne.borneInferieure = :NEW.borneInferieure AND rt_borne.idGroupeCours = :NEW.idGroupeCours)
    THEN RAISE_APPLICATION_ERROR(-20005, 'Une borne de cette valeur existe déjà pour ce cours.');
    END IF;
  END LOOP;
END BEFORE EACH ROW;
END trBorne_CIU_borneCoherentes;
/

-----------------------------------------------------------
-- Force l'ordre d'apparition lors de l'insertion
-----------------------------------------------------------

CREATE OR REPLACE TRIGGER trEvaluation_BIR_ordreEval
BEFORE INSERT ON Evaluation
FOR EACH ROW
DECLARE v_ordreMax Evaluation.ordreApparition%TYPE;
BEGIN
  SELECT MAX(ordreApparition) INTO  v_ordreMax
  FROM Evaluation
  WHERE idGroupeCours = :NEW.idGroupeCours;
  
  IF(v_ordreMax IS NULL)
  THEN   :NEW.ordreApparition := 1;
  ELSE   :NEW.ordreApparition := v_ordreMax + 1;
  END IF;
  
END trEvaluation_BIR_ordreEval;
/

-----------------------------------------------------------------------------------------------
-- Vérifie qu'un étudiant ne s'inscrit pas deux fois au même groupe-cours
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BIR_doublon
BEFORE INSERT ON InscriptionCours
FOR EACH ROW
DECLARE v_idEtud Etudiant.idEtudiant%TYPE;
BEGIN
  SELECT idEtudiant INTO v_idEtud
  FROM InscriptionCours
  WHERE idEtudiant = :NEW.idEtudiant
  AND idGroupeCours = :NEW.idGroupeCours;
  
  RAISE_APPLICATION_ERROR(-20006, 'Un étudiant ne peut s''inscrire plus d''une fois au même groupe cours.');

  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END trInscriptionCours_BIR_doublon;
/

------------------------------------------------------------------------
-- Interdit la modification de l'étudiant d'une inscription
------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BUS_idEtud
BEFORE UPDATE OF idEtudiant ON InscriptionCours
BEGIN
  RAISE_APPLICATION_ERROR(-20007, 'Il est interdit de modifier l''étudiant lié à une inscription, veuillez la supprimer et créer une inscription différente.');
END trInscriptionCours_BIR_doublon;
/

----------------------------------------------------------------------------------
-- Vérifie qu'un enseignant donne un cours de son département
----------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trGrCours_BIUR_enseignantDep
BEFORE INSERT OR UPDATE OF idEnseignant ON GroupeCours
FOR EACH ROW
DECLARE
  v_idEmploye Enseignant.idEmploye%TYPE;
  v_depCours Cours.idDepartement%TYPE;
  v_depEnseignant Cours.idDepartement%TYPE;
BEGIN
  SELECT idDepartement INTO v_depCours
  FROM Cours
  WHERE idCours = :NEW.idCours;
  
  SELECT idEmploye INTO v_idEmploye
  FROM Enseignant
  WHERE idEnseignant = :NEW.idEnseignant;
  
  SELECT idDepartement INTO v_depEnseignant
  FROM Employe
  WHERE idEmploye = v_idEmploye;

  IF(v_depCours <> v_depEnseignant)
  THEN RAISE_APPLICATION_ERROR(-20008, 'Un enseignant doit donner un cours rattaché à son département.');
  END IF;
END trGrCours_BIUR_enseignantDep;
/
