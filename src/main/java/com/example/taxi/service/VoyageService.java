package com.example.taxi.service;

import com.example.taxi.model.Voyage;
import com.example.taxi.model.VoyageDetails;
import com.example.taxi.model.Trajet;
import com.example.taxi.repository.VoyageRepository;
import com.example.taxi.repository.VoyageDetailsRepository;
import com.example.taxi.repository.TrajetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VoyageService {

    @Autowired
    private VoyageRepository voyageRepository;

    @Autowired
    private VoyageDetailsRepository voyageDetailsRepository;

    @Autowired
    private TrajetRepository trajetRepository;

    public List<Voyage> getAllVoyages() {
        return voyageRepository.findAllWithDetails();
    }

    public List<VoyageDetails> getAllVoyageDetails() {
        return voyageDetailsRepository.findAll();
    }

    public List<Trajet> getAllTrajets() {
        return trajetRepository.findAll();
    }

    public Optional<Voyage> getVoyageById(Integer id) {
        return voyageRepository.findById(id);
    }
}