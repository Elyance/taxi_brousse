package com.example.taxi.repository;

import com.example.taxi.model.Voyage;
import com.example.taxi.model.DetailsCommandeDiffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DetailsCommandeDiffusionRepository extends JpaRepository<DetailsCommandeDiffusion, Integer> {

    List<DetailsCommandeDiffusion> findByVoyage(Voyage voyage);

}