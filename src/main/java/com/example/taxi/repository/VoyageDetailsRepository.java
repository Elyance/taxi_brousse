package com.example.taxi.repository;

import com.example.taxi.model.VoyageDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoyageDetailsRepository extends JpaRepository<VoyageDetails, Integer> {
}