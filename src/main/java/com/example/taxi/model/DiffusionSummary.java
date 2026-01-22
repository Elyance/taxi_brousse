package com.example.taxi.model;

import java.math.BigDecimal;

public class DiffusionSummary {
    private Societe societe;
    private long nbDiffusion;
    private BigDecimal chiffreAffaire;
    private BigDecimal prixDiffusion;
    private BigDecimal paye;
    private BigDecimal reste;

    // Constructors
    public DiffusionSummary() {}

    public DiffusionSummary(Societe societe, long nbDiffusion, BigDecimal chiffreAffaire, BigDecimal prixDiffusion, BigDecimal paye, BigDecimal reste) {
        this.societe = societe;
        this.nbDiffusion = nbDiffusion;
        this.chiffreAffaire = chiffreAffaire;
        this.prixDiffusion = prixDiffusion;
        this.paye = paye;
        this.reste = reste;
    }

    // Getters and Setters
    public Societe getSociete() {
        return societe;
    }

    public void setSociete(Societe societe) {
        this.societe = societe;
    }

    public long getNbDiffusion() {
        return nbDiffusion;
    }

    public void setNbDiffusion(long nbDiffusion) {
        this.nbDiffusion = nbDiffusion;
    }

    public BigDecimal getChiffreAffaire() {
        return chiffreAffaire;
    }

    public void setChiffreAffaire(BigDecimal chiffreAffaire) {
        this.chiffreAffaire = chiffreAffaire;
    }

    public BigDecimal getPrixDiffusion() {
        return prixDiffusion;
    }

    public void setPrixDiffusion(BigDecimal prixDiffusion) {
        this.prixDiffusion = prixDiffusion;
    }

    public BigDecimal getPaye() {
        return paye;
    }

    public void setPaye(BigDecimal paye) {
        this.paye = paye;
    }

    public BigDecimal getReste() {
        return reste;
    }

    public void setReste(BigDecimal reste) {
        this.reste = reste;
    }
}