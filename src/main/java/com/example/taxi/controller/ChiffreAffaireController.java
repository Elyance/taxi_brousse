package com.example.taxi.controller;

import com.example.taxi.model.*;
import com.example.taxi.repository.*;
import com.example.taxi.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/ca")
public class ChiffreAffaireController {

    // Classe pour résumer les chiffres d'affaires
    public static class ChiffreAffaireSummary {
        private BigDecimal montantProduit;
        private BigDecimal montantBillet;
        private BigDecimal montantDiffusion;
        private BigDecimal totalChiffreAffaire;
        private Integer nombreBillets;
        private Integer nombreCommandesProduit;
        private Integer nombreDiffusions;

        // Getters and setters
        public BigDecimal getMontantProduit() { return montantProduit; }
        public void setMontantProduit(BigDecimal montantProduit) { this.montantProduit = montantProduit; }

        public BigDecimal getMontantBillet() { return montantBillet; }
        public void setMontantBillet(BigDecimal montantBillet) { this.montantBillet = montantBillet; }

        public BigDecimal getMontantDiffusion() { return montantDiffusion; }
        public void setMontantDiffusion(BigDecimal montantDiffusion) { this.montantDiffusion = montantDiffusion; }

        public BigDecimal getTotalChiffreAffaire() { return totalChiffreAffaire; }
        public void setTotalChiffreAffaire(BigDecimal totalChiffreAffaire) { this.totalChiffreAffaire = totalChiffreAffaire; }

        public Integer getNombreBillets() { return nombreBillets; }
        public void setNombreBillets(Integer nombreBillets) { this.nombreBillets = nombreBillets; }

        public Integer getNombreCommandesProduit() { return nombreCommandesProduit; }
        public void setNombreCommandesProduit(Integer nombreCommandesProduit) { this.nombreCommandesProduit = nombreCommandesProduit; }

        public Integer getNombreDiffusions() { return nombreDiffusions; }
        public void setNombreDiffusions(Integer nombreDiffusions) { this.nombreDiffusions = nombreDiffusions; }
    }

    @Autowired
    private CommandeProduitRepository commandeProduitRepository;

    @Autowired
    private BilletRepository billetRepository;

    @Autowired
    private DetailsCommandeDiffusionRepository detailsCommandeDiffusionRepository;

    @Autowired
    private DetailsCommandeProduitRepository detailsCommandeProduitRepository;

    @Autowired
    private VoyageService voyageService;

    @GetMapping("/list")
    public String list(HttpSession session, Model model,
                       @RequestParam(required = false) String dateDebut,
                       @RequestParam(required = false) String dateFin) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        // Calculer les montants avec filtres de date
        ChiffreAffaireSummary summary = new ChiffreAffaireSummary();

        // 1. Montant Produit-Extra (commandes de produits payées)
        BigDecimal montantProduit = BigDecimal.ZERO;
        List<CommandeProduit> commandesProduit = commandeProduitRepository.findAll();

