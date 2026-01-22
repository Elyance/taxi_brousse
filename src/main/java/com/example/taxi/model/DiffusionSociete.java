package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "diffusion_societe")
public class DiffusionSociete {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDiffusionSociete;

    @ManyToOne
    @JoinColumn(name = "id_societe")
    private Societe societe;

    private Date daty;

    @ManyToOne
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    private Date heureDiffusion;
    private BigDecimal valeurDiffusion;

    // Getters and Setters
    public Integer getIdDiffusionSociete() {
        return idDiffusionSociete;
    }

    public void setIdDiffusionSociete(Integer idDiffusionSociete) {
        this.idDiffusionSociete = idDiffusionSociete;
    }

    public Societe getSociete() {
        return societe;
    }

    public void setSociete(Societe societe) {
        this.societe = societe;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Voyage getVoyage() {
        return voyage;
    }

    public void setVoyage(Voyage voyage) {
        this.voyage = voyage;
    }

    public Date getHeureDiffusion() {
        return heureDiffusion;
    }

    public void setHeureDiffusion(Date heureDiffusion) {
        this.heureDiffusion = heureDiffusion;
    }

    public BigDecimal getValeurDiffusion() {
        return valeurDiffusion;
    }

    public void setValeurDiffusion(BigDecimal valeurDiffusion) {
        this.valeurDiffusion = valeurDiffusion;
    }
}