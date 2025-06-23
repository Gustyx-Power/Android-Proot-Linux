#!/data/data/com.termux/files/usr/bin/bash

# === Warna Terminal ===
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║ 🐧 Debian KDE Installer + VNC (Auto Root Login) by Gustyx         ║"
echo "║ 🖥️  Biarin HP lo ada Plasma-nya juga 😎 {Your phone deserves KDE} ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# === 1. Cek Device & Internet ===
echo -e "${RED}[*] Cek koneksi internet... {Checking internet connection}${NC}"
pkg update -y
pkg install neofetch python -y
pip install speedtest-cli
neofetch
ping -c 3 8.8.8.8
speedtest

# === 2. Install Dependency Termux ===
echo -e "${GREEN}[*] Pasang keperluan Termux... {Installing Termux dependencies}${NC}"
pkg install proot tar wget curl xz-utils git -y

# === 3. Siapkan rootfs ===
echo -e "${GREEN}[*] Siapin direktori Debian... {Preparing Debian rootfs}${NC}"
DEBIAN_DIR="$HOME/debian-fs"
mkdir -p "$DEBIAN_DIR"

ROOTFS_URL="https://github.com/termux/proot-distro/releases/download/v4.17.3/debian-bookworm-aarch64-pd-v4.17.3.tar.xz"
ROOTFS_TAR="$HOME/debian-rootfs.tar.xz"

echo -e "${GREEN}[*] Mengunduh rootfs Debian ARM64... {Downloading Debian rootfs}${NC}"
wget -O "$ROOTFS_TAR" "$ROOTFS_URL" || { echo -e "${RED}[!] Gagal unduh rootfs. {Download failed}${NC}"; exit 1; }

# === 4. Ekstrak rootfs ===
echo -e "${GREEN}[*] Mengekstrak rootfs... {Extracting rootfs}${NC}"
tar --exclude='dev/*' -xpf "$ROOTFS_TAR" -C "$DEBIAN_DIR" --strip-components=1 || { echo -e "${RED}[!] Gagal ekstrak. {Extraction failed}${NC}"; exit 1; }
rm "$ROOTFS_TAR"

# === 5. Buat start-debian.sh ===
echo -e "${GREEN}[*] Bikin launcher start-debian.sh... {Creating Debian launcher}${NC}"
cat > "$HOME/start-debian.sh" << 'EOM'
#!/bin/bash
unset LD_PRELOAD
proot \
  --link2symlink \
  -0 \
  -r $HOME/debian-fs \
  -b /dev \
  -b /proc \
  -b /sdcard \
  -b $HOME \
  -w /root \
  /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    LANG=C.UTF-8 \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login -c "/root/first-run.sh || /bin/bash --login"
EOM

chmod +x "$HOME/start-debian.sh"
ln -sf "$HOME/start-debian.sh" "$PREFIX/bin/debian"
echo "alias debian='bash ~/start-debian.sh'" >> "$HOME/.bashrc"

# === 6. Setup Awal ===
echo -e "${GREEN}[*] Membuat first-run.sh... {Creating first-run.sh}${NC}"
cat > "$DEBIAN_DIR/root/first-run.sh" << 'EOM'
#!/bin/bash
echo "[*] Setup pertama Debian dimulai... {First-time setup begins}"

echo "nameserver 8.8.8.8" > /etc/resolv.conf

apt update
apt install sudo neofetch tightvncserver kde-plasma-desktop dbus-x11 -y

cat << EOF >> ~/.bashrc
clear
echo -e "\033[1;34m"
echo \"🚀 Selamat datang di Debian KDE (root) {Welcome to Debian KDE - root}\"
echo \"📦 Total paket: \$(dpkg -l | wc -l) {Installed packages}\"
neofetch
EOF

echo "[✓] Setup selesai! Jalankan ./vnc-start.sh untuk GUI {Setup done! Run ./vnc-start.sh}"
rm -- "$0"
EOM

chmod +x "$DEBIAN_DIR/root/first-run.sh"

# === 7. Script VNC KDE ===
echo -e "${GREEN}[*] Bikin script VNC KDE... {Creating VNC startup scripts}${NC}"
cat > "$DEBIAN_DIR/root/vnc-start.sh" << 'EOM'
#!/bin/bash

export USER=root
export DISPLAY=:2
export XDG_RUNTIME_DIR="/tmp/runtime-$USER"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

mkdir -p ~/.vnc
cat > ~/.vnc/xstartup << EOF
#!/bin/bash
dbus-launch --exit-with-session startplasma-x11
EOF
chmod +x ~/.vnc/xstartup

vncserver -kill :2 > /dev/null 2>&1
rm -f /tmp/.X2-lock
rm -rf /tmp/.X11-unix/X2

echo "[*] Menyalakan KDE Plasma di VNC :2... {Starting KDE on VNC :2}"
vncserver :2 -geometry 1280x720 -depth 24

echo "🔑 Password default VNC: 123456"
echo "📲 Hubungkan ke VNC Viewer → localhost:5902"
echo "[✓] KDE sudah siap ditatap layar lo 😎"
EOM

chmod +x "$DEBIAN_DIR/root/vnc-start.sh"

# === 8. vnc-stop & vnc-restart ===
cat > "$DEBIAN_DIR/root/vnc-stop.sh" << 'EOM'
#!/bin/bash
export USER=root
vncserver -kill :2
EOM
chmod +x "$DEBIAN_DIR/root/vnc-stop.sh"

cat > "$DEBIAN_DIR/root/vnc-restart.sh" << 'EOM'
#!/bin/bash
export USER=root
vncserver -kill :2
sleep 1
vncserver :2 -geometry 1280x720 -depth 24
EOM
chmod +x "$DEBIAN_DIR/root/vnc-restart.sh"

# === 9. Selesai ===
echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║ ✅ Debian KDE siap digunakan! {Debian KDE is ready!}                      ║"
echo "║ ▶️  Ketik: debian (auto login root + setup jalan sekali)                 ║"
echo "║ 🖥  GUI: ./vnc-start.sh  | 📲 VNC Viewer ke: localhost:5902              ║"
echo "║ 🔁 Restart: ./vnc-restart.sh | 🛑 Stop: ./vnc-stop.sh                    ║"
echo "║ 🔐 Default password VNC: 123456 {jangan lupa ganti ya 😅}               ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"