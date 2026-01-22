package com.example.taxi.service;

import com.example.taxi.model.DiffusionSociete;
import com.example.taxi.model.DiffusionSummary;
import com.example.taxi.model.Payement;
import com.example.taxi.model.Societe;
import com.example.taxi.model.TarifDiffusion;
import com.example.taxi.repository.DiffusionSocieteRepository;
import com.example.taxi.repository.PayementRepository;
import com.example.taxi.repository.TarifDiffusionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DiffusionService {

    @Autowired
    private DiffusionSocieteRepository diffusionSocieteRepository;

    @Autowired
    private TarifDiffusionRepository tarifDiffusionRepository;

    @Autowired
    private PayementRepository payementRepository;

    public List<DiffusionSociete> getAll() {
        return diffusionSocieteRepository.findAll();
    }

    public List<DiffusionSummary> getDiffusionSummaries(Integer idSociete, Integer month, Integer year, Integer idTrajet, Integer idVehicule) {
        List<DiffusionSociete> diffusions = diffusionSocieteRepository.findFiltered(idSociete, month, year, idTrajet, idVehicule);
        TarifDiffusion tarif = tarifDiffusionRepository.findById(1).orElse(null); // Assuming id=1
        BigDecimal prixDiffusion = tarif != null ? tarif.getValeur() : BigDecimal.ZERO;

        Map<Societe, List<DiffusionSociete>> grouped = new HashMap<>();
        for (DiffusionSociete d : diffusions) {
            grouped.computeIfAbsent(d.getSociete(), k -> new ArrayList<>()).add(d);
        }

        // Calculate payments per société
        List<Payement> payements = payementRepository.findAll();
        Map<Societe, BigDecimal> payeMap = new HashMap<>();
        for (Payement p : payements) {
            payeMap.merge(p.getSociete(), p.getMontant(), BigDecimal::add);
        }

        List<DiffusionSummary> summaries = new ArrayList<>();
        for (Map.Entry<Societe, List<DiffusionSociete>> entry : grouped.entrySet()) {
            Societe societe = entry.getKey();
            List<DiffusionSociete> societeDiffusions = entry.getValue();
            long nbDiffusion = societeDiffusions.size();
            BigDecimal ca = prixDiffusion.multiply(BigDecimal.valueOf(nbDiffusion));
            BigDecimal paye = payeMap.getOrDefault(societe, BigDecimal.ZERO);
            BigDecimal reste = ca.subtract(paye);
            summaries.add(new DiffusionSummary(societe, nbDiffusion, ca, prixDiffusion, paye, reste));
        }

        return summaries;
    }
}