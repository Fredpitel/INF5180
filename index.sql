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
-- SELECT
--	SUM(ResultatEvaluation.note / Evaluation.noteMaximal * Evaluation.ponderation / 100)
--		OVER(PARTITION BY ResultatEvaluation.idInscriptionCours) AS note
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
--	GroupeCours.diffusionNoteFinale = 'O'
-- /
-- Il faut que l'application calcule la moyenne et l'écart type.
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

----------------------------------------
-- Cas d'utilisation : l'Enseignant spécifie ou modifie les éléments d'évaluation pour un groupe-cours
--
-- Consulté les éléments d'évaluation
--
-- SELECT
-- 	Cours.sigle,
-- 	GroupeCours.noGroupe,
-- 	SessionUniversitaire.saison,
-- 	SessionUniversitaire.annee,
--	Evaluation.titre,
--	Evaluation.ponderation,
--	Evaluation.noteMaximal,
--	Evaluation.statusDiffusion,
--	Evaluation.ordreApparition
-- FROM
--	GroupeCours
-- 	INNER JOIN Cours ON GroupeCours.idCours = Cours.idCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Enseignant ON InscriptionCours.idEnseignant = Enseignant.idEnseignant
-- 	INNER JOIN Employe ON Enseignant.idEmploye = Employe.idEmploye
-- 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
-- WHERE
-- 	Employe.codeMS = 'AAAAAAAAAA_A' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016
-- /
----------------------------------------

CREATE INDEX idx_Employe_codeMS ON Employe(codeMS)
/
CREATE INDEX idx_Enseignant_idEmploye ON Enseignant(idEmploye)
/

----------------------------------------
-- Cas d'utilisation : l'Enseignant consulte la page d'accueil d'un groupecours
--
-- Affichage des étudiant
--
-- SELECT
-- 	Etudiant.codePermanent,
--	Etudiant.nom,
-- 	Etudiant.prenom,
--	StatutInscription.codeStatut,
-- 	Programme.codeProgramme,
--	ResultatEvaluation.note,
-- 	Evaluation.noteMaximal,
--	Evaluation.ponderation,
--	NoteLettree.lettre
-- FROM
-- 	InscriptionCours
-- 	INNER JOIN Etudiant ON InscriptionCours.idEtudiant = Etudiant.idEtudiant
-- 	INNER JOIN Programme ON Etudiant.idProgramme = Programme.idProgramme
-- 	INNER JOIN GroupeCours ON InscriptionCours.idGroupeCours = GroupeCours.idGroupeCours
-- 	INNER JOIN SessionUniversitaire ON GroupeCours.idSessionUni = SessionUniversitaire.idSessionUni
-- 	INNER JOIN Enseignant ON InscriptionCours.idEnseignant = Enseignant.idEnseignant
-- 	INNER JOIN Employe ON Enseignant.idEmploye = Employe.idEmploye
-- 	INNER JOIN Evaluation ON GroupeCours.idGroupeCours = Evaluation.idGroupeCours
-- 	INNER JOIN ResultatEvaluation ON InscriptionCours.idInscriptionCours = ResultatEvaluation.idInscriptionCours
--	LEFT JOIN NoteLettree ON InscriptionCours.idNoteLettree = NoteLettree.idNoteLettree
-- WHERE
-- 	Employe.codeMS = 'AAAAAAAAAA_A' AND
-- 	Cours.sigle = 'INF5180' AND
-- 	GroupeCours.noGroupe = 40 AND
-- 	SessionUniversitaire.saison = 'Hiver' AND
-- 	SessionUniversitaire.annee = 2016
-- ORDER BY Etudiant.codePermanent
-- /
-- le total de la note pondéré par étudiant est calculé par l'application
----------------------------------------

