-----------------------------------------------------------------------
-- INF5180-UQAM
-----------------------------------------------------------------------

--------------------------------
-- Transformation des types 
--------------------------------

DROP TABLE ParametresGeneraux
/
DROP TABLE SessionUniversitaire
/
DROP TABLE Departement
/
DROP TABLE Cours
/

----------------------------------------------
-- TABLE ParametresGeneraux
----------------------------------------------

CREATE TABLE ParametresGeneraux(
	nbTentativeMax	NUMBER(3)
					CONSTRAINT nn_PG_nbTenMax NOT NULL
					CONSTRAINT ck_PG_nbTenMax(nbTentativeMax > 0),
	tempsBlocage	NUMBER(3)
					CONSTRAINT nn_PG_tempsBloc NOT NULL
					CONSTRAINT ck_PG_tempsBloc(tempsBlocage > 0
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
					CONSTRAINT ck_SessionUni_annee(nbTentativeMax > 0),
	dateLimiteTrans	DATE
					CONSTRAINT nn_SessionUni_dLimite NOT NULL
)
/

----------------------------------------------
-- TABLE SessionUniversitaire
----------------------------------------------

CREATE TABLE Departement(
	idDepartement	NUMBER
					CONSTRAINT nn_Depart_id NOT NULL
					CONSTRAINT pk_Depart_id PRIMARY KEY,
	nom				VARCHAR2(50)
					CONSTRAINT nn_Depart_nom NOT NULL
)
/

----------------------------------------------
-- TABLE Cours
----------------------------------------------

CREATE TABLE Cours(
	idCours			NUMBER
					CONSTRAINT nn_Cours_id NOT NULL
					CONSTRAINT pk_Cours_id PRIMARY KEY,
)
/