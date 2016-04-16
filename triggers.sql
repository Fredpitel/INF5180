CREATE OR REPLACE TRIGGER BornesCoherentes
FOR INSERT OR UPDATE OF borneInferieure ON Borne
COMPOUND TRIGGER
  CURSOR 	cu_borne IS 
		SELECT borneInferieure, idNoteLettree
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
    
    IF(rt_borne.borneInferieure > :NEW.borneInferieure AND valeurNoteAutre < valeurNote)
    THEN RAISE_APPLICATION_ERROR(-20000, 'La valeur de la note lettrée d''une borne inférieure ne peut pas dépasser la valeur de la note lettrée d''une borne supérieure');
    END IF;
    
    IF(rt_borne.borneInferieure < :NEW.borneInferieure AND valeurNoteAutre > valeurNote)
    THEN RAISE_APPLICATION_ERROR(-20001, 'La valeur de la note lettrée d''une borne supérieure ne peut pas être plus basse que la valeur de la note lettrée d''une borne inférieure');
    END IF;
  END LOOP;
END BEFORE EACH ROW;
END BornesCoherentes;
/
SHOW ERR;


