<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
    // Prix par catégorie de place
    const tarifs = {
        <c:forEach var="tarif" items="${tarifs}" varStatus="status">
            "${tarif.categoriePlace.libelle}": ${tarif.prix}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    };
</script>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${sessionScope.successMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Sélection des Places - Voyage ${voyage.idVoyage}</h3>
                    <div class="card-tools">
                        <a href="<c:url value='/voyages/${voyage.idVoyage}/details'/>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-arrow-left"></i> Retour aux détails
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Voyage Info -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5>Informations du Voyage</h5>
                            <p><strong>Trajet:</strong> ${voyage.trajet.gareDepart.ville.libelle} → ${voyage.trajet.gareArrivee.ville.libelle}</p>
                            <p><strong>Date de départ:</strong> <fmt:formatDate value="${voyage.dateDepart}" pattern="dd/MM/yyyy HH:mm"/></p>
                            <p><strong>Véhicule:</strong> ${voyage.vehicule.immatriculation} (${voyage.vehicule.nbPlace} places)</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Légende</h5>
                            <div class="legend">
                                <div class="legend-item">
                                    <div class="legend-seat available"></div>
                                    <span>Disponible</span>
                                </div>
                                <div class="legend-item">
                                    <div class="legend-seat vip"></div>
                                    <span>VIP</span>
                                </div>
                                <div class="legend-item">
                                    <div class="legend-seat premium"></div>
                                    <span>Premium</span>
                                </div>
                                <div class="legend-item">
                                    <div class="legend-seat reserved"></div>
                                    <span>Réservée</span>
                                </div>
                                <div class="legend-item">
                                    <div class="legend-seat selected"></div>
                                    <span>Sélectionnée</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Seat Selection -->
                    <div class="text-center mb-4">
                        <h5>Sélectionnez vos places</h5>
                        <div class="seat-grid">
                            <c:forEach var="place" items="${places}">
                                <div class="seat ${place.reserved ? 'reserved' : 'available'} ${place.categorie == 'VIP' ? 'vip' : place.categorie == 'Premium' ? 'premium' : 'standard'}"
                                     data-place="${place.numeroPlace}">
                                    ${place.numeroPlace}
                                </div>
                            </c:forEach>
                        </div>
                        <div class="mt-3">
                            <p><strong>Places sélectionnées:</strong> <span id="selectedSeats">Aucune</span></p>
                        </div>
                    </div>

                    <!-- Selected Places Summary -->
                    <div id="selectedPlacesSummary" style="display: none;">
                        <hr>
                        <h5>Total de votre sélection</h5>
                        <div class="alert alert-info">
                            <h4 class="alert-heading">Montant total: <span id="grandTotal">0.00 €</span></h4>
                        </div>
                    </div>

                    <!-- Client Form -->
                    <div id="clientFormSection" style="display: none;">
                        <hr>
                        <h5>Informations Client</h5>
                        <form id="bookingForm" action="<c:url value='/voyages/${voyage.idVoyage}/book'/>" method="post">
                            <div class="form-group">
                                <label>Type de client:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="clientType" id="existingClient" value="existing" checked>
                                    <label class="form-check-label" for="existingClient">
                                        Client existant
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="clientType" id="newClient" value="new">
                                    <label class="form-check-label" for="newClient">
                                        Nouveau client
                                    </label>
                                </div>
                            </div>

                            <!-- Existing Client -->
                            <div id="existingClientForm">
                                <div class="form-group">
                                    <label for="idClient">Sélectionner un client:</label>
                                    <select class="form-control" name="idClient" id="idClient" required>
                                        <option value="">Choisir un client...</option>
                                        <c:forEach var="client" items="${clients}">
                                            <option value="${client.idClient}">${client.nomComplet} <c:if test="${not empty client.categorieClient}">(${client.categorieClient.libelle})</c:if></option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- New Client -->
                            <div id="newClientForm" style="display: none;">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="nomComplet">Nom complet:</label>
                                            <input type="text" class="form-control" name="nomComplet" id="nomComplet" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="telephone">Téléphone:</label>
                                            <input type="text" class="form-control" name="telephone" id="telephone" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="idCategorieClient">Catégorie:</label>
                                            <select class="form-control" name="idCategorieClient" id="idCategorieClient" required>
                                                <option value="">Choisir une catégorie...</option>
                                                <c:forEach var="categorie" items="${categories}">
                                                    <option value="${categorie.idCategorieClient}">${categorie.libelle}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success btn-lg" id="bookBtn" disabled>
                                    <i class="fas fa-shopping-cart"></i> Acheter le(s) billet(s)
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
let selectedSeats = [];

function toggleSeat(placeNumber) {
    console.log('toggleSeat called with:', placeNumber, typeof placeNumber);

    // Trim any whitespace from placeNumber
    placeNumber = placeNumber.trim();
    console.log('Trimmed placeNumber:', placeNumber);

    // Try to find the element using different methods
    let seatElement = null;

    // Method 1: querySelector with trimmed value
    seatElement = document.querySelector(`[data-place="${placeNumber}"]`);
    console.log('Query result with double quotes:', seatElement);

    if (!seatElement) {
        // Method 2: Loop through all seats and find by exact match
        const allSeats = document.querySelectorAll('.seat');
        for (let seat of allSeats) {
            const dataPlace = seat.getAttribute('data-place');
            console.log('Checking seat:', dataPlace, 'vs', placeNumber, 'equal:', dataPlace === placeNumber);
            if (dataPlace === placeNumber) {
                seatElement = seat;
                break;
            }
        }
        console.log('Found by looping:', seatElement);
    }

    if (!seatElement) {
        console.error('Seat element not found for:', placeNumber);
        // List all available seats for debugging
        const allSeats = document.querySelectorAll('.seat');
        console.log('All available seats:');
        allSeats.forEach(seat => {
            console.log('  data-place:', '"' + seat.getAttribute('data-place') + '"', 'element:', seat);
        });
        return;
    }

    console.log('Found seat element:', seatElement);

    if (seatElement.classList.contains('reserved')) {
        console.log('Seat is reserved, returning');
        return;
    }

    const index = selectedSeats.indexOf(placeNumber);
    if (index > -1) {
        selectedSeats.splice(index, 1);
        seatElement.classList.remove('selected');
        console.log('Seat deselected:', placeNumber);
    } else {
        selectedSeats.push(placeNumber);
        seatElement.classList.add('selected');
        console.log('Seat selected:', placeNumber);
    }

    updateSelectedSeats();
    updateBookButton();
    toggleClientForm();
}

function updateSelectedSeats() {
    const selectedSpan = document.getElementById('selectedSeats');
    if (selectedSeats.length === 0) {
        selectedSpan.textContent = 'Aucune';
    } else {
        selectedSpan.textContent = selectedSeats.sort((a,b) => a-b).join(', ');
    }

    // Add hidden inputs for selected seats
    const form = document.getElementById('bookingForm');
    // Remove existing hidden inputs
    form.querySelectorAll('input[name="selectedPlaces"]').forEach(input => input.remove());
    // Add new ones
    selectedSeats.forEach(seat => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedPlaces';
        input.value = seat;
        form.appendChild(input);
    });

    // Update places summary and client form
    updatePlacesSummary();
    toggleClientForm();
}

