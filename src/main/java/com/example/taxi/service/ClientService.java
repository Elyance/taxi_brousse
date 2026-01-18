package com.example.taxi.service;

import com.example.taxi.model.CategorieClient;
import com.example.taxi.model.Client;
import com.example.taxi.repository.CategorieClientRepository;
import com.example.taxi.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientService {

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private CategorieClientRepository categorieClientRepository;

    public List<Client> getAllClients() {
        return clientRepository.findAll();
    }

    public Client saveClient(Client client) {
        return clientRepository.save(client);
    }

    public List<CategorieClient> getAllCategories() {
        return categorieClientRepository.findAll();
    }
}