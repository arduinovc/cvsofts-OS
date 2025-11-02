#!/bin/bash
# -----------------------------------------------------------------------------
# Merge all project files into one file with headers.
# Includes specific files without extensions (like Makefile).
# -----------------------------------------------------------------------------

OUTPUT_FILE="docs/export/cvsOS_merged.txt"

# Extensions of files to include
INCLUDE_EXTENSIONS=("asm" "h" "c" "md")

# Specific filenames (without extension) to include
INCLUDE_FILES=("Makefile")

# Folders to exclude
EXCLUDE_DIRS=("nbuild" "docs/export")

# Remove previous merged file
rm -f "$OUTPUT_FILE"

# Helper: check if array contains a value
contains() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

# Walk through all files
find . -type f | while read -r file; do
    # Skip output file and excluded directories
    [[ "$file" == "./$OUTPUT_FILE" ]] && continue

    skip=false
    for ex in "${EXCLUDE_DIRS[@]}"; do
        if [[ "$file" == *"/$ex/"* ]]; then
            skip=true
            break
        fi
    done
    $skip && continue

    # Get file name and extension
    filename=$(basename "$file")
    ext="${filename##*.}"

    # Include if it matches either extension or filename list
    include=false
    if contains "$ext" "${INCLUDE_EXTENSIONS[@]}"; then
        include=true
    elif contains "$filename" "${INCLUDE_FILES[@]}"; then
        include=true
    fi

    $include || continue

    # Get size (in bytes)
    size=$(stat -f%z "$file" 2>/dev/null)

    # Write header + content
    {
        echo "================================================================================"
        echo "📄 FICHIER : $filename"
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

echo "Fusion terminée : fichier généré -> $OUTPUT_FILE"