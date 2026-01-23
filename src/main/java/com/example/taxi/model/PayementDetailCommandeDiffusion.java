package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payement_detail_commande_diffusion")
public class PayementDetailCommandeDiffusion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPayementDetailCommandeDiffusion;

    @ManyToOne
    @JoinColumn(name = "id_payement")
    private Payement payement;

    @ManyToOne
    @JoinColumn(name = "id_detail_commande_diffusion")
    private DetailsCommandeDiffusion detailsCommandeDiffusion;

    private BigDecimal montant;
    private LocalDateTime datePayement;

    // Getters and Setters
    public Integer getIdPayementDetailCommandeDiffusion() {
        return idPayementDetailCommandeDiffusion;
    }

    public void setIdPayementDetailCommandeDiffusion(Integer idPayementDetailCommandeDiffusion) {
        this.idPayementDetailCommandeDiffusion = idPayementDetailCommandeDiffusion;
    }

    public Payement getPayement() {
        return payement;
    }

    public void setPayement(Payement payement) {
        this.payement = payement;
    }

    public DetailsCommandeDiffusion getDetailsCommandeDiffusion() {
        return detailsCommandeDiffusion;
    }

    public void setDetailsCommandeDiffusion(DetailsCommandeDiffusion detailsCommandeDiffusion) {
        this.detailsCommandeDiffusion = detailsCommandeDiffusion;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public LocalDateTime getDatePayement() {
        return datePayement;
    }

    public void setDatePayement(LocalDateTime datePayement) {
        this.datePayement = datePayement;
    }
}