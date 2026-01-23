package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.util.List;

@Entity
@Table(name = "commande_diffusion")
public class CommandeDiffusion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCommandeDiffusion;

    private BigDecimal montantTotal;

    @ManyToOne
    @JoinColumn(name = "id_societe")
    private Societe societe;

    @OneToMany(mappedBy = "commandeDiffusion")
    private List<DetailsCommandeDiffusion> detailsCommandeDiffusions;

    // Getters and Setters
    public Integer getIdCommandeDiffusion() {
        return idCommandeDiffusion;
    }

    public void setIdCommandeDiffusion(Integer idCommandeDiffusion) {
        this.idCommandeDiffusion = idCommandeDiffusion;
    }

    public BigDecimal getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(BigDecimal montantTotal) {
        this.montantTotal = montantTotal;
    }

    public Societe getSociete() {
        return societe;
    }

    public void setSociete(Societe societe) {
        this.societe = societe;
    }

    public List<DetailsCommandeDiffusion> getDetailsCommandeDiffusions() {
        return detailsCommandeDiffusions;
    }

    public void setDetailsCommandeDiffusions(List<DetailsCommandeDiffusion> detailsCommandeDiffusions) {
        this.detailsCommandeDiffusions = detailsCommandeDiffusions;
    }
}