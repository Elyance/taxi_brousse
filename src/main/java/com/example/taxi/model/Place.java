package com.example.taxi.model;

public class Place {
    private int numeroPlace;
    private String categorie;
    private boolean reserved;

    public Place() {}

    public Place(int numeroPlace, String categorie, boolean reserved) {
        this.numeroPlace = numeroPlace;
        this.categorie = categorie;
        this.reserved = reserved;
    }

    public int getNumeroPlace() {
        return numeroPlace;
    }

    public void setNumeroPlace(int numeroPlace) {
        this.numeroPlace = numeroPlace;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public boolean isReserved() {
        return reserved;
    }

    public void setReserved(boolean reserved) {
        this.reserved = reserved;
    }
}