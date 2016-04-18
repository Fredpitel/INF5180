-----------------------------------------------------------------------
-- INF5180-UQAM
-----------------------------------------------------------------------

--------------------------------
-- Transformation des types 
--------------------------------
-- EntierPositif transformé en
--			NUMBER(n) ... CHECK(value >= 0)
-- Saison transformé en
-- 			CHAR(7) ... CHECK(value IN ('Hiver', 'Automne', 'Ete'))
-- Sigle transformé en 
--			CHAR(7) ... CHECK(REGEXP_LIKE(value, '^[a-zA-Z]{3}[0-9]{4}$'))
-- CodeMS transformé en
-- 			CHAR(12) ... CHECK(REGEXP_LIKE(value, '^[A-Z]{10}_[A-Z]$'))
-- StatutTransfertNote transformé en
--			CHAR(6) ... CHECK(value IN ('non', 'depart', 'Traite'))
-- Boolean transformé en
--			CHAR(1) ... CHECK(value IN ('O', 'N'))
-- CodeProgramme transformé en
--			CHAR(4) ... CHECK(REGEXP_LIKE(value, '^[0-9]{4}$'))
-- Note transformé en
--			NUMBER(5,2) ... CHECK(value >= 0.00 AND value <= 100.00))
--------------------------------


--------------------------------
-- Destruction des tables
--------------------------------

DROP TABLE Borne
/
DROP TABLE ResultatEvaluation
/
DROP TABLE Evaluation
/
DROP TABLE InscriptionCours
/
DROP TABLE NoteLettree
/
DROP TABLE	StatutInscription
/
DROP TABLE Etudiant
/
DROP TABLE Programme
/
DROP TABLE GroupeCours
/
DROP TABLE Enseignant
/
DROP TABLE Employe
/
DROP TABLE Cours
/
DROP TABLE Departement
/
DROP TABLE SessionUniversitaire
/
DROP TABLE ParametresGeneraux
/

----------------------------------------------
-- TABLE ParametresGeneraux
----------------------------------------------

CREATE TABLE ParametresGeneraux(
	nbTentativeMax		NUMBER(3)
						CONSTRAINT nn_PG_nbTenMax NOT NULL
						CONSTRAINT ck_PG_nbTenMax CHECK(nbTentativeMax >= 0),
	tempsBlocage		NUMBER(3)
						CONSTRAINT nn_PG_tempsBloc NOT NULL
						CONSTRAINT ck_PG_tempsBloc CHECK(tempsBlocage >= 0)
)
/
-- Insertion avec des valeurs bidons.
INSERT INTO ParametresGeneraux VALUES(1,1)
/

----------------------------------------------
-- TABLE SessionUniversitaire
----------------------------------------------

CREATE TABLE SessionUniversitaire(
	idSessionUni		NUMBER
						CONSTRAINT nn_SessionUni_id NOT NULL
						CONSTRAINT pk_SessionUni_id PRIMARY KEY,
	saison				CHAR(7)
						CONSTRAINT nn_SessionUni_saison NOT NULL
						CONSTRAINT ck_SessionUni_saison CHECK(saison IN ('Hiver', 'Automne', 'Ete')),
	annee				NUMBER(4)
						CONSTRAINT nn_SessionUni_annee NOT NULL
						CONSTRAINT ck_SessionUni_annee CHECK(annee >= 0),
	dateLimiteTrans		DATE
						CONSTRAINT nn_SessionUni_dLimite NOT NULL
)
/

----------------------------------------------
-- TABLE Departement
----------------------------------------------

CREATE TABLE Departement(
	idDepartement		NUMBER
						CONSTRAINT nn_Departement_id NOT NULL
						CONSTRAINT pk_Departement_id PRIMARY KEY,
	nom					VARCHAR2(50)
						CONSTRAINT nn_Departement_nom NOT NULL
)
/

----------------------------------------------
-- TABLE Cours
----------------------------------------------

CREATE TABLE Cours(
	idCours				NUMBER
						CONSTRAINT nn_Cours_id NOT NULL
						CONSTRAINT pk_Cours_id PRIMARY KEY,
	sigle				CHAR(7)
						CONSTRAINT nn_Cours_sigle NOT NULL
						CONSTRAINT ck_Cours_sigle CHECK(REGEXP_LIKE(sigle, '^[a-zA-Z]{3}[0-9]{4}$'))
						CONSTRAINT un_Cours_sigle UNIQUE,
	titre				VARCHAR2(50)
						CONSTRAINT nn_Cours_titre NOT NULL,
	cycleUni			NUMBER(1)
						CONSTRAINT nn_Cours_cycleUni NOT NULL
						CONSTRAINT ck_Cours_cycleUni CHECK(cycleUni > 0 AND cycleUni <= 3),
	idDepartement		NUMBER
						CONSTRAINT nn_Cours_idDepartement NOT NULL
						CONSTRAINT fk_Cours_idDepartement REFERENCES Departement(idDepartement)
)
/

