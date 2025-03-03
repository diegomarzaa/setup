#!/bin/bash
# script para dividir audios en partes de 1h usando zenity, ffmpeg y ffprobe
# asegúrate de tener instalados ffmpeg, ffprobe y zenity

# selección de archivos mediante zenity (usa | como separador)
files=$(zenity --file-selection --multiple --title="selecciona archivos de audio" --file-filter="audio files | *.mp3 *.wav")
if [ -z "$files" ]; then
    zenity --error --text="no se ha seleccionado ningún archivo."
    exit 1
fi

# procesar cada archivo seleccionado
IFS="|"
for file in $files; do
    # obtener extensión y nombre base
    ext="${file##*.}"
    base="$(basename "$file" ".$ext")"
    dir="$(dirname "$file")"
    
    # obtener duración en segundos con ffprobe
    duration=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")
    duration_int=${duration%.*}  # parte entera de la duración

    if [ "$duration_int" -le 3600 ]; then
        # si dura 1h o menos, se copia y se renombra con sufijo _part1
        cp "$file" "$dir/${base}_part1.$ext"
        notify-send -u critical "Audio procesado" "Procesado: '${base}_part1.$ext'"

    else
        # si dura más de 1h, se divide en segmentos de 3600 segundos
        ffmpeg -i "$file" -f segment -segment_time 3600 -c copy "$dir/${base}_part_%03d.$ext"
        notify-send -u critical "División completada" "Archivo dividido: '$file'"

    fi
done

