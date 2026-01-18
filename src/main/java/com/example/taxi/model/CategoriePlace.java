package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "categorie_place")
public class CategoriePlace {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCategoriePlace;

    private String libelle;

    // Getters and Setters
    public Integer getIdCategoriePlace() {
        return idCategoriePlace;
    }

    public void setIdCategoriePlace(Integer idCategoriePlace) {
        this.idCategoriePlace = idCategoriePlace;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}