-- =========================
-- VILLES
-- =========================
INSERT INTO ville VALUES
(1, 'Antananarivo'),
(2, 'Toamasina'),
(3, 'Fianarantsoa');

-- =========================
-- GARES
-- =========================
INSERT INTO gare VALUES
(1, 'Gare Routiere Analakely', 'Centre ville', 1),
(2, 'Gare Routiere Toamasina', 'Bazary be', 2),
(3, 'Gare Routiere Fianarantsoa', 'Tanambao', 3);


-- =========================
-- CHAUFFEURS
-- =========================
INSERT INTO chauffeur VALUES
(1, 'Rakoto', 'Jean', '0341122334'),
(2, 'Rabe', 'Paul', '0334455667');


-- =========================
-- MODELES DE VEHICULE
-- =========================
INSERT INTO vehicule_modele VALUES
(1, 'Sprinter'),
(2, 'Coaster');

-- =========================
-- VEHICULES
-- =========================
INSERT INTO vehicule VALUES
(1, '1234-TAA', 16, 1),
(2, '5678-TAB', 30, 2);

-- =========================
-- CATEGORIES DE PLACE
-- =========================
INSERT INTO categorie_place VALUES
(1, 'Standard'),
(2, 'VIP');

-- =========================
-- PLACES
-- =========================
INSERT INTO place VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 1, 2, 2);

-- =========================
-- TRAJETS
-- =========================
INSERT INTO trajet VALUES
(1, 350, 480, 2, 1),
(2, 410, 600, 3, 1);

-- =========================
-- TARIFS
-- =========================
INSERT INTO tarif VALUES
(1, 30000, 1, 1),
(2, 45000, 1, 2),
(3, 35000, 2, 1),
(4, 50000, 2, 2);

-- =========================
-- METHODES DE PAIEMENT
-- =========================
INSERT INTO methode_paiement VALUES
(1, 'Espece'),
(2, 'Mobile Money'),
(3, 'Carte Bancaire'),
(4, 'Cheque'),
(5, 'Virement Bancaire');

-- =========================
-- CLIENTS
-- =========================
INSERT INTO client VALUES
(1, 'Rakoto Andry', '0349988776'),
(2, 'Rasoa Lala', '0337766554');

-- =========================
-- VOYAGES
-- =========================
INSERT INTO voyage VALUES
(1, '2026-02-01 06:00:00', 1, 1, 1, 1),
(2, '2026-02-02 07:00:00', 2, 2, 2, 1);

