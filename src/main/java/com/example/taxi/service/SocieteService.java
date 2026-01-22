package com.example.taxi.service;

import com.example.taxi.model.Societe;
import com.example.taxi.repository.SocieteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SocieteService {

    @Autowired
    private SocieteRepository societeRepository;

    public List<Societe> getAll() {
        return societeRepository.findAll();
    }
}