package com.example.taxi.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Immutable
@Table(name = "voyage_details")
public class VoyageDetails {

    @Id
    private Integer idVoyage;

    private Date dateDepart;
    private Integer idTrajet;

    private String chauffeurNom;
    private String chauffeurPrenom;
    private String chauffeurTelephone;

    private String immatriculation;
    private String vehiculeModele;

    private String gareDepart;
    private String gareDepartAdresse;
    private String villeDepart;

    private String gareArrivee;
    private String gareArriveeAdresse;
    private String villeArrivee;

    private BigDecimal distanceKm;
    private BigDecimal dureeEstimeeMinutes;

    private String statutVoyage;

    private BigDecimal tarifPrix;

    // Getters
    public Integer getIdVoyage() {
        return idVoyage;
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public Integer getIdTrajet() {
        return idTrajet;
    }

    public String getChauffeurNom() {
        return chauffeurNom;
    }

    public String getChauffeurPrenom() {
        return chauffeurPrenom;
    }

    public String getChauffeurTelephone() {
        return chauffeurTelephone;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public String getVehiculeModele() {
        return vehiculeModele;
    }

    public String getGareDepart() {
        return gareDepart;
    }

    public String getGareDepartAdresse() {
        return gareDepartAdresse;
    }

    public String getVilleDepart() {
        return villeDepart;
    }

    public String getGareArrivee() {
        return gareArrivee;
    }

    public String getGareArriveeAdresse() {
        return gareArriveeAdresse;
    }

    public String getVilleArrivee() {
        return villeArrivee;
    }

    public BigDecimal getDistanceKm() {
        return distanceKm;
    }

    public BigDecimal getDureeEstimeeMinutes() {
        return dureeEstimeeMinutes;
    }

    public String getStatutVoyage() {
        return statutVoyage;
    }

    public BigDecimal getTarifPrix() {
        return tarifPrix;
    }
}