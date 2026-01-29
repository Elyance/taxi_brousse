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
@Table(name = "paiement_commande_produit")
public class PaiementCommandeProduit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPaiementCommandeProduit;

    @ManyToOne
    @JoinColumn(name = "id_commande_produit")
    private CommandeProduit commandeProduit;

    private BigDecimal montant;
    private LocalDateTime datePaiement;

    // Getters and Setters
    public Integer getIdPaiementCommandeProduit() {
        return idPaiementCommandeProduit;
    }

    public void setIdPaiementCommandeProduit(Integer idPaiementCommandeProduit) {
        this.idPaiementCommandeProduit = idPaiementCommandeProduit;
    }

    public CommandeProduit getCommandeProduit() {
        return commandeProduit;
    }

    public void setCommandeProduit(CommandeProduit commandeProduit) {
        this.commandeProduit = commandeProduit;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public LocalDateTime getDatePaiement() {
        return datePaiement;
    }

    public void setDatePaiement(LocalDateTime datePaiement) {
        this.datePaiement = datePaiement;
    }
}