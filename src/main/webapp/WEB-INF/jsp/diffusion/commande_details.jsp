<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Détails de la Commande ${commande.idCommandeDiffusion} - ${commande.societe.libelle}</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/diffusion/commandes'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID Commande Diffusion</th>
                                    <th>Trajet</th>
                                    <th>Véhicule</th>
                                    <th>Heure de Diffusion</th>
                                    <th>Nb Diffusion</th>
                                    <th>Prix Diffusion</th>
                                    <th>Totale de Prix de Diffusion</th>
                                    <th>Pourcentage Payé</th>
                                    <th>Montant Reste à Payer</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${details}">
                                    <c:set var="totalPrix" value="${detail.prixDiffusion * detail.nbDiffusion}" />
                                    <tr>
                                        <td>${commande.idCommandeDiffusion}</td>
                                        <td>${detail.voyage.trajet.gareDepart.nom} - ${detail.voyage.trajet.gareArrivee.nom}</td>
                                        <td>${detail.voyage.vehicule.immatriculation}</td>
                                        <td>
                                            <fmt:formatDate value="${detail.heureDiffusion}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>${detail.nbDiffusion}</td>
                                        <td>
                                            <fmt:formatNumber value="${detail.prixDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${totalPrix}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${pourcentageMap[detail.idDetailCommandeDiffusion]}" type="percent" maxFractionDigits="2"/>
                                        </td>
                                        <td>
                                            <strong><fmt:formatNumber value="${resteMap[detail.idDetailCommandeDiffusion]}" type="currency" currencySymbol="Ar" maxFractionDigits="0"/></strong>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty details}">
                                    <tr>
                                        <td colspan="9" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucun détail trouvé
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