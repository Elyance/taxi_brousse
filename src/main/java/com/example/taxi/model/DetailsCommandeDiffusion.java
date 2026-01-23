package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "details_commande_diffusion")
public class DetailsCommandeDiffusion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetailCommandeDiffusion;

    @ManyToOne
    @JoinColumn(name = "id_commande_diffusion")
    private CommandeDiffusion commandeDiffusion;

    @ManyToOne
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    private Timestamp heureDiffusion;
    private Integer nbDiffusion;
    private BigDecimal prixDiffusion;

    // Getters and Setters
    public Integer getIdDetailCommandeDiffusion() {
        return idDetailCommandeDiffusion;
    }

    public void setIdDetailCommandeDiffusion(Integer idDetailCommandeDiffusion) {
        this.idDetailCommandeDiffusion = idDetailCommandeDiffusion;
    }

    public CommandeDiffusion getCommandeDiffusion() {
        return commandeDiffusion;
    }

    public void setCommandeDiffusion(CommandeDiffusion commandeDiffusion) {
        this.commandeDiffusion = commandeDiffusion;
    }

    public Voyage getVoyage() {
        return voyage;
    }

    public void setVoyage(Voyage voyage) {
        this.voyage = voyage;
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
}