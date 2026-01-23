#!/bin/bash

# Script pour initialiser la base de données avec des données de test
# Utilisation: ./init_db.sh

echo "Initialisation de la base de données..."

# Configuration de la base de données
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="taxi_brousse"
DB_USER="postgres"
DB_PASSWORD="motdepasse"

# Fonction pour exécuter un script SQL
execute_sql() {
    local script=$1
    echo "Exécution de $script..."
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "$script"
    if [ $? -eq 0 ]; then
        echo "✓ $script exécuté avec succès"
    else
        echo "✗ Erreur lors de l'exécution de $script"
        exit 1
    fi
}

# 0. Nettoyer les données existantes et réinitialiser les IDs
execute_sql "sql/clean_data.sql"

# 1. Créer les tables (au cas où elles n'existent pas)
execute_sql "sql/script.sql"

# 2. Insérer les données de base (statuts, admin)
execute_sql "sql/base.sql"

# 3. Insérer les données de test
execute_sql "sql/data.sql"

# 4. Créer les vues
execute_sql "sql/view.sql"

echo "Base de données initialisée avec succès!"