package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "commande_produit")
public class CommandeProduit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCommandeProduit;

    @ManyToOne
    @JoinColumn(name = "id_client")
    private Client client;

    private BigDecimal montantTotal;
    private LocalDateTime dateCommande;

    // Getters and Setters
    public Integer getIdCommandeProduit() {
        return idCommandeProduit;
    }

    public void setIdCommandeProduit(Integer idCommandeProduit) {
        this.idCommandeProduit = idCommandeProduit;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public BigDecimal getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(BigDecimal montantTotal) {
        this.montantTotal = montantTotal;
    }

    public LocalDateTime getDateCommande() {
        return dateCommande;
    }

    public void setDateCommande(LocalDateTime dateCommande) {
        this.dateCommande = dateCommande;
    }
}