function updateTarifsForClient() {
    const voyageId = ${voyage.idVoyage};
    const clientType = document.querySelector('input[name="clientType"]:checked').value;
    let idClient = null;
    let idCategorieClient = null;

    if (clientType === 'existing') {
        idClient = document.getElementById('idClient').value;
    } else {
        idCategorieClient = document.getElementById('idCategorieClient').value;
    }

    // Construire l'URL avec les paramètres
    let url = `/voyages/${voyageId}/tarifs`;
    const params = [];
    if (idClient) params.push(`idClient=${idClient}`);
    if (idCategorieClient) params.push(`idCategorieClient=${idCategorieClient}`);
    if (params.length > 0) url += '?' + params.join('&');

    fetch(url)
        .then(response => response.json())
        .then(data => {
            console.log('Tarifs API response:', data);
            // Mettre à jour l'objet tarifs avec les nouveaux prix
            data.forEach(tarifWithPrice => {
                const categorieLibelle = tarifWithPrice.tarif.categoriePlace.libelle;
                tarifs[categorieLibelle] = tarifWithPrice.prix;
                console.log('Updated', categorieLibelle, 'to', tarifWithPrice.prix);
            });
            console.log('Updated tarifs:', tarifs);

            // Recalculer le total si des places sont sélectionnées
            if (selectedSeats.length > 0) {
                updatePlacesSummary();
            }
        })
        .catch(error => {
            console.error('Error fetching tarifs:', error);
        });
}
function updatePlacesSummary() {
    const summarySection = document.getElementById('selectedPlacesSummary');
    const grandTotalSpan = document.getElementById('grandTotal');

    if (selectedSeats.length === 0) {
        summarySection.style.display = 'none';
        return;
    }

    summarySection.style.display = 'block';

    // Calculer le total avec les prix actuels
    calculateTotal();
}

