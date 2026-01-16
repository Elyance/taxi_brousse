package com.example.taxi.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "place")
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPlace;

    @Column(name = "numero")
    private String numeroPlace;

    @ManyToOne
    @JoinColumn(name = "id_vehicule")
    private Vehicule vehicule;

    @ManyToOne
    @JoinColumn(name = "id_categorie_place")
    private CategoriePlace categoriePlace;

    @ManyToOne
    @JoinColumn(name = "id_statut_place")
    private StatutPlace statutPlace;

    public Place() {}

    // Getters and Setters
    public Integer getIdPlace() {
        return idPlace;
    }

    public void setIdPlace(Integer idPlace) {
        this.idPlace = idPlace;
    }

    public String getNumeroPlace() {
        return numeroPlace;
    }

    public void setNumeroPlace(String numeroPlace) {
        this.numeroPlace = numeroPlace;
    }

    public Vehicule getVehicule() {
        return vehicule;
    }

    public void setVehicule(Vehicule vehicule) {
        this.vehicule = vehicule;
    }

    public CategoriePlace getCategoriePlace() {
        return categoriePlace;
    }

    public void setCategoriePlace(CategoriePlace categoriePlace) {
        this.categoriePlace = categoriePlace;
    }

    public StatutPlace getStatutPlace() {
        return statutPlace;
    }

    public void setStatutPlace(StatutPlace statutPlace) {
        this.statutPlace = statutPlace;
    }

    // For backward compatibility
    public String getNumero() {
        return numeroPlace;
    }

    @Transient
    public String getCategorie() {
        return categoriePlace != null ? categoriePlace.getLibelle() : "Standard";
    }

    @Transient
    public boolean isReserved() {
        return statutPlace != null && !"Libre".equals(statutPlace.getLibelle());
    }
}