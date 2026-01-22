package com.example.taxi.controller;

import com.example.taxi.model.DiffusionSummary;
import com.example.taxi.service.DiffusionService;
import com.example.taxi.service.SocieteService;
import com.example.taxi.service.TrajetService;
import com.example.taxi.service.VoyageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/diffusion")
public class DiffusionController {

    @Autowired
    private DiffusionService diffusionService;

    @Autowired
    private SocieteService societeService;

    @Autowired
    private TrajetService trajetService;

    @Autowired
    private VoyageService voyageService;

    @GetMapping("/list")
    public String list(HttpSession session, Model model,
                       @RequestParam(required = false) Integer idSociete,
                       @RequestParam(required = false) Integer month,
                       @RequestParam(required = false) Integer year,
                       @RequestParam(required = false) Integer idTrajet,
                       @RequestParam(required = false) Integer idVehicule) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<DiffusionSummary> summaries = diffusionService.getDiffusionSummaries(idSociete, month, year, idTrajet, idVehicule);

        long totalNbDiffusion = summaries.stream().mapToLong(DiffusionSummary::getNbDiffusion).sum();
        BigDecimal totalCA = summaries.stream().map(DiffusionSummary::getChiffreAffaire).reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("summaries", summaries);
        model.addAttribute("totalNbDiffusion", totalNbDiffusion);
        model.addAttribute("totalCA", totalCA);
        model.addAttribute("societes", societeService.getAll());
        model.addAttribute("trajets", trajetService.getAllTrajets());
        model.addAttribute("vehicules", voyageService.getAllVoyages().stream()
                .map(v -> v.getVehicule())
                .distinct()
                .collect(Collectors.toList()));

        model.addAttribute("pageTitle", "Liste des Diffusions");
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/list.jsp");
        return "includes/layout";
    }
}