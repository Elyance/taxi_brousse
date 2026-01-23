<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Résumé des Voyages</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/list'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <!-- Résumé général -->
                    <div class="row mb-4">
                        <div class="col-md-2">
                            <div class="card bg-primary text-white">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${totalBillets}</h5>
                                    <p class="card-text">Nombre de Billets</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card bg-success text-white">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${totalDiffusions}</h5>
                                    <p class="card-text">Nombre de Diffusions</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card bg-info text-white">
                                <div class="card-body text-center">
                                    <h5 class="card-title">
                                        <fmt:formatNumber value="${totalMontantDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                    </h5>
                                    <p class="card-text">Total Diffusion</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card bg-warning text-white">
                                <div class="card-body text-center">
                                    <h5 class="card-title">
                                        <fmt:formatNumber value="${totalMontantBillet}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                    </h5>
                                    <p class="card-text">Total Billets</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card bg-danger text-white">
                                <div class="card-body text-center">
                                    <h5 class="card-title">
                                        <fmt:formatNumber value="${totalResteDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                    </h5>
                                    <p class="card-text">Reste Diffusion</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Trajet</th>
                                    <th>Véhicule</th>
                                    <th>Date Départ</th>
                                    <th>Heure Départ</th>
                                    <th>Montant Billet</th>
                                    <th>Montant Diffusion</th>
                                    <th>Chiffre d'Affaire</th>
                                    <th>Payé Diffusion</th>
                                    <th>Reste Diffusion</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="summary" items="${summaries}">
                                    <tr>
                                        <td>${summary.voyage.trajet.gareDepart.nom} - ${summary.voyage.trajet.gareArrivee.nom}</td>
                                        <td>${summary.voyage.vehicule.immatriculation}</td>
                                        <td>
                                            <fmt:formatDate value="${summary.voyage.dateDepart}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${summary.voyage.dateDepart}" pattern="HH:mm"/>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${summary.montantBillet}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${summary.montantDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${summary.chiffreAffaire}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${summary.payeDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${summary.resteDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty summaries}">
                                    <tr>
                                        <td colspan="9" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucun voyage trouvé
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>