function updateBookButton() {
    const bookBtn = document.getElementById('bookBtn');
    bookBtn.disabled = selectedSeats.length === 0;
}

function toggleClientForm() {
    const clientFormSection = document.getElementById('clientFormSection');
    if (selectedSeats.length > 0) {
        clientFormSection.style.display = 'block';
    } else {
        clientFormSection.style.display = 'none';
    }
}

async function updateTarifsForClient() {
    const voyageId = ${voyage.idVoyage};
    let idClient = null;
    let idCategorieClient = null;

    // Déterminer le client sélectionné
    if (document.getElementById('existingClient').checked) {
        idClient = document.getElementById('idClient').value;
    } else {
        idCategorieClient = document.getElementById('idCategorieClient').value;
    }

    try {
        const response = await fetch(`/voyages/${voyageId}/tarifs?idClient=${idClient || ''}&idCategorieClient=${idCategorieClient || ''}`);
        const tarifsWithPrices = await response.json();

        // Mettre à jour l'objet tarifs avec les nouveaux prix
        tarifsWithPrices.forEach(tarifWithPrice => {
            const categorieLibelle = tarifWithPrice.tarif.categoriePlace.libelle;
            tarifs[categorieLibelle] = parseFloat(tarifWithPrice.prixForClient);
        });

        console.log('Tarifs updated for client:', tarifs);

        // Recalculer le total si des places sont sélectionnées
        if (selectedSeats.length > 0) {
            calculateTotal();
        }
    } catch (error) {
        console.error('Error updating tarifs:', error);
    }
}

function calculateTotal() {
    const grandTotalSpan = document.getElementById('grandTotal');

    // Get all places data from the DOM
    const allSeats = document.querySelectorAll('.seat');
    const selectedPlacesData = [];

    selectedSeats.forEach(seatNumber => {
        // Find the seat element and get its category
        const seatElement = Array.from(allSeats).find(seat =>
            seat.getAttribute('data-place') === seatNumber
        );
        if (seatElement) {
            // Determine category from CSS classes
            let categorie = 'Standard'; // default
            if (seatElement.classList.contains('vip')) {
                categorie = 'VIP';
            } else if (seatElement.classList.contains('premium')) {
                categorie = 'Premium';
            }
            selectedPlacesData.push({
                numero: seatNumber,
                categorie: categorie
            });
        }
    });

    // Calculate total
    let grandTotal = 0;
    selectedPlacesData.forEach(place => {
        const prixUnitaire = tarifs[place.categorie] || 0;
        grandTotal += prixUnitaire;
    });

    // Update grand total
    grandTotalSpan.textContent = grandTotal.toFixed(2) + ' €';
}

function toggleClientType() {
    const existingClientForm = document.getElementById('existingClientForm');
    const newClientForm = document.getElementById('newClientForm');
    const existingClientRadio = document.getElementById('existingClient');
    const newClientRadio = document.getElementById('newClient');

    if (existingClientRadio.checked) {
        existingClientForm.style.display = 'block';
        newClientForm.style.display = 'none';
        // Make existing client select required and new client fields not required
        document.getElementById('idClient').required = true;
        document.getElementById('nomComplet').required = false;
        document.getElementById('telephone').required = false;
        document.getElementById('idCategorieClient').required = false;
    } else if (newClientRadio.checked) {
        existingClientForm.style.display = 'none';
        newClientForm.style.display = 'block';
        // Make new client fields required and existing client select not required
        document.getElementById('idClient').required = false;
        document.getElementById('nomComplet').required = true;
        document.getElementById('telephone').required = true;
        document.getElementById('idCategorieClient').required = true;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    // Debug: List all available data-place values
    const seats = document.querySelectorAll('.seat');
    console.log('Available seats:');
    seats.forEach(seat => {
        console.log('data-place:', seat.getAttribute('data-place'), 'classes:', seat.className);
    });

    // Add click event listeners to seats
    seats.forEach(seat => {
        seat.addEventListener('click', function() {
            const placeNumber = this.getAttribute('data-place');
            console.log('Seat clicked:', placeNumber);
            toggleSeat(placeNumber);
        });
    });

    // Add event listeners to client type radio buttons
    document.getElementById('existingClient').addEventListener('change', function() {
        toggleClientType();
        updateTarifsForClient();
    });
    document.getElementById('newClient').addEventListener('change', function() {
        toggleClientType();
        updateTarifsForClient();
    });

    // Add event listeners to client selects
    document.getElementById('idClient').addEventListener('change', updateTarifsForClient);
    document.getElementById('idCategorieClient').addEventListener('change', updateTarifsForClient);

    // Initialize form state
    toggleClientType();
});
</script>