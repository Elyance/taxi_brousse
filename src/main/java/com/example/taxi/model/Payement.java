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
@Table(name = "payement")
public class Payement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPayement;

    private BigDecimal montant;
    private Date datePayement;

    @ManyToOne
    @JoinColumn(name = "id_societe")
    private Societe societe;

    // Getters and Setters
    public Integer getIdPayement() {
        return idPayement;
    }

    public void setIdPayement(Integer idPayement) {
        this.idPayement = idPayement;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public Date getDatePayement() {
        return datePayement;
    }

    public void setDatePayement(Date datePayement) {
        this.datePayement = datePayement;
    }

    public Societe getSociete() {
        return societe;
    }

    public void setSociete(Societe societe) {
        this.societe = societe;
    }
}