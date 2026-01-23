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

CREATE OR REPLACE VIEW v_diffusion_details AS
SELECT
    s.id_societe,
    s.libelle AS societe_libelle,
    v.id_voyage,
    v.date_depart,
    t.id_trajet,
    gd.nom AS gare_depart_nom,
    ga.nom AS gare_arrivee_nom,
    vh.id_vehicule,
    vh.immatriculation,
    dcd.id_detail_commande_diffusion,
    dcd.heure_diffusion,
    dcd.nb_diffusion,
    dcd.prix_diffusion,
    (dcd.nb_diffusion * dcd.prix_diffusion) AS chiffre_affaire,
    COALESCE(SUM(pdcd.montant), 0) AS paye,
    ((dcd.nb_diffusion * dcd.prix_diffusion) - COALESCE(SUM(pdcd.montant), 0)) AS reste
FROM details_commande_diffusion dcd
JOIN commande_diffusion cd ON dcd.id_commande_diffusion = cd.id_commande_diffusion
JOIN societe s ON cd.id_societe = s.id_societe
JOIN voyage v ON dcd.id_voyage = v.id_voyage
JOIN trajet t ON v.id_trajet = t.id_trajet
JOIN gare gd ON t.id_gare_depart = gd.id_gare
JOIN gare ga ON t.id_gare_arrivee = ga.id_gare
JOIN vehicule vh ON v.id_vehicule = vh.id_vehicule
LEFT JOIN payement_detail_commande_diffusion pdcd ON dcd.id_detail_commande_diffusion = pdcd.id_detail_commande_diffusion
GROUP BY s.id_societe, s.libelle, v.id_voyage, v.date_depart, t.id_trajet, gd.nom, ga.nom, vh.id_vehicule, vh.immatriculation, dcd.id_detail_commande_diffusion, dcd.heure_diffusion, dcd.nb_diffusion, dcd.prix_diffusion;