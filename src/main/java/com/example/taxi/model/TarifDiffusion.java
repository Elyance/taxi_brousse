package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tarif_diffusion")
public class TarifDiffusion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTarifDiffusion;

    private BigDecimal valeur;
    private LocalDateTime daty;

    // Getters and Setters
    public Integer getIdTarifDiffusion() {
        return idTarifDiffusion;
    }

    public void setIdTarifDiffusion(Integer idTarifDiffusion) {
        this.idTarifDiffusion = idTarifDiffusion;
    }

    public BigDecimal getValeur() {
        return valeur;
    }

    public void setValeur(BigDecimal valeur) {
        this.valeur = valeur;
    }

    public LocalDateTime getDaty() {
        return daty;
    }

    public void setDaty(LocalDateTime daty) {
        this.daty = daty;
    }
}