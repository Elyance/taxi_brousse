package com.example.taxi.service;

import com.example.taxi.model.Admin;
import com.example.taxi.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    public Admin authenticate(String nom, String motDePasse) {
        Admin admin = adminRepository.findByNom(nom).orElse(null);
        if (admin != null && admin.getMotDePasse().equals(motDePasse)) {
            return admin;
        }
        return null;
    }
}