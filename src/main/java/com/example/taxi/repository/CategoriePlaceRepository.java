package com.example.taxi.repository;

import com.example.taxi.model.CategoriePlace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoriePlaceRepository extends JpaRepository<CategoriePlace, Integer> {
}