        // Appliquer filtre date sur commandes produit
        if (dateDebut != null && !dateDebut.isEmpty()) {
            try {
                LocalDate debut = LocalDate.parse(dateDebut);
                commandesProduit = commandesProduit.stream()
                        .filter(cp -> {
                            LocalDate commandeDate = cp.getDateCommande().toLocalDate();
                            return commandeDate.isEqual(debut) || commandeDate.isAfter(debut);
                        })
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        if (dateFin != null && !dateFin.isEmpty()) {
            try {
                LocalDate fin = LocalDate.parse(dateFin);
                commandesProduit = commandesProduit.stream()
                        .filter(cp -> {
                            LocalDate commandeDate = cp.getDateCommande().toLocalDate();
                            return commandeDate.isEqual(fin) || commandeDate.isBefore(fin);
                        })
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        // Somme des montants des commandes produit (toutes, pas seulement payées)
        montantProduit = commandesProduit.stream()
                .map(CommandeProduit::getMontantTotal)
                .filter(m -> m != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        summary.setMontantProduit(montantProduit);
        summary.setNombreCommandesProduit(commandesProduit.size());

        // 2. Montant Billet-Total
        BigDecimal montantBillet = BigDecimal.ZERO;
        List<Billet> billets = billetRepository.findAll();

        // Appliquer filtre date sur billets (via voyage)
        if (dateDebut != null && !dateDebut.isEmpty() || dateFin != null && !dateFin.isEmpty()) {
            List<Voyage> voyages = voyageService.getAllVoyages();

            if (dateDebut != null && !dateDebut.isEmpty()) {
                try {
                    LocalDate debut = LocalDate.parse(dateDebut);
                    voyages = voyages.stream()
                            .filter(v -> {
                                LocalDate voyageDate = v.getDateDepart().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                                return voyageDate.isEqual(debut) || voyageDate.isAfter(debut);
                            })
                            .collect(Collectors.toList());
                } catch (Exception e) {
                    // Ignore invalid date format
                }
            }

            if (dateFin != null && !dateFin.isEmpty()) {
                try {
                    LocalDate fin = LocalDate.parse(dateFin);
                    voyages = voyages.stream()
                            .filter(v -> {
                                LocalDate voyageDate = v.getDateDepart().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                                return voyageDate.isEqual(fin) || voyageDate.isBefore(fin);
                            })
                            .collect(Collectors.toList());
                } catch (Exception e) {
                    // Ignore invalid date format
                }
            }

            List<Integer> voyageIds = voyages.stream().map(Voyage::getIdVoyage).collect(Collectors.toList());
            billets = billets.stream()
                    .filter(b -> voyageIds.contains(b.getVoyage().getIdVoyage()))
                    .collect(Collectors.toList());
        }

        montantBillet = billets.stream()
                .map(Billet::getMontantTotal)
                .filter(m -> m != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        summary.setMontantBillet(montantBillet);
        summary.setNombreBillets(billets.size());

        // 3. Montant Diffusion
        BigDecimal montantDiffusion = BigDecimal.ZERO;
        List<DetailsCommandeDiffusion> detailsDiffusion = detailsCommandeDiffusionRepository.findAll();

        // Appliquer filtre date sur diffusions (via voyage)
        if (dateDebut != null && !dateDebut.isEmpty() || dateFin != null && !dateFin.isEmpty()) {
            List<Voyage> voyages = voyageService.getAllVoyages();

            if (dateDebut != null && !dateDebut.isEmpty()) {
                try {
                    LocalDate debut = LocalDate.parse(dateDebut);
                    voyages = voyages.stream()
                            .filter(v -> {
                                LocalDate voyageDate = v.getDateDepart().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                                return voyageDate.isEqual(debut) || voyageDate.isAfter(debut);
                            })
                            .collect(Collectors.toList());
                } catch (Exception e) {
                    // Ignore invalid date format
                }
            }

            if (dateFin != null && !dateFin.isEmpty()) {
                try {
                    LocalDate fin = LocalDate.parse(dateFin);
                    voyages = voyages.stream()
                            .filter(v -> {
                                LocalDate voyageDate = v.getDateDepart().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                                return voyageDate.isEqual(fin) || voyageDate.isBefore(fin);
                            })
                            .collect(Collectors.toList());
                } catch (Exception e) {
                    // Ignore invalid date format
                }
            }

            List<Integer> voyageIds = voyages.stream().map(Voyage::getIdVoyage).collect(Collectors.toList());
            detailsDiffusion = detailsDiffusion.stream()
                    .filter(d -> voyageIds.contains(d.getVoyage().getIdVoyage()))
                    .collect(Collectors.toList());
        }

        montantDiffusion = detailsDiffusion.stream()
                .map(d -> d.getPrixDiffusion() != null ? d.getPrixDiffusion().multiply(BigDecimal.valueOf(d.getNbDiffusion())) : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        summary.setMontantDiffusion(montantDiffusion);
        summary.setNombreDiffusions(detailsDiffusion.size());

        // Total Chiffre d'Affaire
        BigDecimal totalCA = montantProduit.add(montantBillet).add(montantDiffusion);
        summary.setTotalChiffreAffaire(totalCA);

        model.addAttribute("summary", summary);
        model.addAttribute("pageTitle", "Chiffres d'Affaires");
        model.addAttribute("contentPage", "/WEB-INF/jsp/ca/list.jsp");
        return "includes/layout";
    }

    @GetMapping("/produits")
    public String detailsProduits(HttpSession session, Model model,
                                   @RequestParam(required = false) String dateDebut,
                                   @RequestParam(required = false) String dateFin) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<CommandeProduit> commandesProduit = commandeProduitRepository.findAll();

        // Appliquer filtre date sur commandes produit
        if (dateDebut != null && !dateDebut.isEmpty()) {
            try {
                LocalDate debut = LocalDate.parse(dateDebut);
                commandesProduit = commandesProduit.stream()
                        .filter(cp -> {
                            LocalDate commandeDate = cp.getDateCommande().toLocalDate();
                            return commandeDate.isEqual(debut) || commandeDate.isAfter(debut);
                        })
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        if (dateFin != null && !dateFin.isEmpty()) {
            try {
                LocalDate fin = LocalDate.parse(dateFin);
                commandesProduit = commandesProduit.stream()
                        .filter(cp -> {
                            LocalDate commandeDate = cp.getDateCommande().toLocalDate();
                            return commandeDate.isEqual(fin) || commandeDate.isBefore(fin);
                        })
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        // Calculer le total
        BigDecimal totalMontant = commandesProduit.stream()
                .map(CommandeProduit::getMontantTotal)
                .filter(m -> m != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Récupérer les IDs des commandes filtrées
        List<Integer> commandeIds = commandesProduit.stream()
                .map(CommandeProduit::getIdCommandeProduit)
                .collect(Collectors.toList());

        // Récupérer les détails des commandes
        List<DetailsCommandeProduit> detailsCommandes = detailsCommandeProduitRepository.findAll().stream()
                .filter(d -> d.getCommandeProduit() != null && commandeIds.contains(d.getCommandeProduit().getIdCommandeProduit()))
                .collect(Collectors.toList());

        model.addAttribute("detailsCommandes", detailsCommandes);
        model.addAttribute("commandesProduit", commandesProduit);
        model.addAttribute("totalMontant", totalMontant);
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        model.addAttribute("pageTitle", "Détails Commandes Produit-Extra");
        model.addAttribute("contentPage", "/WEB-INF/jsp/ca/produits.jsp");
        return "includes/layout";
    }
}