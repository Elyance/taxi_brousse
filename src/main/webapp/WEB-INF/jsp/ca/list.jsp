<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Chiffres d'Affaires</h3>
                </div>

                <div class="card-body">
                    <!-- Filtre par date -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <form method="get" action="<c:url value='/ca/list'/>" class="form-inline">
                                <div class="form-group mr-3">
                                    <label for="dateDebut" class="mr-2">Date début:</label>
                                    <input type="date" class="form-control" id="dateDebut" name="dateDebut" value="${param.dateDebut}">
                                </div>
                                <div class="form-group mr-3">
                                    <label for="dateFin" class="mr-2">Date fin:</label>
                                    <input type="date" class="form-control" id="dateFin" name="dateFin" value="${param.dateFin}">
                                </div>
                                <button type="submit" class="btn btn-primary mr-2">Filtrer</button>
                                <a href="<c:url value='/ca/list'/>" class="btn btn-secondary">Réinitialiser</a>
                            </form>
                        </div>
                    </div>

                    <!-- Résumé des chiffres d'affaires en tableau -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Source</th>
                                            <th>Nombre</th>
                                            <th class="text-right">Chiffre d'Affaire</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><i class="fas fa-ticket-alt mr-2"></i>Billet</td>
                                            <td>${summary.nombreBillets != null ? summary.nombreBillets : 0}</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${summary.montantBillet != null ? summary.montantBillet : 0}" type="number" maxFractionDigits="0"/> Ar
                                            </td>
                                            <td>
                                                <a href="<c:url value='/billet/list'/>?dateDebut=${param.dateDebut}&dateFin=${param.dateFin}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> Détails
                                                </a>
                                            </td>
                                        </tr>
                                        <tr style="cursor: pointer;" onclick="window.location='<c:url value='/ca/produits'/>?dateDebut=${param.dateDebut}&dateFin=${param.dateFin}'">
                                            <td><i class="fas fa-box mr-2"></i>Produit-Extra</td>
                                            <td>${summary.nombreCommandesProduit != null ? summary.nombreCommandesProduit : 0}</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${summary.montantProduit != null ? summary.montantProduit : 0}" type="number" maxFractionDigits="0"/> Ar
                                            </td>
                                            <td>
                                                <a href="<c:url value='/ca/produits'/>?dateDebut=${param.dateDebut}&dateFin=${param.dateFin}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> Détails
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><i class="fas fa-bullhorn mr-2"></i>Diffusion</td>
                                            <td>${summary.nombreDiffusions != null ? summary.nombreDiffusions : 0}</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${summary.montantDiffusion != null ? summary.montantDiffusion : 0}" type="number" maxFractionDigits="0"/> Ar
                                            </td>
                                            <td>
                                                <a href="<c:url value='/diffusion/list'/>?dateDebut=${param.dateDebut}&dateFin=${param.dateFin}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> Détails
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr class="bg-success text-white" style="font-size: 1.2em;">
                                            <td><strong><i class="fas fa-calculator mr-2"></i>TOTAL</strong></td>
                                            <td><strong>${(summary.nombreBillets != null ? summary.nombreBillets : 0) + (summary.nombreCommandesProduit != null ? summary.nombreCommandesProduit : 0) + (summary.nombreDiffusions != null ? summary.nombreDiffusions : 0)}</strong></td>
                                            <td class="text-right">
                                                <strong><fmt:formatNumber value="${summary.totalChiffreAffaire != null ? summary.totalChiffreAffaire : 0}" type="number" maxFractionDigits="0"/> Ar</strong>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>