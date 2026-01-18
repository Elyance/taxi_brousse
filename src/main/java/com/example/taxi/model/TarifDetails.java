package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;

@Entity
@Immutable
@Table(name = "tarif_details")
public class TarifDetails {

    @Id
    private Integer idTarif;

    private Integer idTrajet;
    private String categoriePlace;
    private BigDecimal prix;

    // Getters
    public Integer getIdTarif() {
        return idTarif;
    }

    public Integer getIdTrajet() {
        return idTrajet;
    }

    public String getCategoriePlace() {
        return categoriePlace;
    }

    public BigDecimal getPrix() {
        return prix;
    }
}