----------------------------------------------
-- TABLE Employe
----------------------------------------------

CREATE TABLE Employe(
	idEmploye			NUMBER
						CONSTRAINT nn_Employe_id NOT NULL
						CONSTRAINT pk_Employe_id PRIMARY KEY,
	codeMS				CHAR(12)
						CONSTRAINT nn_Employe_codeMS NOT NULL
						CONSTRAINT ck_Employe_codeMS CHECK(REGEXP_LIKE(codeMS, '^[A-Z]{10}_[A-Z]$'))
						CONSTRAINT un_Employe_codeMS UNIQUE,
	motDePasse			CHAR(8)
						CONSTRAINT nn_Employe_motDePasse NOT NULL
						CONSTRAINT ck_Employe_motDePasse CHECK(REGEXP_LIKE(motDePasse, '^[A-Z0-9]{8}$')),
	idDepartement		NUMBER
						CONSTRAINT nn_Employe_idDepartement NOT NULL
						CONSTRAINT fk_Employe_idDepartement REFERENCES Departement(idDepartement)
)
/

----------------------------------------------
-- TABLE Enseignant
----------------------------------------------

CREATE TABLE Enseignant(
	idEnseignant		NUMBER
						CONSTRAINT nn_Enseignant_id NOT NULL
						CONSTRAINT pk_Enseignant_id PRIMARY KEY,
	nom					VARCHAR2(50)
						CONSTRAINT nn_Enseignant_nom NOT NULL,
	prenom				VARCHAR2(50)
						CONSTRAINT nn_Enseignant_prenom NOT NULL,
	idEmploye			NUMBER
						CONSTRAINT nn_Enseignant_idEmploye NOT NULL
						CONSTRAINT fk_Enseignant_idEmploye REFERENCES Employe(idEmploye)
)
/

----------------------------------------------
-- TABLE GroupeCours
----------------------------------------------

CREATE TABLE GroupeCours(
	idGroupeCours		NUMBER
						CONSTRAINT nn_GroupeCours_id NOT NULL
						CONSTRAINT pk_GroupeCours_id PRIMARY KEY,
	noGroupe			NUMBER(2)
						CONSTRAINT nn_GroupeCours_noGroupe NOT NULL
						CONSTRAINT ck_GroupeCours_noGroupe CHECK(noGroupe >= 0),
	statutTransfertNote	CHAR(6)
						CONSTRAINT nn_GroupeCours_statutTrans NOT NULL
						CONSTRAINT ck_GroupeCours_statutTrans CHECK(statutTransfertNote IN ('Non', 'Depart', 'Traite')),
	diffusionNoteFinale	CHAR(1)
						CONSTRAINT nn_GroupeCours_diffusion NOT NULL
						CONSTRAINT ck_GroupeCours_diffusion CHECK(diffusionNoteFinale IN ('O', 'N')),
	idEnseignant		NUMBER
						CONSTRAINT n_GroupeCours_idEnseignant NULL
						CONSTRAINT fk_GroupeCours_idEnseignant REFERENCES Enseignant(idEnseignant),
	idCours				NUMBER
						CONSTRAINT nn_GroupeCours_idCours NOT NULL
						CONSTRAINT fk_GroupeCours_idCours REFERENCES Cours(idCours),
	idSessionUni		NUMBER
						CONSTRAINT nn_GroupeCours_idSessionUni NOT NULL
						CONSTRAINT fk_GroupeCours_idSessionUni REFERENCES SessionUniversitaire(idSessionUni)
)
/

----------------------------------------------
-- TABLE Programme
----------------------------------------------

CREATE TABLE Programme(
	idProgramme			NUMBER
						CONSTRAINT nn_Programme_id NOT NULL
						CONSTRAINT pk_Programme_id PRIMARY KEY,
	codeProgramme		CHAR(4)
						CONSTRAINT nn_Programme_codeProg NOT NULL
						CONSTRAINT un_Programme_codeProg UNIQUE
						CONSTRAINT ck_Programme_codeProg CHECK(REGEXP_LIKE(codeProgramme, '^[0-9]{4}$')),
	titre				VARCHAR2(50)
						CONSTRAINT nn_Programme_titre NOT NULL
)
/

----------------------------------------------
-- TABLE Etudiant
----------------------------------------------

