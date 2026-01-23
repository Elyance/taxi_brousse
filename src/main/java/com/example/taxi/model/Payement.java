package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payement")
public class Payement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPayement;

    private BigDecimal montant;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime datePayement;

    @ManyToOne
    @JoinColumn(name = "id_commande_diffusion")
    private CommandeDiffusion commandeDiffusion;

    // Getters and Setters
    public Integer getIdPayement() {
        return idPayement;
    }

    public void setIdPayement(Integer idPayement) {
        this.idPayement = idPayement;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public LocalDateTime getDatePayement() {
        return datePayement;
    }

    public void setDatePayement(LocalDateTime datePayement) {
        this.datePayement = datePayement;
    }

    public CommandeDiffusion getCommandeDiffusion() {
        return commandeDiffusion;
    }

    public void setCommandeDiffusion(CommandeDiffusion commandeDiffusion) {
        this.commandeDiffusion = commandeDiffusion;
    }
}