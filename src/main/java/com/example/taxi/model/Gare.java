package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "gare")
public class Gare {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idGare;

    private String nom;
    private String adresse;

    @ManyToOne
    @JoinColumn(name = "id_ville")
    private Ville ville;

    // Getters and Setters
    public Integer getIdGare() {
        return idGare;
    }

    public void setIdGare(Integer idGare) {
        this.idGare = idGare;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public Ville getVille() {
        return ville;
    }

    public void setVille(Ville ville) {
        this.ville = ville;
    }
}