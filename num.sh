#!/bin/bash
#creador sin nombre
phone_info() {
    read -p "Ingrese el número de teléfono (con código de país): " phone_number
    response=$(curl -s "http://apilayer.net/api/validate?access_key=1a80b9ffe55da509c3efe243cea3d986&number=$phone_number&country_code=&format=1")
    valid=$(echo $response | jq '.valid')
    if [ "$valid" = "true" ]; then
        country=$(echo $response | jq '.country_name')
        location=$(echo $response | jq '.location')
        carrier=$(echo $response | jq '.carrier')
        line_type=$(echo $response | jq '.line_type')
        local_format=$(echo $response | jq '.local_format')
        international_format=$(echo $response | jq '.international_format')
        echo "Información del número de teléfono:"
        echo "País: $country"
        echo "Ubicación: $location"
        echo "Compañía telefónica: $carrier"
        echo "Tipo de línea: $line_type"
        echo "Formato local: $local_format"
        echo "Formato internacional: $international_format"
    else
        echo "Número de teléfono no válido."
    fi
}

main_menu() {
    echo "Seleccione una opción:"
    echo "1. Buscar información de un número de teléfono"
    echo "2. Salir"
    read -p "> " choice
    case $choice in
        1) phone_info ;;
        2) exit ;;
        *) echo "Opción inválida. Inténtalo de nuevo." ;;
    esac
}

while true; do
    main_menu
done
