CREATE OR REPLACE PROCEDURE generer_notes
  (v_idGroupeCours IN	GroupeCours.idGroupeCours%TYPE)
IS

  v_noteObtenue ResultatEvaluation.note%TYPE;
  v_notePonderee ResultatEvaluation.note%TYPE;
  v_valeurBorne Borne.borneInferieure%TYPE;
  v_lettreObtenue NoteLettree.idNoteLettree%TYPE;
  
BEGIN
  FOR inscription IN (SELECT idInscriptionCours
                      FROM InscriptionCours
                      WHERE idGroupeCours = v_idGroupeCours)
  LOOP
    v_notePonderee := 0;
    
    FOR evaluation IN (SELECT idEvaluation, noteMaximal, ponderation
                       FROM Evaluation
                       WHERE idGroupeCours = v_idGroupeCours)
    LOOP
      SELECT note INTO v_noteObtenue
      FROM ResultatEvaluation
      WHERE idInscriptionCours = inscription.idInscriptionCours
      AND idEvaluation = evaluation.idEvaluation;
      
      v_notePonderee := v_notePonderee + ((v_noteObtenue / evaluation.noteMaximal) * evaluation.ponderation);
    END LOOP;
    
    SELECT MAX(borneInferieure) INTO v_valeurBorne
    FROM Borne
    WHERE borneInferieure < v_notePonderee
    AND idGroupeCours = v_idGroupeCours;
    
    SELECT idNoteLettree INTO v_lettreObtenue
    FROM Borne
    WHERE idGroupeCours = v_idGroupeCours
    AND borneInferieure = v_valeurBorne;
                                         
    UPDATE InscriptionCours
		SET idNoteLettree = v_lettreObtenue
		WHERE idInscriptionCours = inscription.idInscriptionCours;
  END LOOP;
END;
/