# 🚀 Windows Auto-Setup Utility

![Setup Menu Preview](screenshot.png)


A simple script to automatically install essential software with `winget` after a fresh Windows 10/11 installation. Just run it and let it handle the tedious setup process for you.

## 📋 Project Overview
Setting up a new Windows machine takes time. This project provides a straightforward, no-fuss solution to install all your essential software in one go using `winget`.

### 🏗️ The Architecture
*   **`Setup.bat`**: The entry point. Handles Administrator elevation, detects your terminal settings, and ensures the script launches in a modern interface (Windows Terminal).
*   **`Installer.ps1`**: The core logic. A native PowerShell 5.1+ script featuring a paginated, zero-flicker menu that allows you to toggle apps and execute batch installations with built-in status detection.

---

## 📦 Included Software & Utilities

By default, the script includes a curated list of essential apps sorted alphabetically.

* 7-Zip
* AB Download Manager
* Brave Browser
* Chocolatey
* Discord
* Docker Desktop
* FxSound
* Git
* Glary Utilities
* Google Chrome
* HEVC Video Extensions
* LocalSend
* Mozilla Firefox
* MouseKey
* Node.js (Latest)
* OBS Studio
* Postman
* PotPlayer
* Power Switcher
* PowerShell 7
* qBittorrent
* QuickLook
* Sublime Text 4
* Telegram Desktop
* TranslucentTB
* VLC Media Player
* Visual Studio Code
* WhatsApp
* Windows Terminal
* Zoom

### 🛠️ Special Feature: System Tweaking
At the very bottom of the installation list, you will find an option to **LAUNCH: Chris Titus Windows Utility**. Selecting this will automatically download and execute the popular [WinUtil](https://christitus.com/win) tool for advanced Windows debloating, feature toggling, and system optimization after your apps are installed.

---

## 🚀 Getting Started

### 📋 Prerequisites
*   Windows 10 or 11.
*   `winget` (Windows Package Manager) must be installed.

> **⚠️ IMPORTANT NOTE:** If your system throws an error saying the `winget` command is not recognized, open the Microsoft Store and update/install the **"App Installer"** package provided by Microsoft.

### 📥 Cloning the Project
To clone this repository to your local machine using Git, run:
```bash
git clone https://github.com/r03iuL/win-auto-install.git
cd win-auto-install

```

### 📥 Alternative: Manual Download (Without Git)

If you don't have Git installed, you can download the repository directly:

1. Click the green **"<> Code"** button at the top of the repository page.
2. Select **"Download ZIP"**.
3. Right-click the downloaded `.zip` file and choose **"Extract All..."**.
4. Open the extracted folder and double-click **`Setup.bat`** to launch the installer.

### ▶️ How to Run

1. Navigate to the project folder.
2. Double-click **`Setup.bat`**.
3. Accept the **UAC (User Account Control)** prompt to grant Administrative privileges.
4. The interactive terminal window will open automatically.

---

## 🎮 Usage Guide

### 🕹️ Navigating the Menu

* **[⬆️⬇️ UP/DOWN Arrows]**: Navigate through your software list.
* **[␣ SPACEBAR]**: Toggle an app selection (Checked `[X]` = Install, Unchecked `[ ]` = Skip).
* **[↵ ENTER]**: Confirm your selection and begin the automated installation.

---

## ⚙️ Customization

You can easily add or remove software to fit your specific needs by editing `Installer.ps1`.

1. Open **`Installer.ps1`** in any text editor (VS Code, Notepad, etc.).
2. Locate the `$menuItems` array near the top of the file.
3. **To Add an App:** Add a new line following this exact format:
`[PSCustomObject]@{ Name = "App Name"; ID = "App.ID.From.Winget"; Selected = $true }`
*(Tip: Find the `App.ID` by running `winget search "AppName"` in your terminal).*
4. **To Remove an App:** Simply delete the corresponding line from the array.
5. Save the file and re-run **`Setup.bat`**.

---

## 🛡️ Security & Best Practices

* **🔒 Self-Elevation:** The `Setup.bat` is designed to elevate itself using industry-standard Windows Shell VBScript execution, ensuring no string-parsing crashes or credential leaking occurs.
* **🖥️ Native Compatibility:** The script avoids external dependencies and uses standard PowerShell 5.1 syntax, making it perfectly compatible with any fresh Windows machine out-of-the-box.
* **⚡ Smart Installation:** The execution phase runs in a clean mode, relying on WinGet's native manifest detection to safely skip already-installed applications.

---

## ⚖️ License

This project is open-source and available for personal and professional use. Feel free to fork and customize the software list to fit your specific workflow!