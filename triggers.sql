---------------------------------------------------------------------------
-- Vérifie la cohérence des valeurs entrées comme bornes
---------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trBorne_CIU_borneCoherentes
FOR INSERT OR UPDATE OF borneInferieure ON Borne
COMPOUND TRIGGER
  CURSOR 	cu_borne IS 
		SELECT borneInferieure, idGroupeCours, idNoteLettree
		FROM Borne;
  valeurNote  NoteLettree.valeur%TYPE;
  valeurNoteAutre NoteLettree.valeur%TYPE;
BEFORE EACH ROW IS
BEGIN
  SELECT valeur INTO valeurNote
  FROM NoteLettree
  WHERE idNoteLettree = :NEW.idNoteLettree;

  FOR rt_borne IN cu_borne
  LOOP
    SELECT valeur INTO valeurNoteAutre
    FROM NoteLettree
    WHERE idNoteLettree = rt_borne.idNoteLettree;
    
    IF(rt_borne.borneInferieure > :NEW.borneInferieure AND valeurNoteAutre < valeurNote AND rt_borne.idGroupeCours = :NEW.idGroupeCours)
    THEN RAISE_APPLICATION_ERROR(-20000, 'La valeur de la note lettrée d''une borne inférieure ne peut pas dépasser la valeur de la note lettrée d''une borne supérieure.');
    END IF;
    
    IF(rt_borne.borneInferieure < :NEW.borneInferieure AND valeurNoteAutre > valeurNote AND rt_borne.idGroupeCours = :NEW.idGroupeCours)
    THEN RAISE_APPLICATION_ERROR(-20001, 'La valeur de la note lettrée d''une borne supérieure ne peut pas être plus basse que la valeur de la note lettrée d''une borne inférieure.');
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
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE ordreMax Evaluation.ordreApparition%TYPE;
BEGIN
  SELECT MAX(ordreApparition) INTO  ordreMax
  FROM Evaluation
  WHERE idGroupeCours = :ligneApres.idGroupeCours;
  
  IF(ordreMax IS NULL)
  THEN   :ligneApres.ordreApparition := 1;
  ELSE   :ligneApres.ordreApparition := ordreMax + 1;
  END IF;
  
END trEvaluation_BIR_ordreEval;
/

-----------------------------------------------------------------------------------------------
-- Vérifie qu'un étudiant ne s'inscrit pas deux fois au même groupe-cours
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BIR_doublon
BEFORE INSERT ON InscriptionCours
FOR EACH ROW
DECLARE idEtud Etudiant.idEtudiant%TYPE;
BEGIN
  SELECT idEtudiant INTO idEtud
  FROM InscriptionCours
  WHERE idEtudiant = :NEW.idEtudiant
  AND idGroupeCours = :NEW.idGroupeCours;
  
  IF(idEtud IS NOT NULL)
  THEN RAISE_APPLICATION_ERROR(-20002, 'Un étudiant ne peut s''inscrire plus d''une fois au même groupe cours.');
  END IF;
END trInscriptionCours_BIR_doublon;
/

------------------------------------------------------------------------
-- Interdit la modification de l'étudiant d'une inscription
------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER  trInscriptionCours_BUS_idEtud
BEFORE UPDATE OF idEtudiant ON InscriptionCours
BEGIN
RAISE_APPLICATION_ERROR(-20003, 'Il est interdit de modifier l''étudiant lié à une inscription, veuillez la supprimer et créer une inscription différente.');
END trInscriptionCours_BIR_doublon;
/
  
  