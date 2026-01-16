package com.example.taxi.controller;

import com.example.taxi.model.Admin;
import com.example.taxi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("nom") String nom,
                               @RequestParam("mdp") String mdp,
                               Model model,
                               HttpSession session) {
        Admin admin = adminService.authenticate(nom, mdp);
        if (admin != null) {
            // Login successful
            session.setAttribute("admin", admin);
            session.setAttribute("adminNom", admin.getNom());
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Nom d'utilisateur ou mot de passe incorrect.");
        }
        return "admin/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("pageTitle", "Tableau de Bord");
        model.addAttribute("contentPage", "/WEB-INF/jsp/admin/dashboard.jsp");
        return "includes/layout";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}