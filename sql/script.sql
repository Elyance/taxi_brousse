CREATE TABLE admin(
   id_admin SERIAL,
   nom VARCHAR(50) NOT NULL,
   mot_de_passe VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_admin)
);

CREATE TABLE vehicule_modele(
   id_vehicule_modele SERIAL,
   modele VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_vehicule_modele)
);

CREATE TABLE billet_statut(
   id_billet_statut SERIAL,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_billet_statut)
);

CREATE TABLE categorie_client(
    id_categorie_client SERIAL,
    libelle VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_categorie_client)
);

CREATE TABLE client(
   id_client SERIAL,
   nom_complet VARCHAR(50) NOT NULL,
   telephone VARCHAR(50) NOT NULL,
   id_categorie_client INT,
    FOREIGN KEY(id_categorie_client) REFERENCES categorie_client(id_categorie_client),
   PRIMARY KEY(id_client)
);

CREATE TABLE methode_paiement(
   id_methode_paiement SERIAL,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_methode_paiement)
);

CREATE TABLE commande(
   id_commande SERIAL,
   montant_total DECIMAL(15,2) NOT NULL,
   date_commande TIMESTAMP NOT NULL,
   id_client INT NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(id_client) REFERENCES client(id_client)
);

CREATE TABLE chauffeur(
   id_chauffeur SERIAL,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   telephone VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_chauffeur)
);

CREATE TABLE ville(
   id_ville SERIAL,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_ville)
);

CREATE TABLE vehicule(
   id_vehicule SERIAL,
   immatriculation VARCHAR(50) NOT NULL,
   nb_place INT NOT NULL,
   id_vehicule_modele INT NOT NULL,
   PRIMARY KEY(id_vehicule),
   UNIQUE(immatriculation),
   FOREIGN KEY(id_vehicule_modele) REFERENCES vehicule_modele(id_vehicule_modele)
);

CREATE TABLE categorie_place (
    id_categorie_place SERIAL,
    libelle VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_categorie_place)
);

CREATE TABLE statut_place (
    id_statut_place SERIAL,
    libelle VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_statut_place)
);

CREATE TABLE place(
   id_place SERIAL,
   numero VARCHAR(10) NOT NULL,
   id_vehicule INT NOT NULL,
   id_categorie_place INT NOT NULL,
   id_statut_place INT NOT NULL,
   PRIMARY KEY(id_place),
   FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule),
   FOREIGN KEY(id_categorie_place) REFERENCES categorie_place(id_categorie_place),
   FOREIGN KEY(id_statut_place) REFERENCES statut_place(id_statut_place)
);

CREATE TABLE gare(
   id_gare SERIAL,
   nom VARCHAR(50) NOT NULL,
   adresse VARCHAR(50),
   id_ville INT NOT NULL,
   PRIMARY KEY(id_gare),
   FOREIGN KEY(id_ville) REFERENCES ville(id_ville)
);

CREATE TABLE paiement(
   id_paiement SERIAL,
   montant DECIMAL(15,2) NOT NULL,
   date_paiement TIMESTAMP NOT NULL,
   id_commande INT NOT NULL,
   id_methode_paiement INT NOT NULL,
   PRIMARY KEY(id_paiement),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande),
   FOREIGN KEY(id_methode_paiement) REFERENCES methode_paiement(id_methode_paiement)
);

CREATE TABLE trajet(
   id_trajet SERIAL,
   distance_km DECIMAL(15,2) NOT NULL,
   duree_estimee_minutes DECIMAL(15,2),
   id_gare_arrivee INT NOT NULL,
   id_gare_depart INT NOT NULL,
   PRIMARY KEY(id_trajet),
   FOREIGN KEY(id_gare_arrivee) REFERENCES gare(id_gare),
   FOREIGN KEY(id_gare_depart) REFERENCES gare(id_gare)
);

