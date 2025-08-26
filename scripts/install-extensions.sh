
#!/usr/bin/env bash
while read -r uuid; do
  gnome-extensions install "$uuid" || true
  gnome-extensions enable "$uuid" || true
done < extensions.txt
