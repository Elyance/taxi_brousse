package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "statut_place")
public class StatutPlace {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idStatutPlace;

    private String libelle;

    // Getters and Setters
    public Integer getIdStatutPlace() {
        return idStatutPlace;
    }

    public void setIdStatutPlace(Integer idStatutPlace) {
        this.idStatutPlace = idStatutPlace;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}