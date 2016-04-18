CREATE OR REPLACE PROCEDURE generer_notes(
	v_id_groupe_cours IN	GroupeCours.idGroupeCours%TYPE) 
AS
	TYPE table_evaluations IS TABLE OF Evaluation%ROWTYPE;

	evaluations_groupe_cours	table_evaluations;

	CURSOR cu_inscriptions_cours IS
		SELECT * 
		FROM InscriptionCours
		WHERE idGroupeCours = v_id_groupe_cours;

	-- 
	-- Variables locales de la procédure
	-- 
	v_note_finale		NUMBER(5,2);
	v_note_evaluation	ResultatEvaluation.note%TYPE;
	v_ponderation		Evaluation.ponderation%TYPE;
	v_id_evaluation		Evaluation.idEvaluation%TYPE;
	v_id_note_lettree	Borne.idNoteLettree%TYPE;

	evaluation 			Evaluation%ROWTYPE;

BEGIN

	-- 
	-- Créer une collection des Evaluations pour le GroupeCours
	--
	SELECT *
	BULK COLLECT INTO evaluations_groupe_cours
	FROM Evaluation 
	WHERE idGroupeCours = v_id_groupe_cours;

	-- 
	-- Itérer sur les inscriptions du GroupeCours `v_id_groupe_cours`
	-- 
	FOR inscription_cours IN cu_inscriptions_cours
	LOOP

		v_note_finale := 0;

		-- 
		-- Itérer sur les évaluations pour ce GroupeCours
		-- 
		FOR i IN 1 .. evaluations_groupe_cours.COUNT 
		LOOP

			evaluation := evaluations_groupe_cours(i);
			v_id_evaluation := evaluation.idEvaluation;
			v_ponderation := evaluation.v_ponderation;

			-- 
			-- Récupérer la colonne `note` de l'inscription `inscription_cours`
			-- pour l'évaluation courante `v_id_evaluation`
			-- 
			SELECT note INTO v_note_evaluation 
			FROM ResultatEvaluation JOIN InscriptionCours
			ON ResultatEvaluation.idInscriptionCours = InscriptionCours.idInscriptionCours
			WHERE InscriptionCours.idEtudiant = inscription_cours.idEtudiant 
			AND	resultat.idEvaluation = v_id_evaluation;

			-- `v_ponderation` est la valeur (ratio sur 100) de l'évaluation courante
			-- `note` est le résultat de l'évalution (ratio sur 100) pour l'inscription cours
			v_note_finale := v_note_finale + ((100 / v_ponderation) * v_note_evaluation);

		END LOOP;

		-- 
		-- Récupérer le `idNoteLettree` de la Borne de ce GroupeCours pour
		-- laquelle la `borneInferieure` est la plus grande (ordre décroissant)
		-- et plus petite ou égal à la note finale obtenue par l'étudiant.
		-- 
		SELECT idNoteLettree INTO v_id_note_lettree FROM (
			SELECT idNoteLettree from Borne
			WHERE Borne.idGroupeCours = v_id_groupe_cours 
			AND	Borne.borneInferieure <= v_note_finale
			ORDER BY borneInferieure DESC
		) 
		WHERE rownum = 1;

		-- Mettre à jour la note finale pour l'inscription
		UPDATE InscriptionCours
		SET InscriptionCours.idNoteLettree = v_id_note_lettree
		WHERE InscriptionCours.idInscriptionCours = inscription_cours.idInscriptionCours
		AND InscriptionCours.idGroupeCours = v_id_groupe_cours;

	END LOOP;

END;
/
SHOW ERR;
