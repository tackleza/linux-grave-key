**For English readers, please scroll down ⬇️**

# สวิตช์เลย์เอาต์ด้วยปุ่ม Grave

![Screenshot Image](https://raw.githubusercontent.com/tackleza/linux-grave-key/refs/heads/master/pic/screenshot.png)

สคริปต์นี้ใช้สำหรับสลับระหว่างแป้นพิมพ์ภาษาอังกฤษ และภาษาไทย (และภาษาอื่นๆ) โดยใช้ปุ่ม grave/backquote (\`)

## คุณสมบัติ

* ติดตั้งกฎ XKB และสัญลักษณ์สำหรับ `grp:grave_switch`
* วางไฟล์ในไดเร็กทอรีระบบที่เหมาะสม:

  * `rules/` → `/usr/share/X11/xkb/rules/`
  * `symbols/` → `/usr/share/X11/xkb/symbols/`
* ทำงานได้ทั้งบน X11 และ Wayland ผ่าน libxkbcommon

## ความต้องการเบื้องต้น

* ระบบลินุกซ์ที่รองรับ X11 หรือ Wayland
* สิทธิ์ root (sudo) ในการคัดลอกไฟล์ไปยังไดเร็กทอรีระบบ

## การติดตั้ง

1. **โคลนรีโพซิทอรี (repository)**

   ```bash
   git clone https://github.com/tackleza/linux-grave-key.git
   cd linux-grave-key
   ```
   หรือดาวน์โหลดรีโพซิทอรีเป็นไฟล์ ZIP: [ดาวน์โหลด ZIP](https://github.com/tackleza/linux-grave-key/archive/refs/heads/master.zip)
   
3. **รันสคริปต์ติดตั้ง**

   ```bash
   chmod +x script.sh
   sudo ./script.sh
   ```
4. **ออกจากระบบและเข้าสู่ระบบใหม่**
   หรือรีบูตเครื่อง เพื่อให้การตั้งค่ามีผล

## การใช้งาน

เมื่อการติดตั้งเสร็จสิ้น โปรด Logout หรือ Reboot เครื่อง, หลังจากนั้นจะสามารถใช้ grave/backquote (\`) เพื่อสลับภาษาได้


---

# Grave Key Layout Switcher

A simple script to install a custom XKB option that uses the grave/backquote key (\`) to toggle keyboard layouts under X11 (and compatible with Wayland via libxkbcommon).

## Features

* Installs custom XKB rules and symbols to enable `grp:grave_switch` option
* Places files in the proper system directories:

  * `rules/` → `/usr/share/X11/xkb/rules/`
  * `symbols/` → `/usr/share/X11/xkb/symbols/`
* Works out-of-the-box on X11 and is honored by Wayland compositors via libxkbcommon

## Prerequisites

* A Linux distribution with X11 and/or Wayland support
* Root (sudo) privileges to copy files into system directories

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/tackleza/linux-grave-key.git
   cd linux-grave-key
   ```
   Or download the repository as a ZIP: [Download ZIP](https://github.com/tackleza/linux-grave-key/archive/refs/heads/master.zip)
   
2. **Run the install script**

   ```bash
   chmod +x script.sh
   sudo ./script.sh
   ```
3. **Restart your session**
   Log out and back in, or reboot your computer to apply the new layout switcher.

## Usage

After installation and restarting your session, now you can use grave/backquote key (\`) for switch the keyboard layout
