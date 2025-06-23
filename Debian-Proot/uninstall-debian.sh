#!/data/data/com.termux/files/usr/bin/bash

# === Warna Terminal ===
CYAN='\033[0;36m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║     🚨 Uninstall Debian Proot by Gustyx     ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"

read -p "⚠️  Are you sure you want to delete Debian Proot? All actions cannot be repeated (y/n): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
  echo -e "${RED}[✗] Deletion Canceled by user .${NC}"
  exit 0
fi
sleep 2s
echo -e "${GREEN}[*] Deleting Debian RootFS Directory...${NC}"
rm -rf "$HOME/debian-fs"
sleep 5s
echo -e "${GREEN}[*] Deleting script start-debian.sh...${NC}"
rm -f "$HOME/start-debian.sh"
rm -f "$PREFIX/bin/debian"
sleep 5s
echo -e "${GREEN}[*] Deleting .bashrc...${NC}"
sed -i '/alias debian=/d' "$HOME/.bashrc"
sleep 5s
echo -e "${GREEN}[*] Delete Rootfs...${NC}"
rm -f "$HOME/debian-rootfs.tar.xz"
sleep 6s
echo -e "${GREEN}[*] Delete VNC Cache script...${NC}"
rm -f "$HOME"/debian-fs/root/vnc-*.sh
sleep 5s
echo -e "${GREEN}[✓] Uninstall Done. Please Restart Termux.${NC}"