package com.example.taxi.service;

import com.example.taxi.model.VDiffusionDetails;
import com.example.taxi.model.DiffusionSummary;
import com.example.taxi.model.Societe;
import com.example.taxi.repository.VDiffusionDetailsRepository;
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
    private VDiffusionDetailsRepository vDiffusionDetailsRepository;

    public List<DiffusionSummary> getDiffusionSummaries(Integer idSociete, Integer month, Integer year, Integer idTrajet, Integer idVehicule) {
        List<VDiffusionDetails> details = vDiffusionDetailsRepository.findFiltered(idSociete, month, year, idTrajet, idVehicule);

        // Group by societe
        Map<Integer, Societe> societeMap = new HashMap<>();
        Map<Integer, Long> nbDiffusionMap = new HashMap<>();
        Map<Integer, BigDecimal> caMap = new HashMap<>();
        Map<Integer, BigDecimal> payeMap = new HashMap<>();
        Map<Integer, BigDecimal> prixDiffusionMap = new HashMap<>();

        for (VDiffusionDetails d : details) {
            Integer societeId = d.getIdSociete();
            Societe societe = societeMap.computeIfAbsent(societeId, k -> {
                Societe s = new Societe();
                s.setIdSociete(societeId);
                s.setLibelle(d.getSocieteLibelle());
                return s;
            });
            nbDiffusionMap.merge(societeId, d.getNbDiffusion().longValue(), Long::sum);
            caMap.merge(societeId, d.getChiffreAffaire(), BigDecimal::add);
            payeMap.merge(societeId, d.getPaye(), BigDecimal::add);
            // Prix diffusion, take the first one
            prixDiffusionMap.putIfAbsent(societeId, d.getPrixDiffusion());
        }

        List<DiffusionSummary> summaries = new ArrayList<>();
        for (Integer societeId : societeMap.keySet()) {
            Societe societe = societeMap.get(societeId);
            Long nbDiffusion = nbDiffusionMap.get(societeId);
            BigDecimal ca = caMap.get(societeId);
            BigDecimal paye = payeMap.get(societeId);
            BigDecimal prixDiffusion = prixDiffusionMap.get(societeId);
            BigDecimal reste = ca.subtract(paye);
            summaries.add(new DiffusionSummary(societe, nbDiffusion, ca, prixDiffusion, paye, reste));
        }

        return summaries;
    }
}