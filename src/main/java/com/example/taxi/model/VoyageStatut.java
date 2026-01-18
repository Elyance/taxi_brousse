package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "voyage_statut")
public class VoyageStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idVoyageStatut;

    private String libelle;

    // Getters and Setters
    public Integer getIdVoyageStatut() {
        return idVoyageStatut;
    }

    public void setIdVoyageStatut(Integer idVoyageStatut) {
        this.idVoyageStatut = idVoyageStatut;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}