cat > ~/.config/sway/scripts/gnome-wallpaper-sync.sh << 'EOF'
#!/bin/bash

STATE="$HOME/.config/sway/current_wallpaper"

apply_wallpaper() {
    uri=$(gsettings get org.gnome.desktop.background picture-uri | tr -d "'")
    img="${uri#file://}"

    [ -z "$img" ] && return
    [ ! -f "$img" ] && return

    pkill swaybg
    swaybg -i "$img" -m fill &

    echo "$img" > "$STATE"
}

# apply current wallpaper once at startup
apply_wallpaper

# watch for Nautilus / GNOME background changes
gsettings monitor org.gnome.desktop.background picture-uri | while read -r _; do
    apply_wallpaper
done
EOF
