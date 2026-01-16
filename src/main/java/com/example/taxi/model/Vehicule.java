package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "vehicule")
public class Vehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idVehicule;

    private String immatriculation;
    private Integer nbPlace;

    @ManyToOne
    @JoinColumn(name = "id_vehicule_modele")
    private VehiculeModele vehiculeModele;

    // Getters and Setters
    public Integer getIdVehicule() {
        return idVehicule;
    }

    public void setIdVehicule(Integer idVehicule) {
        this.idVehicule = idVehicule;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public Integer getNbPlace() {
        return nbPlace;
    }

    public void setNbPlace(Integer nbPlace) {
        this.nbPlace = nbPlace;
    }

    public VehiculeModele getVehiculeModele() {
        return vehiculeModele;
    }

    public void setVehiculeModele(VehiculeModele vehiculeModele) {
        this.vehiculeModele = vehiculeModele;
    }
}