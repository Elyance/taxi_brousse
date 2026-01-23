package com.example.taxi.service;

import com.example.taxi.model.Payement;
import com.example.taxi.repository.PayementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PayementService {

    @Autowired
    private PayementRepository payementRepository;

    public List<Payement> getAll() {
        return payementRepository.findAll();
    }

    public Payement save(Payement payement) {
        return payementRepository.save(payement);
    }
}