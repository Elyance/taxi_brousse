package com.example.taxi.model;

import java.math.BigDecimal;

public class TarifWithClientPrice {
    private Tarif tarif;
    private BigDecimal prixForClient;

    public TarifWithClientPrice(Tarif tarif, BigDecimal prixForClient) {
        this.tarif = tarif;
        this.prixForClient = prixForClient;
    }

    public Tarif getTarif() {
        return tarif;
    }

    public void setTarif(Tarif tarif) {
        this.tarif = tarif;
    }

    public BigDecimal getPrixForClient() {
        return prixForClient;
    }

    public void setPrixForClient(BigDecimal prixForClient) {
        this.prixForClient = prixForClient;
    }
}