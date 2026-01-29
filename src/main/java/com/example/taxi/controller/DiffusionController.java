package com.example.taxi.controller;

import com.example.taxi.model.Billet;
import com.example.taxi.model.CommandeDiffusion;
import com.example.taxi.model.DetailsCommandeDiffusion;
import com.example.taxi.model.DiffusionSummary;
import com.example.taxi.model.Payement;
import com.example.taxi.model.PayementDetailCommandeDiffusion;
import com.example.taxi.model.Voyage;
import com.example.taxi.repository.BilletRepository;
import com.example.taxi.repository.CommandeDiffusionRepository;
import com.example.taxi.repository.DetailsCommandeDiffusionRepository;
import com.example.taxi.repository.PayementDetailCommandeDiffusionRepository;
import com.example.taxi.repository.PayementRepository;
import com.example.taxi.service.DiffusionService;
import com.example.taxi.service.PayementService;
import com.example.taxi.service.SocieteService;
import com.example.taxi.service.TrajetService;
import com.example.taxi.service.VoyageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/diffusion")
public class DiffusionController {

    // Inner class for voyage summary
    public static class VoyageSummary {
        private Voyage voyage;
        private BigDecimal montantBillet;
        private BigDecimal montantDiffusion;
        private BigDecimal chiffreAffaire;
        private BigDecimal payeDiffusion;
        private BigDecimal resteDiffusion;

        // Getters and setters
        public Voyage getVoyage() { return voyage; }
        public void setVoyage(Voyage voyage) { this.voyage = voyage; }
        public BigDecimal getMontantBillet() { return montantBillet; }
        public void setMontantBillet(BigDecimal montantBillet) { this.montantBillet = montantBillet; }
        public BigDecimal getMontantDiffusion() { return montantDiffusion; }
        public void setMontantDiffusion(BigDecimal montantDiffusion) { this.montantDiffusion = montantDiffusion; }
        public BigDecimal getChiffreAffaire() { return chiffreAffaire; }
        public void setChiffreAffaire(BigDecimal chiffreAffaire) { this.chiffreAffaire = chiffreAffaire; }
        public BigDecimal getPayeDiffusion() { return payeDiffusion; }
        public void setPayeDiffusion(BigDecimal payeDiffusion) { this.payeDiffusion = payeDiffusion; }
        public BigDecimal getResteDiffusion() { return resteDiffusion; }
        public void setResteDiffusion(BigDecimal resteDiffusion) { this.resteDiffusion = resteDiffusion; }
    }

    @Autowired
    private DiffusionService diffusionService;

    @Autowired
    private SocieteService societeService;

    @Autowired
    private TrajetService trajetService;

    @Autowired
    private VoyageService voyageService;

    @Autowired
    private PayementService payementService;

    @Autowired
    private CommandeDiffusionRepository commandeDiffusionRepository;

    @Autowired
    private PayementDetailCommandeDiffusionRepository payementDetailCommandeDiffusionRepository;

    @Autowired
    private PayementRepository payementRepository;

    @Autowired
    private BilletRepository billetRepository;

    @Autowired
    private DetailsCommandeDiffusionRepository detailsCommandeDiffusionRepository;

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

