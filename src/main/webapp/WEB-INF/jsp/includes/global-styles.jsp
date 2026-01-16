<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* ========== STYLES GLOBAUX ========== */

    /* Tables & Lists Styles */
    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        table-layout: auto;
    }

    .data-table thead {
        background: #f3f4f6;
        border-bottom: 2px solid #e5e7eb;
        position: sticky;
        top: 0;
    }

    .data-table thead th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    .data-table tbody tr {
        border-bottom: 1px solid #e5e7eb;
        transition: background-color 0.2s ease;
    }

    .data-table tbody tr:hover {
        background-color: #f9fafb;
    }

    .data-table tbody td {
        padding: 12px 15px;
        color: #374151;
        font-size: 14px;
        vertical-align: middle;
    }

    .data-table tbody tr:last-child {
        border-bottom: none;
    }

    /* Colonnes de tableau - sizing responsif */
    .data-table th:nth-child(1),
    .data-table td:nth-child(1) {
        min-width: 200px;
        flex: 1.2;
    }

    .data-table th:nth-child(2),
    .data-table td:nth-child(2) {
        min-width: 140px;
        flex: 1;
    }

    .data-table th:nth-child(3),
    .data-table td:nth-child(3) {
        min-width: 150px;
        flex: 1;
    }

    .data-table th:nth-child(4),
    .data-table td:nth-child(4) {
        min-width: 140px;
        flex: 1;
    }

    .data-table th:nth-child(5),
    .data-table td:nth-child(5) {
        min-width: 80px;
        flex: 0.8;
        text-align: right;
    }

    .data-table th:nth-child(6),
    .data-table td:nth-child(6) {
        min-width: 130px;
        flex: 1;
        white-space: nowrap;
    }

    /* Responsive wrapper pour scrolling horizontal */
    div[style*="overflow-x: auto"] {
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    div[style*="overflow-x: auto"]::-webkit-scrollbar {
        height: 6px;
    }

    div[style*="overflow-x: auto"]::-webkit-scrollbar-track {
        background: #f1f5f9;
    }

    div[style*="overflow-x: auto"]::-webkit-scrollbar-thumb {
        background: #cbd5e0;
        border-radius: 3px;
    }

    div[style*="overflow-x: auto"]::-webkit-scrollbar-thumb:hover {
        background: #a0aec0;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: #f9fafb;
        border-radius: 12px;
        margin-top: 20px;
    }

    .empty-state-icon {
        font-size: 48px;
        color: #d1d5db;
        margin-bottom: 15px;
    }

    .empty-state-title {
        font-size: 18px;
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
    }

    .empty-state-text {
        color: #6b7280;
        font-size: 14px;
        margin-bottom: 20px;
    }

    /* Filter/Search Section */
    .filter-section {
        background: white;
        padding: 20px;
        border-radius: 12px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        border: 1px solid #e5e7eb;
    }

    .filter-section-title {
        font-size: 16px;
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .filter-group {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-bottom: 15px;
    }

    .filter-group:last-child {
        margin-bottom: 0;
    }

    .filter-item {
        display: flex;
        flex-direction: column;
    }

    .filter-label {
        font-weight: 600;
        color: #374151;
        margin-bottom: 6px;
        font-size: 13px;
    }

    .filter-input,
    .filter-select {
        padding: 10px 12px;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.2s ease;
        background: white;
        color: #1f2937;
    }

    .filter-input:focus,
    .filter-select:focus {
        outline: none;
        border-color: #4299e1;
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
    }

    .filter-actions {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .btn-filter,
    .btn-reset {
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .btn-filter {
        background: #4299e1;
        color: white;
    }

    .btn-filter:hover {
        background: #3182ce;
        box-shadow: 0 2px 8px rgba(66, 153, 225, 0.3);
    }

    .btn-reset {
        background: #e2e8f0;
        color: #4b5563;
    }

    .btn-reset:hover {
        background: #cbd5e0;
    }

    /* Table Actions */
    .table-actions {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        justify-content: flex-start;
    }

    .btn-action {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 8px 14px;
        border: none;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        text-decoration: none;
        gap: 6px;
        white-space: nowrap;
        min-width: fit-content;
    }

    .btn-action:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .btn-view {
        background: #dbeafe;
        color: #0c63e4;
    }

    .btn-view:hover {
        background: #bfdbfe;
        color: #0c4a8b;
    }

    .btn-edit {
        background: #fef3c7;
        color: #b45309;
    }

    .btn-edit:hover {
        background: #fde68a;
        color: #92400e;
    }

    .btn-delete {
        background: #fee2e2;
        color: #dc2626;
    }

    .btn-delete:hover {
        background: #fecaca;
        color: #991b1b;
    }

    /* List Header Section */
    .list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .list-title {
        font-size: 20px;
        font-weight: 700;
        color: #1f2937;
    }

    .list-actions {
        display: flex;
        gap: 10px;
    }

    /* ========== FORM STYLES ========== */

    .form-container {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        max-width: 800px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group:last-child {
        margin-bottom: 0;
    }

    .form-label {
        display: block;
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
        font-size: 14px;
    }

    .form-label.required::after {
        content: ' *';
        color: #dc2626;
    }

    .form-input,
    .form-textarea,
    .form-select {
        width: 100%;
        padding: 12px 14px;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        font-size: 14px;
        font-family: inherit;
        transition: all 0.2s ease;
        background: white;
        color: #1f2937;
    }

    .form-input:focus,
    .form-textarea:focus,
    .form-select:focus {
        outline: none;
        border-color: #4299e1;
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
    }

    .form-textarea {
        resize: vertical;
        min-height: 120px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .form-input::placeholder {
        color: #9ca3af;
    }

    /* Form Row (for side-by-side fields) */
    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }

    .form-group-row {
        margin-bottom: 0;
    }

    /* Input Help Text */
    .form-help {
        display: block;
        margin-top: 5px;
        font-size: 12px;
        color: #6b7280;
    }

    /* Form Validation States */
    .form-input.is-invalid,
    .form-textarea.is-invalid,
    .form-select.is-invalid {
        border-color: #dc2626;
        background-color: #fef2f2;
    }

    .form-input.is-valid,
    .form-textarea.is-valid,
    .form-select.is-valid {
        border-color: #10b981;
        background-color: #f0fdf4;
    }

    .form-error {
        display: block;
        margin-top: 6px;
        color: #dc2626;
        font-size: 13px;
        font-weight: 500;
    }

    .form-success {
        display: block;
        margin-top: 6px;
        color: #10b981;
        font-size: 13px;
        font-weight: 500;
    }

    /* Form Actions */
    .form-actions {
        display: flex;
        gap: 10px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
        flex-wrap: wrap;
    }

    .form-actions-primary {
        margin-left: auto;
    }

    /* Primary Button */
    .btn-primary {
        padding: 12px 28px;
        background: #4299e1;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-primary:hover {
        background: #3182ce;
        box-shadow: 0 4px 12px rgba(66, 153, 225, 0.3);
    }

    .btn-primary:active {
        transform: translateY(-1px);
    }

    /* Secondary Button */
    .btn-secondary {
        padding: 12px 28px;
        background: #e2e8f0;
        color: #4b5563;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-secondary:hover {
        background: #cbd5e0;
    }

    /* Danger Button */
    .btn-danger {
        padding: 12px 28px;
        background: #dc2626;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-danger:hover {
        background: #b91c1c;
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
    }

    /* Success Button */
    .btn-success {
        padding: 12px 28px;
        background: #10b981;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-success:hover {
        background: #059669;
        box-shadow: 0 4px 12px rgba(16, 185, 137, 0.3);
    }

    /* Alerts/Messages */
    .alert {
        padding: 15px 16px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: flex;
        align-items: flex-start;
        gap: 12px;
        border-left: 4px solid;
    }

    .alert-success {
        background: #f0fdf4;
        border-left-color: #10b981;
        color: #065f46;
    }

    .alert-danger {
        background: #fef2f2;
        border-left-color: #dc2626;
        color: #7f1d1d;
    }

    .alert-warning {
        background: #fffbeb;
        border-left-color: #f59e0b;
        color: #78350f;
    }

    .alert-info {
        background: #eff6ff;
        border-left-color: #4299e1;
        color: #1e40af;
    }

    .alert-icon {
        font-size: 18px;
        flex-shrink: 0;
        margin-top: 2px;
    }

    .alert-content {
        flex: 1;
    }

    .alert-title {
        font-weight: 600;
        margin-bottom: 4px;
    }

    .alert-message {
        font-size: 14px;
    }

    /* Pagination */
    .pagination {
        display: flex;
        gap: 5px;
        margin-top: 20px;
        justify-content: center;
        align-items: center;
    }

    .pagination-item {
        padding: 8px 12px;
        border: 1px solid #e5e7eb;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s ease;
        font-size: 13px;
        min-width: 36px;
        text-align: center;
    }

    .pagination-item:hover {
        border-color: #4299e1;
        color: #4299e1;
    }

    .pagination-item.active {
        background: #4299e1;
        color: white;
        border-color: #4299e1;
    }

    .pagination-item.disabled {
        color: #d1d5db;
        cursor: not-allowed;
    }

    /* Checkbox & Radio */
    .form-checkbox,
    .form-radio {
        width: 18px;
        height: 18px;
        cursor: pointer;
        accent-color: #4299e1;
    }

    .checkbox-label,
    .radio-label {
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        font-size: 14px;
        color: #374151;
    }

    /* Select Box Customization */
    .form-select {
        cursor: pointer;
        appearance: none;
        background-image: url('data:image/svg+xml;charset=UTF-8,%3csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 16 16%22%3e%3cpath fill=%22%234b5563%22 d=%22M8 10.5L3.5 6h9z%22/%3e%3c/svg%3e');
        background-repeat: no-repeat;
        background-position: right 10px center;
        background-size: 16px;
        padding-right: 35px;
    }

    /* Breadcrumb */
    .breadcrumb {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .breadcrumb-item {
        color: #6b7280;
        text-decoration: none;
    }

    .breadcrumb-item:hover {
        color: #4299e1;
    }

    .breadcrumb-separator {
        color: #d1d5db;
    }

    .breadcrumb-item.active {
        color: #1f2937;
        font-weight: 600;
    }

    /* Responsive Tables */
    @media (max-width: 768px) {
        .filter-group {
            grid-template-columns: 1fr;
        }

        .data-table {
            font-size: 12px;
        }

        .data-table thead th,
        .data-table tbody td {
            padding: 10px;
        }

        .form-row {
            grid-template-columns: 1fr;
        }

        .list-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .table-actions {
            flex-direction: column;
        }

        .btn-action {
            width: 100%;
            justify-content: center;
        }

        .form-actions {
            flex-direction: column;
        }

        .form-actions-primary {
            margin-left: 0;
        }

        .btn-primary,
        .btn-secondary,
        .btn-danger,
        .btn-success {
            width: 100%;
            justify-content: center;
        }

        .pagination-item {
            padding: 6px 10px;
            font-size: 12px;
        }
    }

    /* ========== ALERT STYLES ========== */
    .alert {
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: flex;
        align-items: flex-start;
        gap: 12px;
        border: 1px solid transparent;
    }

    .alert-icon {
        font-size: 18px;
        flex-shrink: 0;
        margin-top: 2px;
    }

    .alert-content {
        flex-grow: 1;
    }

    .alert-message {
        font-size: 14px;
        font-weight: 500;
    }

    .alert-success {
        background-color: #ecfdf5;
        border-color: #a7f3d0;
        color: #065f46;
    }

    .alert-success .alert-icon {
        color: #10b981;
    }

    .alert-danger {
        background-color: #fef2f2;
        border-color: #fecaca;
        color: #7f1d1d;
    }

    .alert-danger .alert-icon {
        color: #dc2626;
    }

    .alert-warning {
        background-color: #fffbeb;
        border-color: #fde68a;
        color: #78350f;
    }

    .alert-warning .alert-icon {
        color: #f59e0b;
    }

    .alert-info {
        background-color: #eff6ff;
        border-color: #bfdbfe;
        color: #0c2d6b;
    }

    .alert-info .alert-icon {
        color: #0284c7;
    }

    /* ========== STYLES SPÉCIFIQUES BILLET ========== */
    
    /* Cartes de statistiques billets */
    .billet-stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .billet-stat-card {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .billet-stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .billet-stat-gradient {
        padding: 20px;
        color: white;
        display: flex;
    }

    .billet-stat-success {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    }

    .billet-stat-info {
        background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%);
    }

    .billet-stat-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .billet-stat-label {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 0;
        opacity: 0.9;
        font-weight: 600;
    }

    .billet-stat-value {
        font-size: 28px;
        margin: 8px 0 0 0;
        font-weight: 700;
    }

    .billet-stat-icon {
        font-size: 40px;
        opacity: 0.2;
    }

    /* Tableau billets */
    .billet-table-container {
        margin-bottom: 20px;
    }

    .billet-table-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        overflow: hidden;
    }

    .billet-table-header {
        padding: 20px;
        background-color: #f8f9fa;
        border-bottom: 1px solid #e5e7eb;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .billet-table-title {
        margin: 0;
        font-size: 16px;
        font-weight: 600;
        color: #1f2937;
    }

    .billet-table-badge {
        background-color: #e5e7eb;
        color: #374151;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        white-space: nowrap;
    }

    .billet-table-body {
        padding: 0;
        overflow-x: auto;
    }

    .billet-table-card .table {
        margin-bottom: 0;
    }

    .bg-gradient-success {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
    }

    .bg-gradient-info {
        background: linear-gradient(135deg, #17a2b8 0%, #20c997 100%) !important;
    }

    .card-body.bg-gradient-success,
    .card-body.bg-gradient-info {
        border-radius: 0.25rem 0.25rem 0 0;
        color: white !important;
    }

    /* Tables in billing */
    .table {
        background-color: white !important;
        color: #333 !important;
        margin-bottom: 0;
    }

    .table thead th {
        background-color: #f8f9fa !important;
        color: #333 !important;
        font-weight: 600;
        border-bottom: 2px solid #dee2e6;
        vertical-align: middle;
    }

    .table tbody {
        background-color: white !important;
    }

    .table tbody tr {
        background-color: white !important;
        color: #333 !important;
    }

    .table tbody tr td {
        color: #333 !important;
        background-color: white !important;
        vertical-align: middle;
    }

    .table tbody tr:hover {
        background-color: #f5f5f5 !important;
        transition: background-color 0.2s ease;
        color: #333 !important;
    }

    .table small {
        color: #666 !important;
    }

    .table-striped {
        background-color: white !important;
    }

    .table-striped tbody tr {
        background-color: white !important;
    }

    .table-striped tbody tr:nth-of-type(odd) {
        background-color: white !important;
    }

    /* Badges */
    .badge {
        padding: 0.4rem 0.6rem;
        font-weight: 500;
        color: #666 !important;
    }

    .badge-secondary {
        background-color: #e2e3e5 !important;
        color: #333 !important;
    }

    .badge-info {
        background-color: #d1ecf1 !important;
        color: #333 !important;
    }

    .badge-success {
        background-color: #d4edda !important;
        color: #333 !important;
    }

    .badge-warning {
        background-color: #fff3cd !important;
        color: #333 !important;
    }

    .badge-light {
        background-color: #f8f9fa !important;
        color: #333 !important;
    }

    /* Form controls */
    .form-control-sm {
        border-radius: 0.25rem;
        border: 1px solid #ced4da;
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
    }

    .form-label {
        font-weight: 500;
        margin-bottom: 0.5rem;
        color: #333;
    }

    /* Buttons */
    .btn-sm {
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        color: white;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }

    .btn-secondary {
        background-color: #6c757d;
        border-color: #6c757d;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #545b62;
        border-color: #545b62;
    }

    /* Responsive wrapper */
    .table-responsive {
        border-radius: 4px;
        border: 1px solid #e5e7eb;
    }

    /* Align middle utility */
    .align-middle {
        vertical-align: middle !important;
    }

    /* Text utilities */
    .text-nowrap {
        white-space: nowrap;
    }

    .text-muted {
        color: #6c757d !important;
    }

    .text-right {
        text-align: right;
    }

    .text-success {
        color: #28a745 !important;
    }

    .text-uppercase {
        text-transform: uppercase;
    }

    .mb-0 {
        margin-bottom: 0 !important;
    }

    .mt-2 {
        margin-top: 0.5rem !important;
    }

    .me-1 {
        margin-right: 0.25rem !important;
    }

    .d-flex {
        display: flex;
    }

    .justify-content-between {
        justify-content: space-between;
    }

    .align-items-center {
        align-items: center;
    }

    .w-100 {
        width: 100% !important;
    }

    /* ========== SEAT SELECTION STYLES ========== */

    /* Global Styles */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
    }

    .page-title {
        color: #2c3e50;
        font-weight: 600;
        margin-bottom: 10px;
    }

    .page-subtitle {
        color: #6c757d;
        margin-bottom: 30px;
    }

    .card {
        border: none;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }

    .card-header {
        background-color: #fff;
        border-bottom: 1px solid #e9ecef;
        border-radius: 10px 10px 0 0 !important;
        padding: 15px 20px;
    }

    .card-body {
        padding: 20px;
    }

    .btn {
        border-radius: 25px;
        padding: 8px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }

    .btn-success {
        background-color: #28a745;
        border-color: #28a745;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-secondary {
        background-color: #6c757d;
        border-color: #6c757d;
    }

    /* Seat Selection Styles */
    .seat-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(50px, 1fr));
        gap: 10px;
        max-width: 800px;
        margin: 20px auto;
    }

    .seat {
        width: 50px;
        height: 50px;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-weight: bold;
        font-size: 14px;
        transition: all 0.3s ease;
        position: relative;
    }

    .seat.available {
        background-color: #28a745;
        color: white;
        border-color: #28a745;
    }

    .seat.available.vip {
        background-color: #ffc107;
        color: #212529;
        border-color: #ffc107;
    }

    .seat.available.premium {
        background-color: #17a2b8;
        color: white;
        border-color: #17a2b8;
    }

    .seat.reserved {
        background-color: #dc3545;
        color: white;
        border-color: #dc3545;
        cursor: not-allowed;
    }

    .seat.selected {
        background-color: #007bff;
        color: white;
        border-color: #0056b3;
        box-shadow: 0 0 0 3px rgba(0,123,255,0.3);
    }

    .seat:hover:not(.reserved) {
        transform: scale(1.05);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }

    .seat::before {
        content: '';
        position: absolute;
        top: 5px;
        right: 5px;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: currentColor;
        opacity: 0.7;
    }

    .seat.vip::after {
        content: 'VIP';
        position: absolute;
        bottom: -15px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        font-weight: bold;
        color: #ffc107;
    }

    .seat.premium::after {
        content: 'Premium';
        position: absolute;
        bottom: -15px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        font-weight: bold;
        color: #17a2b8;
    }

    /* Legend */
    .legend {
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 20px;
        margin: 20px 0;
    }

    .legend-item {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .legend-seat {
        width: 30px;
        height: 30px;
        border-radius: 4px;
        border: 2px solid #dee2e6;
    }

    .legend-seat.available {
        background-color: #28a745;
        border-color: #28a745;
    }

    .legend-seat.vip {
        background-color: #ffc107;
        border-color: #ffc107;
    }

    .legend-seat.premium {
        background-color: #17a2b8;
        border-color: #17a2b8;
    }

    .legend-seat.reserved {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .legend-seat.selected {
        background-color: #007bff;
        border-color: #0056b3;
    }

    /* Form Styles */
    .form-group {
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 5px;
        border: 1px solid #ced4da;
        padding: 10px 15px;
    }

    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
    }

    .form-check-input:checked {
        background-color: #007bff;
        border-color: #007bff;
    }

    /* Alert Styles */
    .alert {
        border-radius: 8px;
        border: none;
        padding: 15px 20px;
    }

    .alert-success {
        background-color: #d4edda;
        color: #155724;
    }

    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .seat-grid {
            grid-template-columns: repeat(auto-fit, minmax(40px, 1fr));
        }

        .seat {
            width: 40px;
            height: 40px;
            font-size: 12px;
        }

        .card-body {
            padding: 15px;
        }
    }
</style>

