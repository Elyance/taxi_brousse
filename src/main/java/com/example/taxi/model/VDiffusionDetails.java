package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "v_diffusion_details")
public class VDiffusionDetails {

    @Id
    private Integer idDetailCommandeDiffusion;

    private Integer idSociete;
    private String societeLibelle;
    private Integer idVoyage;
    private Timestamp dateDepart;
    private Integer idTrajet;
    private String gareDepartNom;
    private String gareArriveeNom;
    private Integer idVehicule;
    private String immatriculation;
    private Timestamp heureDiffusion;
    private Integer nbDiffusion;
    private BigDecimal prixDiffusion;
    private BigDecimal chiffreAffaire;
    private BigDecimal paye;
    private BigDecimal reste;

    // Getters and Setters
    public Integer getIdDetailCommandeDiffusion() {
        return idDetailCommandeDiffusion;
    }

    public void setIdDetailCommandeDiffusion(Integer idDetailCommandeDiffusion) {
        this.idDetailCommandeDiffusion = idDetailCommandeDiffusion;
    }

    public Integer getIdSociete() {
        return idSociete;
    }

    public void setIdSociete(Integer idSociete) {
        this.idSociete = idSociete;
    }

    public String getSocieteLibelle() {
        return societeLibelle;
    }

    public void setSocieteLibelle(String societeLibelle) {
        this.societeLibelle = societeLibelle;
    }

    public Integer getIdVoyage() {
        return idVoyage;
    }

    public void setIdVoyage(Integer idVoyage) {
        this.idVoyage = idVoyage;
    }

    public Timestamp getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Timestamp dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Integer getIdTrajet() {
        return idTrajet;
    }

    public void setIdTrajet(Integer idTrajet) {
        this.idTrajet = idTrajet;
    }

    public String getGareDepartNom() {
        return gareDepartNom;
    }

    public void setGareDepartNom(String gareDepartNom) {
        this.gareDepartNom = gareDepartNom;
    }

    public String getGareArriveeNom() {
        return gareArriveeNom;
    }

    public void setGareArriveeNom(String gareArriveeNom) {
        this.gareArriveeNom = gareArriveeNom;
    }

    public Integer getIdVehicule() {
        return idVehicule;
    }

    public void setIdVehicule(Integer idVehicule) {
        this.idVehicule = idVehicule;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public Timestamp getHeureDiffusion() {
        return heureDiffusion;
    }

    public void setHeureDiffusion(Timestamp heureDiffusion) {
        this.heureDiffusion = heureDiffusion;
    }

    public Integer getNbDiffusion() {
        return nbDiffusion;
    }

    public void setNbDiffusion(Integer nbDiffusion) {
        this.nbDiffusion = nbDiffusion;
    }

    public BigDecimal getPrixDiffusion() {
        return prixDiffusion;
    }

    public void setPrixDiffusion(BigDecimal prixDiffusion) {
        this.prixDiffusion = prixDiffusion;
    }

    public BigDecimal getChiffreAffaire() {
        return chiffreAffaire;
    }

    public void setChiffreAffaire(BigDecimal chiffreAffaire) {
        this.chiffreAffaire = chiffreAffaire;
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