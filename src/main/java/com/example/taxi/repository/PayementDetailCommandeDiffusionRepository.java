package com.example.taxi.repository;

import com.example.taxi.model.Voyage;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.taxi.model.PayementDetailCommandeDiffusion;
import com.example.taxi.model.DetailsCommandeDiffusion;

import java.util.List;

@Repository
public interface PayementDetailCommandeDiffusionRepository extends JpaRepository<PayementDetailCommandeDiffusion, Integer> {

    List<PayementDetailCommandeDiffusion> findByDetailsCommandeDiffusion(DetailsCommandeDiffusion detailsCommandeDiffusion);

    @Query("SELECT p FROM PayementDetailCommandeDiffusion p WHERE p.detailsCommandeDiffusion.voyage = :voyage")
    List<PayementDetailCommandeDiffusion> findByVoyage(Voyage voyage);

}