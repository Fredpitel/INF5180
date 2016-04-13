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
-- StatusTransfertNote transformé en
--			CHAR(6) ... CHECK(value IN ('non', 'depart', 'Traite'))
-- Boolean transformé en
--			CHAR(1) ... CHECK(value IN ('O', 'N'))
--------------------------------


--------------------------------
-- Destruction des tables
--------------------------------
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
	nbTentativeMax	NUMBER(3)
					CONSTRAINT nn_PG_nbTenMax NOT NULL
					CONSTRAINT ck_PG_nbTenMax(nbTentativeMax >= 0),
	tempsBlocage	NUMBER(3)
					CONSTRAINT nn_PG_tempsBloc NOT NULL
					CONSTRAINT ck_PG_tempsBloc(tempsBlocage >= 0
)
/
-- Insertion avec des valeurs bidons.
INSERT INTO ParametresGeneraux VALUES(1,1)
/

----------------------------------------------
-- TABLE SessionUniversitaire
----------------------------------------------

CREATE TABLE SessionUniversitaire(
	idSessionUni	NUMBER
					CONSTRAINT nn_SessionUni_id NOT NULL
					CONSTRAINT pk_SessionUni_id PRIMARY KEY,
	saison			CHAR(7)
					CONSTRAINT nn_SessionUni_saison NOT NULL
					CONSTRAINT ck_SessionUni_saison CHECK(saison IN ('Hiver', 'Automne', 'Ete')),
	annee			NUMBER(4)
					CONSTRAINT nn_SessionUni_annee NOT NULL
					CONSTRAINT ck_SessionUni_annee(annee >= 0),
	dateLimiteTrans	DATE
					CONSTRAINT nn_SessionUni_dLimite NOT NULL
)
/

----------------------------------------------
-- TABLE Departement
----------------------------------------------

CREATE TABLE Departement(
	idDepartement	NUMBER
					CONSTRAINT nn_Departement_id NOT NULL
					CONSTRAINT pk_Departement_id PRIMARY KEY,
	nom				VARCHAR2(50)
					CONSTRAINT nn_Departement_nom NOT NULL
)
/

----------------------------------------------
-- TABLE Cours
----------------------------------------------

CREATE TABLE Cours(
	idCours			NUMBER
					CONSTRAINT nn_Cours_id NOT NULL
					CONSTRAINT pk_Cours_id PRIMARY KEY,
	sigle			CHAR(7)
					CONSTRAINT nn_Cours_sigle NOT NULL
					CONSTRAINT ck_Cours_sigle CHECK(REGEXP_LIKE(sigle, '^[a-zA-Z]{3}[0-9]{4}$'))
					CONSTRAINT un_Cours_sigle UNIQUE,
	titre			VARCHAR2(50)
					CONSTRAINT nn_Cours_titre NOT NULL
	cycleUni		NUMBER(1)
					CONSTRAINT nn_Cours_cycleUni NOT NULL
					CONSTRAINT ck_Cours_cycleUni(cycleUni > 0),
	idDepartement	NUMBER
					CONSTRAINT nn_Cours_idDepartement NOT NULL
					CONSTRAINT fk_Cours_idDepartement REFERENCES Departement(idDepartement)
)
/

----------------------------------------------
-- TABLE Employe
----------------------------------------------

CREATE TABLE Employe(
	idEmploye		NUMBER
					CONSTRAINT nn_Employe_id NOT NULL
					CONSTRAINT pk_Employe_id PRIMARY KEY,
	codeMS			CHAR(12)
					CONSTRAINT nn_Employe_codeMS NOT NULL
					CONSTRAINT ck_Employe_codeMS CHECK(REGEXP_LIKE(sigle, '^[A-Z]{10}_[A-Z]$'))
					CONSTRAINT un_Employe_codeMS UNIQUE,
	motDePasse		CHAR(8)
					CONSTRAINT nn_Employe_motDePasse NOT NULL
					CONSTRAINT ck_Employe_motDePasse CHECK(REGEXP_LIKE(sigle, '^[A-Z0-9]{8}$')),
	idDepartement	NUMBER
					CONSTRAINT nn_Employe_idDepartement NOT NULL
					CONSTRAINT fk_Employe_idDepartement REFERENCES Departement(idDepartement)
)
/

----------------------------------------------
-- TABLE Enseignant
----------------------------------------------

CREATE TABLE Enseignant(
	idEnseignant	NUMBER
					CONSTRAINT nn_Enseignant_id NOT NULL
					CONSTRAINT pk_Enseignant_id PRIMARY KEY,
	nom				VARCHAR2(50)
					CONSTRAINT nn_Enseignant_nom NOT NULL,
	prenom			VARCHAR2(50)
					CONSTRAINT nn_Enseignant_prenom NOT NULL,
	idEmploye		NUMBER
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
						CONSTRAINT ck_GroupeCours_noGroupe(noGroupe >= 0),
	statutTransfertNote	CHAR(6)
						CONSTRAINT nn_GroupeCours_statutTrans NOT NULL
						CONSTRAINT ck_GroupeCours_statutTrans CHECK(saison IN ('non', 'depart', 'Traite')),
	diffusionNoteFinale	CHAR(1)
						CONSTRAINT nn_GroupeCours_diffusion NOT NULL
						CONSTRAINT ck_GroupeCours_diffusion CHECK(value IN ('O', 'N')),
	idEnseignant		NUMBER
						CONSTRAINT fk_GroupeCours_idEnseignant REFERENCES Enseignant(idEnseignant),
	idCours				NUMBER
						CONSTRAINT nn_GroupeCours_idCours NOT NULL
						CONSTRAINT fk_GroupeCours_idCours REFERENCES Cours(idCours),
	idSessionUni		NUMBER
						CONSTRAINT nn_GroupeCours_idSessionUni NOT NULL
						CONSTRAINT fk_GroupeCours_idSessionUni REFERENCES SessionUniversitaire(idSessionUni),
)
/