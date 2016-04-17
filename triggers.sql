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
  
  IF(ordreMax IS NULL)
  THEN   :ligneApres.ordreApparition := 1;
  ELSE   :ligneApres.ordreApparition := ordreMax + 1;
  END IF;
  
END ordreEvalInsert;
/
SHOW ERR;