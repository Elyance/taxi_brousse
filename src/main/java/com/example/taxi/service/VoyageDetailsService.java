package com.example.taxi.service;

import com.example.taxi.model.VoyageDetails;
import com.example.taxi.repository.VoyageDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VoyageDetailsService {

    @Autowired
    private VoyageDetailsRepository voyageDetailsRepository;

    public List<VoyageDetails> getAllVoyageDetails() {
        return voyageDetailsRepository.findAll();
    }
}