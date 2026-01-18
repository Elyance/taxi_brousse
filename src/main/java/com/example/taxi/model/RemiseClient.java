package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;

import java.math.BigDecimal;

@Entity
@Table(name = "remise_client")
public class RemiseClient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_remise_client")
    private Integer idRemiseClient;

    @Column(name = "pourcentage_remise", nullable = false, precision = 5, scale = 2)
    private BigDecimal pourcentageRemise;

    @ManyToOne
    @JoinColumn(name = "id_categorie_client", nullable = false)
    private CategorieClient categorieClient;

    @ManyToOne
    @JoinColumn(name = "id_categorie_reference", nullable = false)
    private CategorieClient categorieReference;

    // ======================
    // GETTERS & SETTERS
    // ======================

    public Integer getIdRemiseClient() {
        return idRemiseClient;
    }

    public void setIdRemiseClient(Integer idRemiseClient) {
        this.idRemiseClient = idRemiseClient;
    }

    public BigDecimal getPourcentageRemise() {
        return pourcentageRemise;
    }

    public void setPourcentageRemise(BigDecimal pourcentageRemise) {
        this.pourcentageRemise = pourcentageRemise;
    }

    public CategorieClient getCategorieClient() {
        return categorieClient;
    }

    public void setCategorieClient(CategorieClient categorieClient) {
        this.categorieClient = categorieClient;
    }

    public CategorieClient getCategorieReference() {
        return categorieReference;
    }

    public void setCategorieReference(CategorieClient categorieReference) {
        this.categorieReference = categorieReference;
    }
}