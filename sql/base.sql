-- =========================
-- ADMIN
-- =========================
INSERT INTO admin VALUES
(1, 'admin', 'test');


-- =========================
-- STATUTS BILLET
-- =========================
INSERT INTO billet_statut VALUES
(1, 'Reserve'),
(2, 'Paye'),
(3, 'Annule');

-- =========================
-- STATUTS DE PLACE
-- =========================
INSERT INTO statut_place VALUES
(1, 'Libre'),
(2, 'Reservee');

-- =========================
-- STATUTS VOYAGE
-- =========================
INSERT INTO voyage_statut VALUES
(1, 'Programme'),
(2, 'En cours'),
(3, 'Termine');

-- =========================
-- METHODES DE PAIEMENT
-- =========================
INSERT INTO methode_paiement VALUES
(1, 'Espece'),
(2, 'Mobile Money'),
(3, 'Carte Bancaire'),
(4, 'Cheque'),
(5, 'Virement Bancaire');

INSERT INTO categorie_place VALUES
(1, 'Standard'),
(2, 'Premium'),
(3, 'VIP');

INSERT INTO categorie_client VALUES
(1, 'Adulte'),
(2, 'Enfant');


