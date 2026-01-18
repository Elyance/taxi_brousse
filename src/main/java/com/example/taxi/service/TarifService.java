package com.example.taxi.service;

import com.example.taxi.model.TarifDetails;
import com.example.taxi.repository.TarifDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TarifService {

    @Autowired
    private TarifDetailsRepository tarifDetailsRepository;

    public List<TarifDetails> getTarifsByTrajet(Integer idTrajet) {
        return tarifDetailsRepository.findByIdTrajet(idTrajet);
    }
}