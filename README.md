# สวิตช์เลย์เอาต์ด้วยปุ่ม Grave

**สำหรับผู้อ่านภาษาอังกฤษ โปรดเลื่อนลงไปเพื่อดูเวอร์ชันภาษาอังกฤษ**

สคริปต์นี้ใช้สำหรับสลับระหว่างแป้นพิมพ์ภาษาอังกฤษ (US) และภาษาไทย โดยใช้ปุ่ม grave/backquote (\`)

## คุณสมบัติ

* ติดตั้งกฎ XKB และสัญลักษณ์สำหรับ `grp:grave_switch`
* วางไฟล์ในไดเร็กทอรีระบบที่เหมาะสม:

  * `rules/` → `/usr/share/X11/xkb/rules/`
  * `symbols/` → `/usr/share/X11/xkb/symbols/`
  * `xkb/`     → `/etc/X11/xkb/`
* ทำงานได้ทั้งบน X11 และ Wayland ผ่าน libxkbcommon

## ความต้องการเบื้องต้น

* ระบบลินุกซ์ที่รองรับ X11 หรือ Wayland
* สิทธิ์ root (sudo) ในการคัดลอกไฟล์ไปยังไดเร็กทอรีระบบ

## การติดตั้ง

1. **โคลนรีโพซิทอรี (repository)**

   ```bash
   git clone https://github.com/yourusername/grave-key-switcher.git
   cd grave-key-switcher
   ```
2. **รันสคริปต์ติดตั้ง**

   ```bash
   chmod +x script.sh
   sudo ./script.sh
   ```
3. **ออกจากระบบและเข้าสู่ระบบใหม่**
   หรือรีบูตเครื่อง เพื่อให้การตั้งค่ามีผล

## การใช้งาน

กดปุ่ม grave/backquote (\`) เพื่อสลับระหว่าง:

* **English (US)**
* **Thai**

ไม่มีการพิมพ์เครื่องหมาย backtick ในแอปพลิเคชัน ทุกครั้งที่กดจะสลับภาษาทันที

## ปัญหาที่ทราบ

* ในเซสชัน Wayland การกดปุ่ม grave จะสลับได้เพียงครั้งเดียว (จาก English → Thai) และจะไม่สลับกลับไปเป็น English ในการกดครั้งที่สอง แต่บน X11 จะสลับสองทิศทางได้ตามปกติ

---

# Grave Key Layout Switcher

**For English readers, please scroll down for the English version.**

A simple script to install a custom XKB option that uses the grave/backquote key (\`) to toggle between English (US) and Thai keyboard layouts under X11 (and compatible with Wayland via libxkbcommon).

## Features

* Installs custom XKB rules and symbols to enable `grp:grave_switch` option
* Places files in the proper system directories:

  * `rules/` → `/usr/share/X11/xkb/rules/`
  * `symbols/` → `/usr/share/X11/xkb/symbols/`
  * `xkb/`     → `/etc/X11/xkb/`
* Works out-of-the-box on X11 and is honored by Wayland compositors via libxkbcommon

## Prerequisites

* A Linux distribution with X11 and/or Wayland support
* Root (sudo) privileges to copy files into system directories

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/grave-key-switcher.git
   cd grave-key-switcher
   ```
2. **Run the install script**

   ```bash
   chmod +x script.sh
   sudo ./script.sh
   ```
3. **Restart your session**
   Log out and back in, or reboot your computer to apply the new layout switcher.

## Usage

After installation and restarting your session, press the grave/backquote key (\`) to toggle between:

* **English (US)**
* **Thai**

No stray backticks will be emitted into your applications—each press cleanly switches your layout.

## Known Issue

* Under Wayland sessions, the grave key toggles only once (English → Thai) and does not toggle back to English on the second press. On X11 the toggle works bidirectionally as expected.
