package com.example.taxi.model;

import java.math.BigDecimal;

public class PlaceSummary {
    private String categorieLibelle;
    private BigDecimal prixUnitaire;
    private int quantite;
    private BigDecimal total;

    public PlaceSummary(String categorieLibelle, BigDecimal prixUnitaire, int quantite) {
        this.categorieLibelle = categorieLibelle;
        this.prixUnitaire = prixUnitaire;
        this.quantite = quantite;
        this.total = prixUnitaire.multiply(BigDecimal.valueOf(quantite));
    }

    // Getters and Setters
    public String getCategorieLibelle() {
        return categorieLibelle;
    }

    public void setCategorieLibelle(String categorieLibelle) {
        this.categorieLibelle = categorieLibelle;
    }

    public BigDecimal getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(BigDecimal prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}