CREATE TABLE Etudiant(
	idEtudiant			NUMBER
						CONSTRAINT nn_Etudiant_id NOT NULL
						CONSTRAINT pk_Etudiant_id PRIMARY KEY,
	codePermanent		CHAR(12)
						CONSTRAINT nn_Etudiant_codePermanent NOT NULL
						CONSTRAINT un_Etudiant_codePermanent UNIQUE
						CONSTRAINT ck_Etudiant_codePermanent CHECK(REGEXP_LIKE(codePermanent, '^[A-Z]{4}[0-9]{8}$')),
	nom					VARCHAR2(50)
						CONSTRAINT nn_Etudiant_nom NOT NULL,
	prenom				VARCHAR2(50)
						CONSTRAINT nn_Etudiant_prenom NOT NULL,
	nip					CHAR(5)
						CONSTRAINT nn_Etudiant_nip NOT NULL
						CONSTRAINT ck_Etudiant_nip CHECK(REGEXP_LIKE(nip, '^[0-9]{5}$')),
	nbTentative			NUMBER(3)
						CONSTRAINT nn_Etudiant_nbTentative NOT NULL
						CONSTRAINT ck_Etudiant_nbTentative CHECK(nbTentative >= 0 AND nbTentative <= 5),
	tempsEchec			DATE
						CONSTRAINT n_Etudiant_nbTentative NULL,
	idProgramme			NUMBER
						CONSTRAINT nn_Etudiant_idProgramme NOT NULL
						CONSTRAINT fk_Etudiant_idProgramme REFERENCES Programme(idProgramme)
)
/

----------------------------------------------
-- TABLE StatutInscription
----------------------------------------------

CREATE TABLE StatutInscription(
	idStatutInscription	NUMBER
						CONSTRAINT nn_StatutIns_id NOT NULL
						CONSTRAINT pk_StatutIns_id PRIMARY KEY,
	codeStatut			CHAR(3)
						CONSTRAINT nn_StatutIns_codeStatus NOT NULL
						CONSTRAINT un_StatutIns_codeStatus UNIQUE,
	description			VARCHAR2(100)
						CONSTRAINT nn_StatutIns_description NOT NULL
)
/

----------------------------------------------
-- TABLE NoteLettree
----------------------------------------------

CREATE TABLE NoteLettree(
	idNoteLettree		NUMBER
						CONSTRAINT nn_NoteLettree_id NOT NULL
						CONSTRAINT pk_NoteLettree_id PRIMARY KEY,
	lettre				CHAR(2)
						CONSTRAINT nn_NoteLettree_lettre NOT NULL
						CONSTRAINT un_NoteLettree_lettre UNIQUE,
	valeur				NUMBER(2,1)
						CONSTRAINT nn_NoteLettree_valeur NOT NULL
						CONSTRAINT ck_NoteLettree_valeur CHECK(valeur >= 0.0 AND valeur <= 4.3)
)
/

----------------------------------------------
-- TABLE InscriptionCours
----------------------------------------------

CREATE TABLE InscriptionCours(
	idInscriptionCours	NUMBER
						CONSTRAINT nn_InscripCours_id NOT NULL
						CONSTRAINT pk_InscripCours_id PRIMARY KEY,
	idStatutInscription	NUMBER
						CONSTRAINT nn_InscripCours_idStatut NOT NULL
						CONSTRAINT fk_InscripCours_idStatut REFERENCES StatutInscription(idStatutInscription),
	idEtudiant			NUMBER
						CONSTRAINT nn_InscripCours_idEtudiant NOT NULL
						CONSTRAINT fk_InscripCours_idEtudiant REFERENCES Etudiant(idEtudiant),
	idGroupeCours		NUMBER
						CONSTRAINT nn_InscripCours_idGroupeCours NOT NULL
						CONSTRAINT fk_InscripCours_idGroupeCours REFERENCES GroupeCours(idGroupeCours),
	idNoteLettree		NUMBER
						CONSTRAINT n_InscripCours_idNoteLettree NULL
						CONSTRAINT fk_InscripCours_idNoteLettree REFERENCES NoteLettree(idNoteLettree)
)
/

----------------------------------------------
-- TABLE Evaluation
----------------------------------------------

CREATE TABLE Evaluation(
	idEvaluation		NUMBER
						CONSTRAINT nn_Evaluation_id NOT NULL
						CONSTRAINT pk_Evaluation_id PRIMARY KEY,
	titre				VARCHAR2(50)
						CONSTRAINT nn_Evaluation_titre NOT NULL,
	ponderation			NUMBER(5,2)
						CONSTRAINT nn_Evaluation_ponderation NOT NULL
						CONSTRAINT ck_Evaluation_ponderation CHECK(ponderation >= 0.00 AND ponderation <= 100.00),
	noteMaximal			NUMBER(5,2)
						CONSTRAINT nn_Evaluation_noteMaximal NOT NULL
						CONSTRAINT ck_Evaluation_noteMaximal CHECK(noteMaximal >= 0.00 AND noteMaximal <= 100.00),
	statusDiffusion		CHAR(1)
						CONSTRAINT nn_Evaluation_diffusion NOT NULL
						CONSTRAINT ck_Evaluation_diffusion CHECK(statusDiffusion IN ('O', 'N')),
	ordreApparition		NUMBER(2)
						CONSTRAINT nn_Evaluation_ordre NOT NULL
						CONSTRAINT ck_Evaluation_ordre CHECK(ordreApparition > 0),
	idGroupeCours		NUMBER
						CONSTRAINT nn_Evaluation_idGroupeCours NOT NULL
						CONSTRAINT pk_Evaluation_idGroupeCours REFERENCES GroupeCours(idGroupeCours)
)
/

