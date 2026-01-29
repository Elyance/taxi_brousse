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
                                <table class="table table-bordered table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Source</th>
                                            <th>Chiffre d'Affaire</th>
                                            <th>Pourcentage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Billet</td>
                                            <td>
                                                <fmt:formatNumber value="${summary.montantBillet != null ? summary.montantBillet : 0}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${summary.totalChiffreAffaire != null && summary.totalChiffreAffaire > 0}">
                                                        <fmt:formatNumber value="${(summary.montantBillet != null ? summary.montantBillet : 0) / summary.totalChiffreAffaire * 100}" maxFractionDigits="2"/>%
                                                    </c:when>
                                                    <c:otherwise>0.00%</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Produit-Extra</td>
                                            <td>
                                                <fmt:formatNumber value="${summary.montantProduit != null ? summary.montantProduit : 0}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${summary.totalChiffreAffaire != null && summary.totalChiffreAffaire > 0}">
                                                        <fmt:formatNumber value="${(summary.montantProduit != null ? summary.montantProduit : 0) / summary.totalChiffreAffaire * 100}" maxFractionDigits="2"/>%
                                                    </c:when>
                                                    <c:otherwise>0.00%</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Diffusion</td>
                                            <td>
                                                <fmt:formatNumber value="${summary.montantDiffusion != null ? summary.montantDiffusion : 0}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${summary.totalChiffreAffaire != null && summary.totalChiffreAffaire > 0}">
                                                        <fmt:formatNumber value="${(summary.montantDiffusion != null ? summary.montantDiffusion : 0) / summary.totalChiffreAffaire * 100}" maxFractionDigits="2"/>%
                                                    </c:when>
                                                    <c:otherwise>0.00%</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr class="table-primary font-weight-bold">
                                            <td><strong>Total</strong></td>
                                            <td>
                                                <strong><fmt:formatNumber value="${summary.totalChiffreAffaire != null ? summary.totalChiffreAffaire : 0}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                            </td>
                                            <td><strong>100.00%</strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>