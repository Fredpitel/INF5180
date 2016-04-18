----------------------------------------
-- Cas d'utilisation : L' Étudiant consulte la page de diffusion des résultats
--
-- Affichage de l’entête
--
-- SELECT
--	Etudiant.nom,
-- 	Etudiant.prenom,
-- 	Cours.sigle,
-- 	Cours.titre,
-- 	GroupeCours.noGroupe,
-- 	SessionUniversitaire.saison,
-- 	SessionUniversitaire.annee,
-- 	Enseignant.nom,
-- 	Enseignant.prenom,
-- 	Etudiant.codePermanent,
-- 	Programme.titre,
-- 	Programme.codeProgramme
-- FROM
-- 	InscriptionCours
-- 	INNER JOIN Etudiant ON InscriptionCours.idEtudiant = Etudiant.idEtudiant
-- 	INNER JOIN Programme ON Etudiant.idProgramme = Programme.idProgramme
-- 	INNER JOIN GroupeCours ON InscriptionCours.idGroupeCours = GroupeCours.idGroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Enseignant ON InscriptionCours.idEnseignant = Enseignant.idEnseignant
-- WHERE
-- 	Etudiant.codePermanent = 'BLAP201186' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016
-- /
--
-- Affichage des résultats d'un étudiant pour chaque évaluation
--
-- SELECT
--	Evaluation.titre,
--	ResultatEvaluation.note,
--	Evaluation.noteMaximal
-- FROM
--	InscriptionCours
-- 	INNER JOIN Etudiant ON InscriptionCours.idEtudiant = Etudiant.idEtudiant
-- 	INNER JOIN GroupeCours ON InscriptionCours.idGroupeCours = GroupeCours.idGroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
-- 	INNER JOIN ResultatEvaluation ON InscriptionCours.idInscriptionCours = ResultatEvaluation.idInscriptionCours
-- WHERE
-- 	Etudiant.codePermanent = 'BLAP201186' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016 AND
--	Evaluation.statusDiffusion = 'O'
-- ORDER BY Evaluation.ordreApparition
-- /
--
-- Affichage des statistiques pour chaque évaluation
--
-- SELECT
--	Evaluation.titre,
--	AVG(ResultatEvaluation.note) AS moyenneEval,
--	STDDEV(ResultatEvaluation.note) AS ecartTypeEval
-- FROM
-- 	GroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
-- 	INNER JOIN ResultatEvaluation ON InscriptionCours.idInscriptionCours = ResultatEvaluation.idInscriptionCours
-- WHERE
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016 AND
--	Evaluation.statusDiffusion = 'O'
-- ORDER BY Evaluation.ordreApparition
-- /
--
-- Affichage note final pondéré
--
-- SELECT
--	SUM(ResultatEvaluation.note / Evaluation.noteMaximal * Evaluation.ponderation / 100) AS notePondere,
-- FROM
--	InscriptionCours
-- 	INNER JOIN Etudiant ON InscriptionCours.idEtudiant = Etudiant.idEtudiant
-- 	INNER JOIN GroupeCours ON InscriptionCours.idGroupeCours = GroupeCours.idGroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
-- 	INNER JOIN ResultatEvaluation ON InscriptionCours.idInscriptionCours = ResultatEvaluation.idInscriptionCours
-- WHERE
-- 	Etudiant.codePermanent = 'BLAP201186' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016 AND
--	Evaluation.statusDiffusion = 'O'
-- /
--
-- Affichage note final lettree
--
-- SELECT
--	NoteLettree.lettre,
--	NoteLettree.valeur
-- FROM
--	InscriptionCours
-- 	INNER JOIN Etudiant ON InscriptionCours.idEtudiant = Etudiant.idEtudiant
-- 	INNER JOIN GroupeCours ON InscriptionCours.idGroupeCours = GroupeCours.idGroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
--	INNER JOIN NoteLettree ON InscriptionCours.idNoteLettree = NoteLettree.idNoteLettree
-- WHERE
-- 	Etudiant.codePermanent = 'BLAP201186' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016 AND
--	GroupeCours.diffusionNoteFinale = 'O'
-- /
--
-- Affichage des statistiques d'un groupe
--
 SELECT
	AVG(SUM(ResultatEvaluation.note / Evaluation.noteMaximal * Evaluation.ponderation / 100)
	OVER(PARTITION BY ResultatEvaluation.idInscriptionCours)) AS moyenneGroupe,
	STDDEV(SUM(ResultatEvaluation.note / Evaluation.noteMaximal * Evaluation.ponderation / 100)
		OVER(PARTITION BY ResultatEvaluation.idInscriptionCours)) AS ecartTypeGroupe
 FROM
 	GroupeCours
 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
 	INNER JOIN ResultatEvaluation ON InscriptionCours.idInscriptionCours = ResultatEvaluation.idInscriptionCours
 WHERE
 	Cours.sigle = 'INF5180' AND
 	GroupeCours.noGroupe = 40 AND
 	SessionUniversitaire.saison = 'Hiver' AND
 	SessionUniversitaire.annee = 2016 AND
	Evaluation.statusDiffusion = 'O'
/
----------------------------------------

CREATE INDEX idx_Etudiant_codePermanent ON Etudiant(codePermanent)
/
CREATE INDEX idx_Cours_sigle ON Cours(sigle)
/
CREATE INDEX idx_Session_anneeSaison ON Etudiant(annee, saison)
/
CREATE INDEX idx_GroupeCours_groupe ON GroupeCours(idCours, idSessionUni, noGroupe)
/
CREATE INDEX idx_InscrptCours_idGroupeEtudiant ON InscriptionCours(idEtudiant, idGroupeCours)
/
CREATE INDEX idx_Evaluation_idGroupe ON Evaluation(idGroupeCours)
/
CREATE INDEX idx_ResultatEval_idEvalInscrip ON ResultatEvaluation(idEvaluation, idInscriptionCours)
/