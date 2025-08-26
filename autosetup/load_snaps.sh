#!/usr/bin/env bash
while read -r name vers …; do
  sudo snap install "$name" --revision="$vers" || true
done < <(awk 'NR>1 {print $1, $2}' lista_paquetes_snap.txt)
