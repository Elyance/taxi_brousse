package com.example.taxi.service;

import com.example.taxi.model.*;
import com.example.taxi.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class VoyageService {

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private CategoriePlaceRepository categoriePlaceRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @Autowired
    private TarifRepository tarifRepository;

    @Autowired
    private TarifClientRepository tarifClientRepository;


    public List<Voyage> getAllVoyages() {
        return voyageRepository.findAllWithDetails();
    }

    public Optional<Voyage> getVoyageById(Integer id) {
        return voyageRepository.findById(id);
    }

    public List<Place> getPlacesForVoyage(Integer voyageId) {
        Optional<Voyage> voyageOpt = voyageRepository.findById(voyageId);
        if (voyageOpt.isEmpty()) {
            return List.of();
        }
        Voyage voyage = voyageOpt.get();
        return placeRepository.findByVehiculeIdVehiculeOrderByNumeroPlace(voyage.getVehicule().getIdVehicule());
    }

    public List<Tarif> getTarifsForTrajet(Trajet trajet) {
        return tarifRepository.findByTrajet(trajet);
    }

    public BigDecimal getPrixForPlaceAndClient(Trajet trajet, CategoriePlace categoriePlace, CategorieClient categorieClient) {
        // Trouver le tarif de base pour cette catégorie de place
        Tarif tarifBase = tarifRepository.findByTrajet(trajet).stream()
                .filter(t -> t.getCategoriePlace().equals(categoriePlace))
                .findFirst()
                .orElse(null);

        if (tarifBase == null) {
            return BigDecimal.ZERO;
        }

        // Si on a une catégorie de client, chercher un tarif spécifique
        if (categorieClient != null) {
            Optional<TarifClient> tarifClientOpt = tarifClientRepository.findByTarifAndCategorieClient(tarifBase, categorieClient);
            if (tarifClientOpt.isPresent()) {
                return tarifClientOpt.get().getPrix();
            }
        }

        // Sinon retourner le tarif de base
        return tarifBase.getPrix();
    }

    public BigDecimal getPrixForClient(Tarif tarif, CategorieClient categorieClient) {
        if (categorieClient != null) {
            Optional<TarifClient> tarifClientOpt = tarifClientRepository.findByTarifAndCategorieClient(tarif, categorieClient);
            if (tarifClientOpt.isPresent()) {
                return tarifClientOpt.get().getPrix();
            }
        }
        // Retourner le prix par défaut si pas de tarif spécifique pour la catégorie
        return tarif.getPrix();
    }
}