CREATE OR REPLACE generer_notes(
	v_id_groupe_cours IN	GroupeCours.idGroupeCours%TYPE) 
AS

	TYPE table_evaluations IS TABLE OF Evaluation%ROWTYPE;

	evaluations_groupe_cours	table_evaluations;

	CURSOR curseur_inscriptions_cours IS
		SELECT * 
		FROM InscriptionCours
		WHERE idGroupeCours = v_id_groupe_cours;

	-- 
	-- Variables locales de la procédure
	-- 
	v_note_finale		NUMBER(5,2);
	v_note_evaluation	ResulatatEvaluation.note%TYPE;
	v_ponderation		Evaluation.v_ponderation%TYPE;
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
	FOR inscription_cours IN curseur_inscriptions_cours
	LOOP

		v_note_finale := 0;

		-- 
		-- Itérer sur les évaluations pour ce GroupeCours
		-- 
		FOR index IN 1 .. evaluations_groupe_cours.COUNT 
		LOOP

			evaluation := evaluations_groupe_cours(index);
			v_id_evaluation := evaluation.idEvaluation;
			v_ponderation := evaluation.v_ponderation;

			-- 
			-- Récupérer la colonne `note` de l'inscription `inscription_cours`
			-- pour l'évaluation courante `v_id_evaluation`
			-- 
			SELECT note INTO v_note_evaluation 
			FROM ResultatEvaluation AS resultat JOIN InscriptionCours AS inscription
			ON resultat.idInscriptionCours = inscription.idInscriptionCours
			WHERE inscription.idEtudiant = inscription_cours.idEtudiant 
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
		UPDATE InscriptionCours as inscription
		SET inscription.idNoteLettree = v_id_note_lettree
		WHERE inscription.idInscriptionCours = inscription_cours.idInscriptionCours
		AND inscription.idGroupeCours = v_id_groupe_cours;

	END LOOP;

END;
