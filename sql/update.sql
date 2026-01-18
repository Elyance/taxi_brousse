-- Script pour mettre à jour les tarifs des enfants (id_categorie_client = 2)
-- Ici, on réduit les tarifs enfants à 50% du tarif adulte pour chaque catégorie
-- Vous pouvez ajuster les valeurs selon vos besoins

-- Mettre à jour le tarif enfant pour VIP (id_tarif = 1, id_categorie_client = 2)
UPDATE tarif_client 
SET prix = 90000  -- 50% de 180000
WHERE id_tarif = 1 AND id_categorie_client = 2;

-- Mettre à jour le tarif enfant pour PREMIUM (id_tarif = 2, id_categorie_client = 2)
UPDATE tarif_client 
SET prix = 70000  -- 50% de 140000
WHERE id_tarif = 2 AND id_categorie_client = 2;

-- Le tarif enfant pour STANDARD (id_tarif = 3, id_categorie_client = 2) est déjà à 50000 (environ 55% de 90000), pas de changement nécessaire
-- Si vous voulez le modifier, décommentez la ligne ci-dessous :

UPDATE tarif_client SET prix = 55000 WHERE id_tarif = 3 AND id_categorie_client = 1;