    @GetMapping("/payement")
    public String showPayementForm(HttpSession session, Model model, @RequestParam(required = false) Integer commandeId) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        model.addAttribute("commandes", commandeDiffusionRepository.findAll());
        if (commandeId != null) {
            model.addAttribute("selectedCommande", commandeDiffusionRepository.findById(commandeId).orElse(null));
        }
        model.addAttribute("pageTitle", "Ajouter un Paiement");
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/payement.jsp");
        return "includes/layout";
    }

    @PostMapping("/payement")
    public String savePayement(HttpSession session, @ModelAttribute Payement payement, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        // Sauvegarder le paiement principal
        Payement savedPayement = payementService.save(payement);

        // Récupérer la commande
        CommandeDiffusion commande = commandeDiffusionRepository.findById(savedPayement.getCommandeDiffusion().getIdCommandeDiffusion())
            .orElseThrow(() -> new RuntimeException("Commande de diffusion non trouvée"));

        // Calculer le montant total de la commande
        BigDecimal montantTotalCommande = commande.getDetailsCommandeDiffusions().stream()
            .map(d -> d.getPrixDiffusion().multiply(BigDecimal.valueOf(d.getNbDiffusion())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Calculer le pourcentage payé par ce paiement
        BigDecimal pourcentagePaye = savedPayement.getMontant().divide(montantTotalCommande, 4, java.math.RoundingMode.HALF_UP);

        // Répartir le paiement sur chaque détail de commande
        for (DetailsCommandeDiffusion detail : commande.getDetailsCommandeDiffusions()) {
            BigDecimal montantDetail = detail.getPrixDiffusion().multiply(BigDecimal.valueOf(detail.getNbDiffusion()));
            BigDecimal montantPourDetail = montantDetail.multiply(pourcentagePaye);

            PayementDetailCommandeDiffusion payementDetail = new PayementDetailCommandeDiffusion();
            payementDetail.setPayement(savedPayement);
            payementDetail.setDetailsCommandeDiffusion(detail);
            payementDetail.setMontant(montantPourDetail);
            payementDetail.setDatePayement(savedPayement.getDatePayement());

            payementDetailCommandeDiffusionRepository.save(payementDetail);
        }

        redirectAttributes.addFlashAttribute("successMessage", "Paiement ajouté avec succès!");
        return "redirect:/diffusion/commandes";
    }

    @GetMapping("/payments")
    public String listPayments(HttpSession session, Model model,
                               @RequestParam(required = false) Integer idSociete,
                               @RequestParam(required = false) String dateDebut,
                               @RequestParam(required = false) String dateFin) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<Payement> payments = payementService.getAll();

        // Appliquer les filtres
        if (idSociete != null) {
            payments = payments.stream()
                    .filter(p -> p.getCommandeDiffusion().getSociete().getIdSociete().equals(idSociete))
                    .collect(Collectors.toList());
        }

        if (dateDebut != null && !dateDebut.isEmpty()) {
            try {
                LocalDate debut = LocalDate.parse(dateDebut);
                payments = payments.stream()
                        .filter(p -> !p.getDatePayement().toLocalDate().isBefore(debut))
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        if (dateFin != null && !dateFin.isEmpty()) {
            try {
                LocalDate fin = LocalDate.parse(dateFin);
                payments = payments.stream()
                        .filter(p -> !p.getDatePayement().toLocalDate().isAfter(fin))
                        .collect(Collectors.toList());
            } catch (Exception e) {
                // Ignore invalid date format
            }
        }

        model.addAttribute("payments", payments);
        model.addAttribute("societes", societeService.getAll());
        model.addAttribute("pageTitle", "Liste des Paiements de Diffusion");
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/payments.jsp");
        return "includes/layout";
    }

    @GetMapping("/commandes")
    public String listCommandes(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<CommandeDiffusion> commandes = commandeDiffusionRepository.findAll();
        // Calculate totals for each commande
        Map<Integer, Long> nbDiffusionMap = new HashMap<>();
        Map<Integer, BigDecimal> montantTotalMap = new HashMap<>();
        Map<Integer, BigDecimal> resteMap = new HashMap<>();

        for (CommandeDiffusion cmd : commandes) {
            List<DetailsCommandeDiffusion> details = cmd.getDetailsCommandeDiffusions();
            long nbTotal = details.stream().mapToLong(DetailsCommandeDiffusion::getNbDiffusion).sum();
            BigDecimal montantTotal = details.stream()
                .map(d -> d.getPrixDiffusion().multiply(BigDecimal.valueOf(d.getNbDiffusion())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            // For reste, need payements
            BigDecimal paye = payementRepository.findByCommandeDiffusion(cmd).stream()
                .map(Payement::getMontant)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            BigDecimal reste = montantTotal.subtract(paye);

            nbDiffusionMap.put(cmd.getIdCommandeDiffusion(), nbTotal);
            montantTotalMap.put(cmd.getIdCommandeDiffusion(), montantTotal);
            resteMap.put(cmd.getIdCommandeDiffusion(), reste);
        }

        model.addAttribute("commandes", commandes);
        model.addAttribute("nbDiffusionMap", nbDiffusionMap);
        model.addAttribute("montantTotalMap", montantTotalMap);
        model.addAttribute("resteMap", resteMap);
        model.addAttribute("pageTitle", "Liste des Commandes de Diffusion");
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/commandes.jsp");
        return "includes/layout";
    }

    @GetMapping("/commande/{id}")
    public String showCommandeDetails(@PathVariable Integer id, HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        CommandeDiffusion commande = commandeDiffusionRepository.findById(id).orElse(null);
        if (commande == null) {
            return "redirect:/diffusion/commandes";
        }

        List<DetailsCommandeDiffusion> details = commande.getDetailsCommandeDiffusions();
        // For each detail, calculate paye and reste
        Map<Integer, BigDecimal> payeMap = new HashMap<>();
        Map<Integer, BigDecimal> resteMap = new HashMap<>();
        Map<Integer, BigDecimal> pourcentageMap = new HashMap<>();

        for (DetailsCommandeDiffusion d : details) {
            BigDecimal total = d.getPrixDiffusion().multiply(BigDecimal.valueOf(d.getNbDiffusion()));
            BigDecimal paye = payementDetailCommandeDiffusionRepository.findByDetailsCommandeDiffusion(d).stream()
                .map(PayementDetailCommandeDiffusion::getMontant)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            BigDecimal reste = total.subtract(paye);
            BigDecimal pourcentage = total.compareTo(BigDecimal.ZERO) > 0 ? paye.divide(total, 4, java.math.RoundingMode.HALF_UP) : BigDecimal.ZERO;

            payeMap.put(d.getIdDetailCommandeDiffusion(), paye);
            resteMap.put(d.getIdDetailCommandeDiffusion(), reste);
            pourcentageMap.put(d.getIdDetailCommandeDiffusion(), pourcentage);
        }

        model.addAttribute("commande", commande);
        model.addAttribute("details", details);
        model.addAttribute("payeMap", payeMap);
        model.addAttribute("resteMap", resteMap);
        model.addAttribute("pourcentageMap", pourcentageMap);
        model.addAttribute("pageTitle", "Détails de la Commande " + id);
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/commande_details.jsp");
        return "includes/layout";
    }

    @GetMapping("/voyages-summary")
    public String voyagesSummary(HttpSession session, Model model,
                                 @RequestParam(required = false) String dateDebut,
                                 @RequestParam(required = false) String dateFin) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        List<Voyage> voyages = voyageService.getAllVoyages();

        // Appliquer les filtres de date
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

        List<VoyageSummary> summaries = new ArrayList<>();

        for (Voyage v : voyages) {
            VoyageSummary summary = new VoyageSummary();
            summary.setVoyage(v);

            // Montant généré par billet vendu
            BigDecimal montantBillet = billetRepository.findByVoyage(v).stream()
                .map(Billet::getMontantTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            summary.setMontantBillet(montantBillet);

            // Montant généré par diffusion de publicité
            BigDecimal montantDiffusion = detailsCommandeDiffusionRepository.findByVoyage(v).stream()
                .map(d -> d.getPrixDiffusion().multiply(BigDecimal.valueOf(d.getNbDiffusion())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            summary.setMontantDiffusion(montantDiffusion);

            // Chiffre d'Affaire total
            BigDecimal ca = montantBillet.add(montantDiffusion);
            summary.setChiffreAffaire(ca);

            // Montant total payé diffusion
            BigDecimal payeDiffusion = payementDetailCommandeDiffusionRepository.findByVoyage(v).stream()
                .map(PayementDetailCommandeDiffusion::getMontant)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            summary.setPayeDiffusion(payeDiffusion);

            // Reste à payer diffusion
            BigDecimal resteDiffusion = montantDiffusion.subtract(payeDiffusion);
            summary.setResteDiffusion(resteDiffusion);

            summaries.add(summary);
        }

        // Calculer les totaux
        long totalBillets = summaries.stream().mapToLong(s -> billetRepository.findByVoyage(s.getVoyage()).size()).sum();
        long totalDiffusions = summaries.stream().mapToLong(s -> detailsCommandeDiffusionRepository.findByVoyage(s.getVoyage()).stream().mapToLong(DetailsCommandeDiffusion::getNbDiffusion).sum()).sum();
        BigDecimal totalMontantDiffusion = summaries.stream().map(VoyageSummary::getMontantDiffusion).reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal totalMontantBillet = summaries.stream().map(VoyageSummary::getMontantBillet).reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal totalResteDiffusion = summaries.stream().map(VoyageSummary::getResteDiffusion).reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("summaries", summaries);
        model.addAttribute("totalBillets", totalBillets);
        model.addAttribute("totalDiffusions", totalDiffusions);
        model.addAttribute("totalMontantDiffusion", totalMontantDiffusion);
        model.addAttribute("totalMontantBillet", totalMontantBillet);
        model.addAttribute("totalResteDiffusion", totalResteDiffusion);
        model.addAttribute("pageTitle", "Résumé des Voyages");
        model.addAttribute("contentPage", "/WEB-INF/jsp/diffusion/voyages_summary.jsp");
        return "includes/layout";
    }
}