#!/bin/bash

# The default path to xkb is the one below.
# You can use the 'tests' directory for testing:
# XKB_PATH=tests/xkb ./install.sh
if [ -z $XKB_PATH ]; then
    XKB_PATH="/usr/share/X11/xkb"
else
    echo "Using custom XKB_PATH: $XKB_PATH"
fi

exit_on_error() {
    if [ $1 -ne 0 ]; then
        echo "Error: Could not edit file $2"
    fi
}

exit_if_empty() {
    if [ -z "$1" ]; then
        revert
        echo "Expected line of text not found at file $2"
        exit 2
    fi
}


insert_text_to_file() {
    EDITFILE=$1
    SNIPPETFILE=$2
    LINE=$3
    ed "$EDITFILE" << EOF
    ${LINE}r ${SNIPPETFILE}
    w
EOF
}

create_backups() {
    sudo cp -n $XKB_PATH/symbols/de $XKB_PATH/symbols/de.BKP
    sudo cp -n $XKB_PATH/rules/base.lst $XKB_PATH/rules/base.lst.BKP
    sudo cp -n $XKB_PATH/rules/evdev.lst $XKB_PATH/rules/evdev.lst.BKP
    sudo cp -n $XKB_PATH/rules/base.xml $XKB_PATH/rules/base.xml.BKP
    sudo cp -n $XKB_PATH/rules/evdev.xml $XKB_PATH/rules/evdev.xml.BKP
}

revert() {
    sudo cp $XKB_PATH/symbols/de.BKP $XKB_PATH/symbols/de
    sudo cp $XKB_PATH/rules/base.lst.BKP $XKB_PATH/rules/base.lst
    sudo cp $XKB_PATH/rules/evdev.lst.BKP $XKB_PATH/rules/evdev.lst
    sudo cp $XKB_PATH/rules/base.xml.BKP $XKB_PATH/rules/base.xml
    sudo cp $XKB_PATH/rules/evdev.xml.BKP $XKB_PATH/rules/evdev.xml
}


show_help() {
    echo "This script copies the files to extend the German xkb keyboard with"
    echo "a new variant that facilitates typing in Portuguese. Must be run as"
    echo "root to copy the files. A backup is created to reverse if something"
    echo "goes wrong."
    echo "By default, the German(portuguese) variant extends dead-tilde variant"
    echo "and changes õ -> õ, ä -> ã, including the upper cases. The letters"
    echo "with umlaut can still be accessed with AltGr + Ö and AltGR + Ä."
    echo "Usage:"
    echo "install.sh [OPTIONS]"
    echo "Options:"
    echo " -r, --revert              Reverses the changes using the backups created."
    echo " -c, --eszett-to-cedilla   Changes the key <AE11> to type c cedilla ç"
    echo "                           and AltGr + s (key <AC02>) types ß."
    echo " -h                         Shows help.\n"
    echo "./install.sh -a            Mostrar ajuda em português."
}

show_help_pt() {
    echo "Este script copia os arquivos neste repositório para estender o layout"
    echo "de teclado xkb alemão com uma variante para facilitar digitação em português."
    echo "Por padrão, o script insere a variante German(portuguese) que estende"
    echo "a variante 'dead-tilde' e faz mudanças ö -> õ, ä -> a, incluindo"
    echo "em caixa alta. As letras com trema ä and ö ainda podem ser acessadas com"
    echo "AltGr + Ö e AltGR + Ä."
    echo "Uso:"
    echo "install.sh [OPÇÕES]"
    echo "Opções:"
    echo " -r, --revert              Reverte as mudanças com o backup criado."
    echo " -c, --eszett-to-ccedilla   Muda a tecla <AE11> para digitar c cedilla ç"
    echo "                           e AltGr + s (key <AC02>) digita ß."
    echo " -h, --help                Shows help in english."
}

keep_eszett=1

options=$( getopt -o crha: -l eszett-to-ccedilla,revert,help,ajuda -n "$0" -- "$@" )

[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}

eval set -- "$options"

while true; do
    case "$1" in
    --eszett-to-ccedilla | -c)
        keep_eszett=0
        ;;
    --revert|-r)
        revert
        exit 0
        ;;
    -h|--help)
        show_help
        exit 0
        ;;
    -a|--ajuda)
        show_help_pt
        exit 0
        ;;
    --)
        shift
        break
        ;;
    *)
        show_help
        exit 2
        ;;
    esac
    shift
done

# Avoids extending exsisting files.
if [ -f $XKB_PATH/symbols/de.BKP ]; then
    revert
fi

create_backups

FILE="$XKB_PATH/rules/evdev.xml"
LINE=$(awk '/<name>de</{f=1} f && /<variantList>/ {print NR; exit}' /usr/share/X11/xkb/rules/evdev.xml)
exit_if_empty "$LINE" "$FILE"
insert_text_to_file "$FILE" "./insert/evdev.xml" "$LINE" 1> /dev/null
exit_on_error $? "$FILE"

FILE="$XKB_PATH/rules/base.xml"
LINE=$(awk '/<name>de</{f=1} f && /<variantList>/ {print NR; exit}' /usr/share/X11/xkb/rules/evdev.xml)
exit_if_empty "$LINE" "$FILE"
insert_text_to_file "$FILE" "./insert/base.xml" "$LINE" 1> /dev/null
exit_on_error $? "$FILE"

FILE="$XKB_PATH/rules/evdev.lst"
LINE=$(grep -n -m 1 "! variant" "$FILE" | cut -f1 -d:)
exit_if_empty "$LINE" "$FILE"
insert_text_to_file "$FILE" "./insert/evdev.lst" "$LINE" 1> /dev/null
exit_on_error $? "$FILE"

FILE="$XKB_PATH/rules/base.lst"
LINE=$(grep -n -m 1 "! variant" "$FILE" | cut -f1 -d:)
exit_if_empty "$LINE" "$FILE"
insert_text_to_file "$FILE" "./insert/base.lst" "$LINE" 1> /dev/null
exit_on_error $? "$FILE"

FILE="$XKB_PATH/symbols/de"
LINE=$(grep -n -m 1 "partial alphanumeric_keys" "$FILE" | cut -f1 -d:)
exit_if_empty "$LINE" "$FILE" 1> /dev/null
exit_on_error $? "$FILE"

if [ $keep_eszett = "1" ]; then
    insert_text_to_file "$FILE" "./insert/de_keep_eszett" "$LINE" 1> /dev/null
else
    insert_text_to_file "$FILE" "./insert/de" "$LINE" 1> /dev/null
fi

echo "SUCCESS! Reboot to reload the keyboard layouts."

exit 0
