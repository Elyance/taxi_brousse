<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>Détails Commandes Produit-Extra
                    </h3>
                    <a href="<c:url value='/ca/list'/>?dateDebut=${dateDebut}&dateFin=${dateFin}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour aux Chiffres d'Affaires
                    </a>
                </div>

                <div class="card-body">
                    <!-- Filtre par date -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <form method="get" action="<c:url value='/ca/produits'/>" class="form-inline">
                                <div class="form-group mr-3">
                                    <label for="dateDebut" class="mr-2">Date début:</label>
                                    <input type="date" class="form-control" id="dateDebut" name="dateDebut" value="${dateDebut}">
                                </div>
                                <div class="form-group mr-3">
                                    <label for="dateFin" class="mr-2">Date fin:</label>
                                    <input type="date" class="form-control" id="dateFin" name="dateFin" value="${dateFin}">
                                </div>
                                <button type="submit" class="btn btn-primary mr-2">Filtrer</button>
                                <a href="<c:url value='/ca/produits'/>" class="btn btn-secondary">Réinitialiser</a>
                            </form>
                        </div>
                    </div>

                    <!-- Info filtre actif -->
                    <c:if test="${not empty dateDebut || not empty dateFin}">
                        <div class="alert alert-info">
                            <i class="fas fa-filter mr-2"></i>
                            Filtre actif: 
                            <c:if test="${not empty dateDebut}">Du <strong>${dateDebut}</strong></c:if>
                            <c:if test="${not empty dateFin}">Au <strong>${dateFin}</strong></c:if>
                        </div>
                    </c:if>

                    <!-- Tableau des détails commandes produit -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>#</th>
                                    <th>ID Commande</th>
                                    <th>Date Commande</th>
                                    <th>Produit</th>
                                    <th class="text-right">Prix Unitaire</th>
                                    <th class="text-center">Quantité</th>
                                    <th class="text-right">Sous-Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${detailsCommandes}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${detail.commandeProduit.idCommandeProduit}</td>
                                        <td>
                                            <fmt:parseDate value="${detail.commandeProduit.dateCommande}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${detail.produit != null}">
                                                    <i class="fas fa-cube mr-1"></i>${detail.produit.libelle}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right">
                                            <c:choose>
                                                <c:when test="${detail.produit != null && detail.produit.prix != null}">
                                                    <fmt:formatNumber value="${detail.produit.prix}" type="number" maxFractionDigits="0"/> Ar
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge badge-primary">${detail.quantity != null ? detail.quantity : 0}</span>
                                        </td>
                                        <td class="text-right">
                                            <c:choose>
                                                <c:when test="${detail.produit != null && detail.produit.prix != null && detail.quantity != null}">
                                                    <strong><fmt:formatNumber value="${detail.produit.prix * detail.quantity}" type="number" maxFractionDigits="0"/> Ar</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty detailsCommandes}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted">
                                            <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                            Aucun détail de commande trouvé pour cette période
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                            <tfoot>
                                <tr class="bg-success text-white" style="font-size: 1.1em;">
                                    <td colspan="6"><strong><i class="fas fa-calculator mr-2"></i>TOTAL (${detailsCommandes.size()} lignes - ${commandesProduit.size()} commandes)</strong></td>
                                    <td class="text-right">
                                        <strong><fmt:formatNumber value="${totalMontant != null ? totalMontant : 0}" type="number" maxFractionDigits="0"/> Ar</strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
