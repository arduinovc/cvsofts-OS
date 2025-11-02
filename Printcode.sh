#!/bin/bash
# -----------------------------------------------------------------------------
# Fusionne tous les fichiers de code d’un projet dans un seul fichier texte
# en ajoutant un en-tête avec :
# - le nom du fichier
# - son emplacement
# - sa taille
# - une description à compléter manuellement
# -----------------------------------------------------------------------------

OUTPUT_FILE="docs/export/cvsOS_merged.txt"

# Extensions de fichiers à inclure (à adapter selon ton projet)
INCLUDE_EXTENSIONS=("asm" "c" "h" "md")

# Dossiers à ignorer
EXCLUDE_DIRS=("template" "build")

# Supprime le fichier précédent s’il existe
rm -f "$OUTPUT_FILE"

# Fonction pour vérifier si un élément est dans un tableau
contains() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

# Boucle sur tous les fichiers du projet
find . -type f | while read -r file; do
    # Exclure le fichier de sortie et les dossiers ignorés
    [[ "$file" == "./$OUTPUT_FILE" ]] && continue

    skip=false
    for ex in "${EXCLUDE_DIRS[@]}"; do
        if [[ "$file" == *"/$ex/"* ]]; then
            skip=true
            break
        fi
    done
    $skip && continue

    # Vérifie l'extension
    ext="${file##*.}"
    if ! contains "$ext" "${INCLUDE_EXTENSIONS[@]}"; then
        continue
    fi

    # Récupère la taille du fichier (en octets)
    size=$(stat -f%z "$file" 2>/dev/null)

    # Écrit l’en-tête
    {
        echo "================================================================================"
        echo "📄 FICHIER : $(basename "$file")"
        echo "📁 EMPLACEMENT : ${file#./}"
        echo "📏 TAILLE : ${size:-inconnue} octets"
        echo "📝 DESCRIPTION : "
        echo "================================================================================"
        echo
        cat "$file"
        echo
        echo
    } >> "$OUTPUT_FILE"

done

echo "✅ Fusion terminée : fichier généré -> $OUTPUT_FILE"