-- =========================
-- VILLES
-- =========================
INSERT INTO ville (id_ville, libelle) VALUES
(1, 'Antananarivo'),
(2, 'Toamasina');

-- =========================
-- GARES
-- =========================
INSERT INTO gare (id_gare, nom, adresse, id_ville) VALUES
(1, 'Gare Routiere Analakely', 'Centre ville', 1),
(2, 'Gare Routiere Toamasina', 'Bazary be', 2);

-- =========================
-- MODELE VEHICULE
-- =========================
INSERT INTO vehicule_modele (id_vehicule_modele, modele) VALUES
(1, 'Sprinter');

-- =========================
-- VEHICULE
-- =========================
INSERT INTO vehicule (id_vehicule, immatriculation, nb_place, id_vehicule_modele) VALUES
(1, '1234-TAA', 18, 1);

-- =========================
-- CHAUFFEUR
-- =========================
INSERT INTO chauffeur (id_chauffeur, nom, prenom, telephone) VALUES
(1, 'Rakoto', 'Jean', '0341122334');

-- =========================
-- TRAJET : TANA -> TOAMASINA
-- =========================
INSERT INTO trajet (
    id_trajet,
    distance_km,
    duree_estimee_minutes,
    id_gare_depart,
    id_gare_arrivee
) VALUES (
    1,
    350,
    480,
    1,
    2
);

-- =========================
-- TARIFS PAR CATEGORIE DE PLACE
-- =========================
INSERT INTO tarif (id_tarif, prix, id_trajet, id_categorie_place) VALUES
(1, 180000, 1, 3), -- VIP
(2, 140000, 1, 2), -- PREMIUM
(3, 90000,  1, 1); -- STANDARD

-- =========================
-- TARIFS PAR CATEGORIE CLIENT
-- Adulte = 1 | Enfant = 2
-- =========================
INSERT INTO tarif_client (id_tarif_client, prix, id_tarif, id_categorie_client) VALUES
-- VIP
(1, 180000, 1, 1),
(2, 180000, 1, 2),

-- PREMIUM
(3, 140000, 2, 1),
(4, 140000, 2, 2),

-- STANDARD
(5, 90000, 3, 1),
(6, 50000, 3, 2);

-- =========================
-- VOYAGE
-- =========================
INSERT INTO voyage (
    id_voyage,
    date_depart,
    id_chauffeur,
    id_vehicule,
    id_trajet,
    id_voyage_statut
) VALUES (
    1,
    '2026-02-01 06:00:00',
    1,
    1,
    1,
    1 -- Programme
);

-- =========================
-- PLACES
-- VIP : 2 | PREMIUM : 6 | STANDARD : 10
-- =========================

-- VIP
INSERT INTO place (id_place, numero, id_vehicule, id_categorie_place, id_statut_place) VALUES
(1, 'V1', 1, 3, 1),
(2, 'V2', 1, 3, 1);

-- PREMIUM
INSERT INTO place VALUES
(3, 'P1', 1, 2, 1),
(4, 'P2', 1, 2, 1),
(5, 'P3', 1, 2, 1),
(6, 'P4', 1, 2, 1),
(7, 'P5', 1, 2, 1),
(8, 'P6', 1, 2, 1);

-- STANDARD
INSERT INTO place VALUES
(9,  'S1',  1, 1, 1),
(10, 'S2',  1, 1, 1),
(11, 'S3',  1, 1, 1),
(12, 'S4',  1, 1, 1),
(13, 'S5',  1, 1, 1),
(14, 'S6',  1, 1, 1),
(15, 'S7',  1, 1, 1),
(16, 'S8',  1, 1, 1),
(17, 'S9',  1, 1, 1),
(18, 'S10', 1, 1, 1);

INSERT INTO client (id_client, nom_complet, telephone, id_categorie_client) VALUES
(1, 'Rakoto Andry', '0341122334', 1),
(2, 'Rasoa Lala', '0334455667', 1),
(3, 'Rabe Michel', '0327788990', 1),
(4, 'Randria Jean', '0385566778', 1),

(5, 'Koto Junior', '0349988776', 2),
(6, 'Lalao Tina', '0336677889', 2),
(7, 'Mamy Kevin', '0324455661', 2),
(8, 'Fara Sophie', '0383344556', 2);