----------------------------------------------
-- TABLE ResultatEvaluation
----------------------------------------------

CREATE TABLE ResultatEvaluation(
	idResultatEval		NUMBER
						CONSTRAINT nn_ResultatEval_id NOT NULL
						CONSTRAINT pk_ResultatEval_id PRIMARY KEY,
	note				NUMBER(5,2)
						CONSTRAINT nn_ResultatEval_note NOT NULL
						CONSTRAINT ck_ResultatEval_note CHECK(note >= 0.00 AND note <= 100.00),
	idInscriptionCours	NUMBER
						CONSTRAINT nn_ResultatEval_idInscripCours NOT NULL
						CONSTRAINT pk_ResultatEval_idInscripCours REFERENCES InscriptionCours(idInscriptionCours),
	idEvaluation		NUMBER
						CONSTRAINT nn_ResultatEval_idEvaluation NOT NULL
						CONSTRAINT pk_ResultatEval_idEvaluation REFERENCES Evaluation(idEvaluation)
)
/

----------------------------------------------
-- TABLE Borne
----------------------------------------------

CREATE TABLE Borne(
	idBorne				NUMBER
						CONSTRAINT nn_Borne_id NOT NULL
						CONSTRAINT pk_Borne_id PRIMARY KEY,
	borneInferieure		NUMBER(5,2)
						CONSTRAINT nn_Borne_borneInf NOT NULL
            CONSTRAINT un_Borne_borneInf UNIQUE
						CONSTRAINT ck_Borne_borneInf CHECK(borneInferieure >= 0.00 AND borneInferieure <= 100.00),
	idGroupeCours		NUMBER
						CONSTRAINT nn_Borne_idGroupeCours NOT NULL
						CONSTRAINT pk_Borne_idGroupeCours REFERENCES GroupeCours(idGroupeCours),
	idNoteLettree		NUMBER
						CONSTRAINT nn_Borne_idNoteLettree NOT NULL
						CONSTRAINT pk_Borne_idNoteLettree REFERENCES NoteLettree(idNoteLettree)
)
/

----------------------------------------------
-- TABLE InterfaceRegistrariat
----------------------------------------------

CREATE TABLE InterfaceRegistrariat(
	idIntRegistrariat	NUMBER
						CONSTRAINT nn_IntRegist_id NOT NULL
						CONSTRAINT pk_IntRegist_id PRIMARY KEY,
	dateChangement		DATE
						CONSTRAINT nn_IntRegist_dateChange NOT NULL,
	natureChangement	CHAR(5)
						CONSTRAINT nn_IntRegist_natureChange NOT NULL
						CONSTRAINT ck_IntRegist_natureChange CHECK(natureChangement IN('modif', 'ajout')),
	codePermanent		CHAR(12)
						CONSTRAINT nn_IntRegist_codePerm NOT NULL
						CONSTRAINT ck_IntRegist_codePerm CHECK(REGEXP_LIKE(codePermanent, '^[A-Z]{4}[0-9]{8}$')),
	sigleCours			CHAR(7)
						CONSTRAINT nn_IntRegist_sigle NOT NULL
						CONSTRAINT ck_IntRegist_sigle CHECK(REGEXP_LIKE(sigleCours, '^[a-zA-Z]{3}[0-9]{4}$')),
	noGroupe			NUMBER(2)
						CONSTRAINT nn_IntRegist_noGroupe NOT NULL
						CONSTRAINT ck_IntRegist_noGroupe CHECK(noGroupe >= 0),
	saison				CHAR(7)
						CONSTRAINT nn_IntRegist_saison NOT NULL
						CONSTRAINT ck_IntRegist_saison CHECK(saison IN ('Hiver', 'Automne', 'Ete')),
	annee				NUMBER(4)
						CONSTRAINT nn_IntRegist_annee NOT NULL
						CONSTRAINT ck_IntRegist_annee CHECK(annee >= 0),
	noteLettree			CHAR(2)
						CONSTRAINT nn_NoteLettree_lettre NOT NULL
)
/