-- Script pour nettoyer les données opérationnelles de la base de données
-- Garde les données de base (statuts, admin, etc.)

-- Désactiver les contraintes de clés étrangères temporairement
SET session_replication_role = 'replica';

-- Supprimer les données opérationnelles dans l'ordre inverse des dépendances
DELETE FROM details_commande;
DELETE FROM statut_billet;
DELETE FROM billet;
DELETE FROM billet_statut;
DELETE FROM statut_voyage;
DELETE FROM voyage_statut;
DELETE FROM voyage;
DELETE FROM tarif;
DELETE FROM trajet;
DELETE FROM gare;
DELETE FROM ville;
DELETE FROM place;
DELETE FROM vehicule;
DELETE FROM vehicule_modele;
DELETE FROM chauffeur;
DELETE FROM client;
DELETE FROM categorie_client;
DELETE FROM commande;
DELETE FROM paiement;
DELETE FROM methode_paiement;

-- Réactiver les contraintes
SET session_replication_role = 'origin';