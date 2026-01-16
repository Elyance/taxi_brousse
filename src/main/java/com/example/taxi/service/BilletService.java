package com.example.taxi.service;

import com.example.taxi.model.Billet;
import com.example.taxi.repository.BilletRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class BilletService {

    @Autowired
    private BilletRepository billetRepository;

    public List<Billet> getAllBillets() {
        return billetRepository.findAllWithDetails();
    }

    public Optional<Billet> getBilletById(Integer id) {
        return billetRepository.findById(id);
    }

    public Billet saveBillet(Billet billet) {
        // Generate a unique code for the billet if not set
        if (billet.getCodeBillet() == null || billet.getCodeBillet().isEmpty()) {
            billet.setCodeBillet(generateCodeBillet());
        }
        return billetRepository.save(billet);
    }

    public void deleteBillet(Integer id) {
        billetRepository.deleteById(id);
    }

    private String generateCodeBillet() {
        return "BILLET-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
