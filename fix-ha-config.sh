#!/bin/bash
# Home Assistant config fix script

CONFIG_PATH="/mnt/data/supervisor/homeassistant/configuration.yaml"

echo "Config dosyası yedekleniyor..."
cp "$CONFIG_PATH" "${CONFIG_PATH}.bak"

echo "Yeni config yazılıyor..."
cat > "$CONFIG_PATH" << 'EOF'
# Loads default set of integrations. Do not remove.
default_config:

# Load frontend themes from the themes folder
frontend:
  themes: !include_dir_merge_named themes

automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml

homeassistant:
  external_url: "https://home.hosgor.cloud"
  internal_url: "http://192.168.1.146:8123"

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.16.0.0/12
    - 192.168.0.0/16
    - 127.0.0.1
EOF

echo "Home Assistant yeniden başlatılıyor..."
ha core restart
echo "Tamamlandı!"