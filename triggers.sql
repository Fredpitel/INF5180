---------------------------------------------------------------------------
-- Vérifie la cohérence des valeurs entrées comme bornes
---------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER BornesCoherentes
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
END BornesCoherentes;
/

---------------------------------------------------------------------------------------------------------------------------------
-- Vérifie que la somme des pondérations des évaluations d'un groupe-cours ne dépasse pas 100.00
---------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER PonderationMax
FOR INSERT OR UPDATE OF ponderation ON Evaluation
COMPOUND TRIGGER
  v_sommePonderation  Evaluation.ponderation%TYPE;
BEFORE EACH ROW IS
BEGIN
  SELECT SUM(ponderation) INTO v_sommePonderation
  FROM Evaluation
  WHERE idGroupeCours = :NEW.idGroupeCours;
  
  IF(v_sommePonderation > 100.00)
  THEN RAISE_APPLICATION_ERROR(-20002, 'La somme des pondérations de évaluations ne peut pas dépasser 100.00.');
  END IF;
END BEFORE EACH ROW;
END PonderationMax;
/

-----------------------------------------------------------
-- Force l'ordre d'apparition lors de l'insertion
-----------------------------------------------------------

CREATE OR REPLACE TRIGGER ordreEvalInsert
BEFORE INSERT ON Evaluation
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE ordreMax Evaluation.ordreApparition%TYPE;
BEGIN
  SELECT MAX(ordreApparition) INTO  ordreMax
  FROM Evaluation
  WHERE idGroupeCours = :ligneApres.idGroupeCours;
  
  :ligneApres.ordreApparition := ordreMax + 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN 
    :ligneApres.ordreApparition := 1;
END ordreEvalInsert;
/

-----------------------------------------------------------------------
-- Interchange l'ordre d'apparition de deux évaluations
-----------------------------------------------------------------------

CREATE OR REPLACE TRIGGER ordreEvalUpdate
BEFORE UPDATE ON Evaluation
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE 
  evalModifie Evaluation.idEvaluation%TYPE;
  ordrePrecedent Evaluation.ordreApparition%TYPE;
BEGIN
  SELECT idEvaluation INTO evalModifie
  FROM Evaluation
  WHERE ordreApparition = :ligneApres.ordreApparition
  AND idGroupeCours = :ligneApres.idGroupeCours;

  SELECT ordreApparition INTO  ordrePrecedent
  FROM Evaluation
  WHERE ordreApparition = :ligneApres.ordreApparition
  AND idGroupeCours = :ligneApres.idGroupeCours;
  
  UPDATE Evaluation
  SET ordreApparition = :ligneApres.ordreApparition
  WHERE idEvaluation = evalModifie;
  
  :ligneApres.ordreApparition := ordrePrecedent;
EXCEPTION WHEN NO_DATA_FOUND THEN 
   RAISE_APPLICATION_ERROR(-20003, 'Impossible d''affecter cet ordre d''apparition à cette évaluation.');
END ordreEvalUpdate;
/

