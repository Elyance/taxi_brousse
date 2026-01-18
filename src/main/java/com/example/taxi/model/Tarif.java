package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.math.BigDecimal;

@Entity
@Table(name = "tarif")
public class Tarif {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTarif;

    private BigDecimal prix;

    @ManyToOne
    @JoinColumn(name = "id_trajet")
    private Trajet trajet;

    @ManyToOne
    @JoinColumn(name = "id_categorie_place")
    private CategoriePlace categoriePlace;

    // Getters and Setters
    public Integer getIdTarif() {
        return idTarif;
    }

    public void setIdTarif(Integer idTarif) {
        this.idTarif = idTarif;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    public Trajet getTrajet() {
        return trajet;
    }

    public void setTrajet(Trajet trajet) {
        this.trajet = trajet;
    }

    public CategoriePlace getCategoriePlace() {
        return categoriePlace;
    }

    public void setCategoriePlace(CategoriePlace categoriePlace) {
        this.categoriePlace = categoriePlace;
    }
}