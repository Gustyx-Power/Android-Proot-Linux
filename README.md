# 🐧 Android-Proot-Linux 

Run full Linux distributions with GUI desktop environments inside **Termux** on Android — no root required.
This project provides **automated installers** for various Linux distros using **Proot**, VNC, and optional GUI enhancements.

> 🎯 Powered by [Termux](https://f-droid.org/en/packages/com.termux/) and maintained by **Gustyx-Power🇮🇩**.
> 🛠️ Great for learning, dev environments, remote SSH, and more.

---

## 💡 What Is This?

This is a unified Proot-based setup system for installing Linux distributions (like Debian, Ubuntu, Arch, etc.) in Termux, complete with:

* XFCE / KDE or etc. desktop (via VNC Viewer)
* Root login only
* Alias launcher (`debian`, `ubuntu`, etc.)
* Fully offline removal via `uninstall.sh`

---

## ✅ Features

* 🧠 One-command setup with GUI ready to use
* 💥 XFCE or KDE Plasma desktops (For other Desktops coming soon)
* 🧰 Root user with preconfigured `.bashrc` info
* 🌐 Internet + device info checks (neofetch, speedtest)
* 🧼 Easy uninstall script
* Primary Language Script Indonesian with brackets English

---

## 📦 Supported Distributions

| Distribution | Status          | Desktop Support |
| ------------ | --------------- | --------------- |
| Debian       | ⚠️ Experimental        | XFCE4, KDE(Broken)       |
| Ubuntu       | 🕻 Planned       | XFCE,KDE,LXQT planned    |
| Arch Linux   | 🕻 Planned      | TBD             |
| Kali Linux   | 🕻 Planned      | TBD             |
| Alpine Linux | 🕻 Planned      | TBD        |

> Each distro has its own setup script in folders like `debian/`, `ubuntu/`, etc.

---

## 📲 Installation

Run the following in Termux:

Download Zip in Release and move to /sdcard
mount termux on /sdcard
Example ::
```bash
cd /sdcard
cd Debian-Proot
cd XFCE or cd KDE (choose one)
bash debian-xfce.sh
---

## 🚀 Usage

```bash
debian    # or ubuntu, kali, etc.

# Inside the distro:
./vnc-start.sh     # Start GUI
./vnc-stop.sh      # Stop GUI
./vnc-restart.sh   # Restart VNC session
```

Use **VNC Viewer** app to connect:

```
Server: localhost:5901
Password: It depends on what password you create.
```

> 📂 You can transfer files between `/home` and `/sdcard`.

---

## 🥹 Uninstall

To completely remove a distro:
Extract the downloaded Zip in Release
And
Example :
```bash
cd /sdcard
cd Debian-Proot
bash uninstall.sh
```

Cleans up:

* Rootfs directory
* VNC scripts
* start-launcher
* `.bashrc` alias

---

## 👨‍🛠️ Maintainer

**Name:** Gustyx-Power
**Role:** Project Author & Maintainer
**Focus:** Termux, Linux, Android, Open Source

---

## 🖚 License

This project is licensed for educational, non-commercial, and personal use.
All included components (Debian, XFCE, etc.) are credited to their respective authors.

---

> “Linux is not just for desktops — it's for your pocket too.”
> — *Gustyx*
