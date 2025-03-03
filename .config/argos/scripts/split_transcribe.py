#!/usr/bin/env python3

"""
### DESCRIPCIÓN GENERAL ###
Este script procesa archivos de audio dividiéndolos en segmentos de 1 hora (o menos si es el último segmento) y garantiza 
que cada segmento no supere los 25 MB mediante ajuste de bitrate. Luego, transcribe cada segmento usando la API de Groq y 
genera un archivo de texto con la transcripción, incluyendo marcas de tiempo cada minuto para facilitar la referencia.

### FUNCIONAMIENTO ###
1. **Selección de archivos**: El usuario selecciona archivos de audio a través de una interfaz gráfica.
2. **Análisis del audio**: Se obtiene la duración total del archivo.
3. **División en segmentos**:
   - Se extraen segmentos de hasta 3600 segundos (1 hora).
   - Se ajusta el bitrate automáticamente para que cada segmento no supere los 25 MB.
   - Se guarda cada segmento como un nuevo archivo.
4. **Transcripción**:
   - Se envía cada segmento a la API de Groq para obtener su transcripción.
   - Se recibe la transcripción con información detallada de timestamps.
5. **Generación de archivo de texto**:
   - Se combinan todas las transcripciones en un único archivo de texto.
   - Se añaden marcas de tiempo cada minuto para facilitar la navegación en el texto.
   - Se guarda la transcripción en un archivo con el mismo nombre base que el audio original.

### RESULTADO FINAL ###
- Archivos de audio segmentados (por ejemplo, `audio_part001.mp3`, `audio_part002.mp3`, etc.).
- Un archivo de transcripción (`audio_transcription.txt`) con el texto completo y marcas de tiempo cada minuto.

### REQUISITOS ###
- ffmpeg (para manipulación de audio)
- ffprobe (para obtener metadatos del audio)
- groq (para transcripción de audio)
- tkinter (para la selección de archivos)

"""

import os
import subprocess
import sys
import tkinter as tk
from tkinter import filedialog
from groq import Groq

# VARIABLES PERSONALES
API_KEY = "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"
LENGUAJE = "es" # ca, en
DEFAULT_FOLDER = "/home/diego/gdrive/Móvil/Grabaciones"

# CONSTANTES
MAX_SIZE_BYTES = 23 * 1024 * 1024

# Transcriptor
client = Groq(api_key=API_KEY)

# Función para obtener la duración real del audio usando ffprobe
def get_duration(filename):
    res = subprocess.run(
        ["ffprobe", "-v", "error", "-show_entries", "format=duration",
         "-of", "default=noprint_wrappers=1:nokey=1", filename],
        stdout=subprocess.PIPE, text=True
    )
    try:
        return float(res.stdout.strip())
    except:
        return 0.0

# Función que ejecuta ffmpeg para extraer y re-encodar el segmento
def extract_segment(input_file, start, seg_dur, output_file):
    # Calcula el bitrate máximo permitido para que el segmento no supere 25MB
    allowed_bps = int((MAX_SIZE_BYTES * 8) / seg_dur)
    allowed_kbps = allowed_bps // 1000
    target_bitrate = f"{allowed_kbps}k"
    # Se usa re-encoding para asegurar la extracción completa
    cmd = [
        "ffmpeg", "-y",
        "-ss", str(start),
        "-t", str(seg_dur),
        "-i", input_file,
        "-reset_timestamps", "1",
        "-ar", "16000",
        "-ac", "1",
        "-c:a", "libmp3lame",
        "-b:a", target_bitrate,
        output_file
    ]
    subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Función para dividir el audio completo en segmentos de hasta 1h
def split_audio(input_file, base, ext, total_dur):
    dir_path = os.path.dirname(input_file)
    segments = []
    start = 0
    part = 0
    # Mientras queden segundos por procesar
    while start < total_dur:
        seg_dur = min(3600, total_dur - start)
        output_file = os.path.join(dir_path, f"{base}_part{part:03d}.{ext}")
        extract_segment(input_file, start, seg_dur, output_file)
        # Verifica el tamaño; si por algún motivo supera el límite, se podría reducir bitrate (aquí ya usamos el máximo permitido)
        if os.path.getsize(output_file) > MAX_SIZE_BYTES:
            print(f"Advertencia: {output_file} supera los 25MB, pero se forzó bitrate máximo permitido.")
        segments.append((output_file, seg_dur))
        start += seg_dur
        part += 1
    return segments

# Transcribe el audio de un segmento usando Groq API (verbose_json para obtener timestamps)
def transcribe_segment(segment_file):
    with open(segment_file, "rb") as f:
        transcription = client.audio.transcriptions.create(
            file=(segment_file, f.read()),
            model="whisper-large-v3-turbo",
            language=LENGUAJE,
            response_format="verbose_json",
            temperature=0.0
        )
    # Se espera que la respuesta tenga una clave 'segments'
    return transcription.segments

# Combina todas las transcripciones agregando el offset según el segmento y guarda en un archivo de texto
def save_transcription(all_transcriptions, output_filepath):
    with open(output_filepath, "w", encoding="utf-8") as tf:
        current_min_marker = -1
        for seg_offset, segments in all_transcriptions:
            for entry in segments:
                # Ajusta el tiempo global sumando el offset (según el número de segmento * 3600)
                global_start = seg_offset + entry["start"]
                minute = int(global_start // 60)
                if minute != current_min_marker:
                    tf.write(f"\n[{minute} min]\n")
                    current_min_marker = minute
                tf.write(entry["text"].strip() + " ")
    print(f"✅ Transcripción guardada en: {output_filepath}")

def main():

    # Ensure the default folder exists
    if not os.path.isdir(DEFAULT_FOLDER):
        print(f"The directory {DEFAULT_FOLDER} does not exist.")
    else:
        root = tk.Tk()
        root.withdraw()
        file_paths = filedialog.askopenfilenames(
            title="Selecciona archivos de audio",
            filetypes=[("Audio files", "*.mp3 *.wav")],
            initialdir=DEFAULT_FOLDER
        )

        if file_paths:
            print("Selected files:", file_paths)
        else:
            print("No files selected.")
            sys.exit(1)
    
    for file in file_paths:
        total_dur = get_duration(file)
        if total_dur <= 0:
            print(f"No se pudo determinar la duración de {file}")
            continue
        dir_path = os.path.dirname(file)
        base = os.path.splitext(os.path.basename(file))[0]
        ext = os.path.splitext(file)[1].lstrip(".")
        print(f"Procesando '{file}' (duración: {total_dur:.2f} s)...")
        segments = split_audio(file, base, ext, total_dur)
        all_transcriptions = []
        for idx, (seg_file, seg_dur) in enumerate(segments):
            print(f"Transcribiendo segmento {idx+1} ({seg_file})...")
            transcrip = transcribe_segment(seg_file)
            # Calcula offset global: idx * 3600 (para segmentos completos, el último puede ser menor)
            offset = idx * 3600
            all_transcriptions.append((offset, transcrip))
        output_txt = os.path.join(dir_path, f"{base}_transcription.txt")
        save_transcription(all_transcriptions, output_txt)

if __name__ == "__main__":
    main()

