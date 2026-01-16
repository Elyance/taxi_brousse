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
@Table(name = "tarif_client")
public class TarifClient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTarifClient;

    private BigDecimal prix;

    @ManyToOne
    @JoinColumn(name = "id_tarif")
    private Tarif tarif;

    @ManyToOne
    @JoinColumn(name = "id_categorie_client")
    private CategorieClient categorieClient;

    // Getters and Setters
    public Integer getIdTarifClient() {
        return idTarifClient;
    }

    public void setIdTarifClient(Integer idTarifClient) {
        this.idTarifClient = idTarifClient;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    public Tarif getTarif() {
        return tarif;
    }

    public void setTarif(Tarif tarif) {
        this.tarif = tarif;
    }

    public CategorieClient getCategorieClient() {
        return categorieClient;
    }

    public void setCategorieClient(CategorieClient categorieClient) {
        this.categorieClient = categorieClient;
    }
}