CREATE TABLE tarif(
    id_tarif SERIAL,
    prix DECIMAL(15,2) NOT NULL,
    id_trajet INT NOT NULL,
    id_categorie_place INT NOT NULL,
    PRIMARY KEY(id_tarif),
    FOREIGN KEY(id_trajet) REFERENCES trajet(id_trajet),
    FOREIGN KEY(id_categorie_place) REFERENCES categorie_place(id_categorie_place)
);

CREATE TABLE tarif_client(
    id_tarif_client SERIAL,
    prix DECIMAL(15,2) NOT NULL,
    id_tarif INT NOT NULL,
    id_categorie_client INT NOT NULL,
    PRIMARY KEY(id_tarif_client),
    FOREIGN KEY(id_tarif) REFERENCES tarif(id_tarif),
    FOREIGN KEY(id_categorie_client) REFERENCES categorie_client(id_categorie_client)
);

CREATE TABLE voyage_statut(
   id_voyage_statut SERIAL,
   libelle VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_voyage_statut)
);

CREATE TABLE voyage(
   id_voyage SERIAL,
   date_depart TIMESTAMP NOT NULL,
   id_chauffeur INT NOT NULL,
   id_vehicule INT NOT NULL,
   id_trajet INT NOT NULL,
   id_voyage_statut INT NOT NULL,
   PRIMARY KEY(id_voyage),
   FOREIGN KEY(id_chauffeur) REFERENCES chauffeur(id_chauffeur),
   FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule),
   FOREIGN KEY(id_trajet) REFERENCES trajet(id_trajet),
   FOREIGN KEY(id_voyage_statut) REFERENCES voyage_statut(id_voyage_statut)
);

CREATE TABLE statut_voyage(
   id_statut_voyage SERIAL,
   date_statut TIMESTAMP NOT NULL,
   id_voyage_statut INT NOT NULL,
   id_voyage INT NOT NULL,
   PRIMARY KEY(id_statut_voyage),
   FOREIGN KEY(id_voyage_statut) REFERENCES voyage_statut(id_voyage_statut),
   FOREIGN KEY(id_voyage) REFERENCES voyage(id_voyage)
);

CREATE TABLE billet(
   id_billet SERIAL,
   code_billet VARCHAR(50) NOT NULL,
   montant_total DECIMAL(15,2) NOT NULL,
   id_client INT NOT NULL,
   id_voyage INT NOT NULL,
   id_place INT NOT NULL,
   PRIMARY KEY(id_billet),
   FOREIGN KEY(id_client) REFERENCES client(id_client),
   FOREIGN KEY(id_voyage) REFERENCES voyage(id_voyage),
   FOREIGN KEY(id_place) REFERENCES place(id_place)
);

CREATE TABLE statut_billet(
   id_statut_billet SERIAL,
   date_statut TIMESTAMP NOT NULL,
   id_billet_statut INT NOT NULL,
   id_billet INT NOT NULL,
   PRIMARY KEY(id_statut_billet),
   FOREIGN KEY(id_billet_statut) REFERENCES billet_statut(id_billet_statut),
   FOREIGN KEY(id_billet) REFERENCES billet(id_billet)
);

CREATE TABLE details_commande(
   id_detail_commande SERIAL,
   id_billet INT NOT NULL,
   id_commande INT NOT NULL,
   PRIMARY KEY(id_detail_commande),
   FOREIGN KEY(id_billet) REFERENCES billet(id_billet),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE remise_client(
   id_remise_client SERIAL,
   pourcentage_remise DECIMAL(5,2) NOT NULL,
   id_categorie_client INT NOT NULL,
   id_categorie_reference INT NOT NULL,
    PRIMARY KEY(id_remise_client),
    FOREIGN KEY(id_categorie_client) REFERENCES categorie_client(id_categorie_client),
    FOREIGN KEY(id_categorie_reference) REFERENCES categorie_client(id_categorie_client)
);