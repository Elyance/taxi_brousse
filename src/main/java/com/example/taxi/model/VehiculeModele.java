package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "vehicule_modele")
public class VehiculeModele {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idVehiculeModele;

    private String modele;

    // Getters and Setters
    public Integer getIdVehiculeModele() {
        return idVehiculeModele;
    }

    public void setIdVehiculeModele(Integer idVehiculeModele) {
        this.idVehiculeModele = idVehiculeModele;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }
}