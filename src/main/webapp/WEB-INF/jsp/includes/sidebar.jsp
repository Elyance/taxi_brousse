<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Sidebar Styles */
    .sidebar {
        width: 250px;
        background: linear-gradient(135deg, #2d3748 0%, #1a202c 100%);
        min-height: 100vh;
        padding: 20px 0;
        position: fixed;
        left: 0;
        top: 0;
        color: white;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.15);
        overflow-y: auto;
        overflow-x: hidden;
        display: flex;
        flex-direction: column;
    }

    .sidebar-logo {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 20px;
        margin-bottom: 20px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar-logo-icon {
        width: 45px;
        height: 45px;
        background: #4299e1;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        color: white;
    }

    .sidebar-logo-text {
        font-size: 18px;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .sidebar-tagline {
        font-size: 11px;
        color: #cbd5e0;
        margin-top: -2px;
    }

    .sidebar-menu {
        list-style: none;
        padding: 0;
        margin: 0;
        flex: 1;
        overflow-y: auto;
    }

    .sidebar-menu-item {
        margin: 0;
    }

    .sidebar-menu-title {
        font-size: 12px;
        font-weight: 700;
        color: #a0aec0;
        padding: 15px 20px 8px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .sidebar-menu-link {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 20px;
        color: #cbd5e0;
        text-decoration: none;
        transition: all 0.2s ease;
        font-size: 14px;
        position: relative;
    }

    .sidebar-menu-link:hover {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        padding-left: 24px;
    }

    .sidebar-menu-link.active {
        background: rgba(66, 153, 225, 0.2);
        color: #4299e1;
        border-left: 3px solid #4299e1;
        padding-left: 17px;
    }

    .sidebar-menu-link i {
        width: 18px;
        text-align: center;
    }

    .sidebar-submenu {
        list-style: none;
        padding: 0;
        margin: 0;
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease;
    }

    .sidebar-submenu.show {
        max-height: 500px;
    }

    .sidebar-submenu-link {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 10px 20px 10px 50px;
        color: #a0aec0;
        text-decoration: none;
        transition: all 0.2s ease;
        font-size: 13px;
    }

    .sidebar-submenu-link:hover {
        color: white;
        background: rgba(255, 255, 255, 0.05);
    }

    .sidebar-submenu-link.active {
        color: #4299e1;
    }

    .sidebar-dropdown-toggle {
        display: flex;
        align-items: center;
        justify-content: space-between;
        cursor: pointer;
        width: 100%;
    }

    .sidebar-dropdown-toggle::after {
        content: '';
        width: 5px;
        height: 5px;
        border-right: 2px solid #cbd5e0;
        border-bottom: 2px solid #cbd5e0;
        transform: rotate(-45deg);
        transition: transform 0.3s ease;
        margin-right: 5px;
    }

    .sidebar-menu-link.expanded .sidebar-dropdown-toggle::after {
        transform: rotate(45deg);
        margin-right: 5px;
    }

    .sidebar-footer {
        position: relative;
        width: 100%;
        padding: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        text-align: center;
        margin-top: auto;
    }

    .sidebar-footer-link {
        color: #cbd5e0;
        text-decoration: none;
        font-size: 13px;
        transition: color 0.2s ease;
        display: block;
        padding: 8px 0;
    }

    .sidebar-footer-link:hover {
        color: #4299e1;
    }

    /* Scrollbar styling */
    .sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: transparent;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.3);
    }
</style>

<div class="sidebar">
    <!-- Logo -->
    <div class="sidebar-logo">
        <div class="sidebar-logo-icon">
            <i class="fas fa-taxi"></i>
        </div>
        <div>
            <div class="sidebar-logo-text">TaxiHub</div>
            <div class="sidebar-tagline">Management</div>
        </div>
    </div>

    <!-- Menu -->
    <ul class="sidebar-menu">
        <!-- Véhicules -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-truck"></i> Véhicules</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/vehicule/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/vehicule/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

        <!-- Chauffeurs -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-id-card"></i> Chauffeurs</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/chauffeur/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/chauffeur/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

        <!-- Trajets -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-route"></i> Trajets</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/trajet/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/trajet/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

        <!-- Clients -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-users"></i> Clients</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/client/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/client/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

        <!-- Voyages -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-plane"></i> Voyages</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/voyage/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/voyage/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

        <!-- Billets -->
        <li class="sidebar-menu-item">
            <a href="#" class="sidebar-menu-link" onclick="toggleSubmenu(event)">
                <span class="sidebar-dropdown-toggle">
                    <span><i class="fas fa-ticket-alt"></i> Billets</span>
                </span>
            </a>
            <ul class="sidebar-submenu">
                <li><a href="<c:url value='/billet/list'/>" class="sidebar-submenu-link"><i class="fas fa-list"></i> Liste</a></li>
                <li><a href="<c:url value='/billet/create'/>" class="sidebar-submenu-link"><i class="fas fa-plus"></i> Saisie</a></li>
            </ul>
        </li>

       
    </ul>

    <!-- Footer -->
    <div class="sidebar-footer">
        <a href="<c:url value='/logout'/>" class="sidebar-footer-link">
            <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
    </div>
</div>

<script>
    function toggleSubmenu(event) {
        event.preventDefault();
        const link = event.currentTarget;
        const submenu = link.nextElementSibling;
        const isExpanded = link.classList.contains('expanded');
        
        // Fermer tous les autres submenus
        document.querySelectorAll('.sidebar-menu-link.expanded').forEach(item => {
            if (item !== link) {
                item.classList.remove('expanded');
                if (item.nextElementSibling && item.nextElementSibling.classList.contains('sidebar-submenu')) {
                    item.nextElementSibling.classList.remove('show');
                }
            }
        });
        
        // Basculer le submenu courant
        if (submenu && submenu.classList.contains('sidebar-submenu')) {
            submenu.classList.toggle('show');
            link.classList.toggle('expanded');
        }
    }
</script>
