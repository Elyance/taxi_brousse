package com.example.taxi.repository;

import com.example.taxi.model.RemiseClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RemiseClientRepository extends JpaRepository<RemiseClient, Integer> {

    List<RemiseClient> findByCategorieClient_IdCategorieClient(Integer idCategorieClient);
}