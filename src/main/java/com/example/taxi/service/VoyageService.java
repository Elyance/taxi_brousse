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
    private RemiseClientRepository remiseClientRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @Autowired
    private TarifRepository tarifRepository;

    @Autowired
    private TarifClientRepository tarifClientRepository;

    @Autowired
    private StatutPlaceRepository statutPlaceRepository;




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

    public BigDecimal getPrixForPlaceAndClientAvecRemise(Trajet trajet, CategoriePlace categoriePlace, CategorieClient categorieClient) {
        BigDecimal prixInitial = getPrixForPlaceAndClient(trajet, categoriePlace, categorieClient);

        if (categorieClient != null) {
            List<RemiseClient> remiseOpt = remiseClientRepository.findByCategorieClient_IdCategorieClient(categorieClient.getIdCategorieClient());
            if (!remiseOpt.isEmpty() && remiseOpt.get(0) != null ) {
                RemiseClient remiseClient = remiseOpt.get(0);
                BigDecimal prix_ref = getPrixForPlaceAndClient(trajet, categoriePlace, remiseClient.getCategorieReference());
                if (prix_ref.compareTo(BigDecimal.ZERO) == 0) {
                    return prixInitial;
                } 
                BigDecimal remise = remiseClient.getPourcentageRemise().multiply(prix_ref).divide(BigDecimal.valueOf(100));
                BigDecimal prix = prix_ref.subtract(remise);  
                return prix;
            }
        }

        return prixInitial;
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

    public void reserverPlace(Integer placeId) {
        Optional<Place> placeOpt = placeRepository.findById(placeId);
        if (placeOpt.isPresent()) {
            Place place = placeOpt.get();
            // Trouver le statut "Reservee" (id = 2)
            Optional<StatutPlace> statutReservee = statutPlaceRepository.findById(2);
            if (statutReservee.isPresent()) {
                place.setStatutPlace(statutReservee.get());
                placeRepository.save(place);
            }
        }
    }
}