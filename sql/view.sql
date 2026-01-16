CREATE OR REPLACE VIEW voyage_details AS
SELECT 
    v.id_voyage,
    v.date_depart,
    t.id_trajet,
    c.nom AS chauffeur_nom,
    c.prenom AS chauffeur_prenom,
    c.telephone AS chauffeur_telephone,
    ve.immatriculation,
    vm.modele AS vehicule_modele,
    g1.nom AS gare_depart,
    g1.adresse AS gare_depart_adresse,
    vi1.libelle AS ville_depart,
    g2.nom AS gare_arrivee,
    g2.adresse AS gare_arrivee_adresse,
    vi2.libelle AS ville_arrivee,
    t.distance_km,
    t.duree_estimee_minutes,
    vs.libelle AS statut_voyage,
    MIN(ta.prix) AS tarif_prix
FROM voyage v
JOIN chauffeur c ON v.id_chauffeur = c.id_chauffeur
JOIN vehicule ve ON v.id_vehicule = ve.id_vehicule
JOIN vehicule_modele vm ON ve.id_vehicule_modele = vm.id_vehicule_modele
JOIN trajet t ON v.id_trajet = t.id_trajet
LEFT JOIN tarif ta ON ta.id_trajet = t.id_trajet
JOIN gare g1 ON t.id_gare_depart = g1.id_gare
JOIN ville vi1 ON g1.id_ville = vi1.id_ville
JOIN gare g2 ON t.id_gare_arrivee = g2.id_gare
JOIN ville vi2 ON g2.id_ville = vi2.id_ville
JOIN voyage_statut vs ON v.id_voyage_statut = vs.id_voyage_statut
GROUP BY v.id_voyage, v.date_depart, t.id_trajet, c.nom, c.prenom, c.telephone, ve.immatriculation, vm.modele, g1.nom, g1.adresse, vi1.libelle, g2.nom, g2.adresse, vi2.libelle, t.distance_km, t.duree_estimee_minutes, vs.libelle;



CREATE VIEW tarif_details AS
SELECT 
    t.id_tarif,
    tr.id_trajet,
    cp.libelle AS categorie_place,
    t.prix
FROM tarif t
JOIN trajet tr ON t.id_trajet = tr.id_trajet
JOIN categorie_place cp ON t.id_categorie_place = cp.id_categorie_place;