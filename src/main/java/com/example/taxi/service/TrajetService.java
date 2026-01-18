package com.example.taxi.service;

import com.example.taxi.model.Trajet;
import com.example.taxi.repository.TrajetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrajetService {

    @Autowired
    private TrajetRepository trajetRepository;

    public List<Trajet> getAllTrajets() {
        return trajetRepository.findAll();
    }
}