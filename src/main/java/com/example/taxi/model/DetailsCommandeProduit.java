package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "details_commande_produit")
public class DetailsCommandeProduit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetailCommandeProduit;

    @ManyToOne
    @JoinColumn(name = "id_commande_produit")
    private CommandeProduit commandeProduit;

    @ManyToOne
    @JoinColumn(name = "id_produit")
    private Produit produit;

    @ManyToOne
    @JoinColumn(name = "id_voyage")
    private Voyage voyage;

    private Integer quantity;

    // Getters and Setters
    public Integer getIdDetailCommandeProduit() {
        return idDetailCommandeProduit;
    }

    public void setIdDetailCommandeProduit(Integer idDetailCommandeProduit) {
        this.idDetailCommandeProduit = idDetailCommandeProduit;
    }

    public CommandeProduit getCommandeProduit() {
        return commandeProduit;
    }

    public void setCommandeProduit(CommandeProduit commandeProduit) {
        this.commandeProduit = commandeProduit;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public Voyage getVoyage() {
        return voyage;
    }

    public void setVoyage(Voyage voyage) {
        this.voyage = voyage;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}