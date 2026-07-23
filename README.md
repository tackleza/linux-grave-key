**For English readers, please scroll down ⬇️**

# สวิตช์เลย์เอาต์ด้วยปุ่ม Grave

![Screenshot Image](https://raw.githubusercontent.com/tackleza/linux-grave-key/refs/heads/master/pic/screenshot.png)

สคริปต์นี้ใช้สำหรับสลับระหว่างแป้นพิมพ์ภาษาอังกฤษและภาษาไทย
(รวมถึงภาษาอื่นๆ) โดยใช้ปุ่ม grave/backquote (`)

## คุณสมบัติ

* ติดตั้งกฎ XKB และสัญลักษณ์สำหรับ `grp:grave_switch`
* ตรวจจับ Wayland หรือ X11 ให้อัตโนมัติ
* Wayland: ติดตั้งเฉพาะผู้ใช้ที่ `$XDG_CONFIG_HOME/xkb` หรือ
  `~/.config/xkb` โดยไม่ต้องใช้ `sudo`
* X11: ติดตั้งทั้งระบบที่ `/usr/share/X11/xkb` และสคริปต์จะขอสิทธิ์
  `sudo` เมื่อจำเป็น
* สามารถระบุโหมดเองด้วย `--wayland`, `--x11` หรือ `--auto`

## ความต้องการเบื้องต้น

* ระบบลินุกซ์ที่รองรับ X11 หรือ Wayland
* Wayland ต้องใช้ libxkbcommon 0.10.0 ขึ้นไปสำหรับไดเร็กทอรี XKB
  ระดับผู้ใช้
* X11 ต้องมี `sudo` หรือสิทธิ์ root สำหรับการติดตั้งทั้งระบบ

## การติดตั้ง

1. **โคลนรีโพซิทอรี (repository)**

   ```bash
   git clone https://github.com/tackleza/linux-grave-key.git
   cd linux-grave-key
   ```

   หรือดาวน์โหลดรีโพซิทอรีเป็นไฟล์ ZIP:
   [ดาวน์โหลด ZIP](https://github.com/tackleza/linux-grave-key/archive/refs/heads/master.zip)

2. **รันสคริปต์ติดตั้ง**

   ```bash
   chmod +x script.sh
   ./script.sh
   ```

   ค่าเริ่มต้นคือ `--auto` สคริปต์จะตรวจสอบ `XDG_SESSION_TYPE`
   และเลือก Wayland หรือ X11 ให้เอง

3. **ออกจากระบบและเข้าสู่ระบบใหม่**

   หรือรีบูตเครื่อง เพื่อให้การตั้งค่ามีผล

### ตัวอย่างผลลัพธ์เมื่อติดตั้งสำเร็จบน Wayland

```text
Detected session: wayland
Installing Wayland configuration for user: tackle
Target XKB directory: /home/tackle/.config/xkb
Copying rules...
Copying symbols...
Installation complete. Log out and back in, or reboot, to apply it.
```

ชื่อผู้ใช้และตำแหน่งไดเร็กทอรีจะแตกต่างกันไปในแต่ละเครื่อง

## การใช้งาน

```bash
# ตรวจจับ Wayland/X11 อัตโนมัติ (ค่าเริ่มต้น)
./script.sh
./script.sh --auto

# บังคับติดตั้งแบบ Wayland เฉพาะผู้ใช้ ห้ามรันด้วย sudo
./script.sh --wayland

# บังคับติดตั้งแบบ X11 ทั้งระบบ สคริปต์จะเรียก sudo ให้เอง
./script.sh --x11

# แสดงวิธีใช้
./script.sh --help
```

โหมดอัตโนมัติจะใช้ `XDG_SESSION_TYPE` ก่อน หากไม่มีค่านี้จะตรวจสอบ
`WAYLAND_DISPLAY` แล้วจึงตรวจสอบ `DISPLAY` ตามลำดับ หากตรวจจับไม่ได้
สคริปต์จะแจ้งให้เลือก `--wayland` หรือ `--x11` เอง

เมื่อการติดตั้งเสร็จสิ้น โปรด Logout หรือ Reboot เครื่อง หลังจากนั้นจะสามารถ
ใช้ grave/backquote (`) เพื่อสลับภาษาได้

---

# Grave Key Layout Switcher

A simple script that installs a custom XKB option for using the
grave/backquote key (`) to switch keyboard layouts on X11 or Wayland.

## Features

* Installs the XKB rules and symbols for `grp:grave_switch`
* Detects Wayland or X11 automatically
* Wayland: installs for the current user in `$XDG_CONFIG_HOME/xkb`, falling
  back to `~/.config/xkb`, without `sudo`
* X11: installs system-wide in `/usr/share/X11/xkb` and requests `sudo` only
  when necessary
* Supports explicit `--wayland`, `--x11`, and `--auto` modes

## Prerequisites

* A Linux distribution with X11 and/or Wayland support
* libxkbcommon 0.10.0 or newer for the Wayland per-user XKB directory
* `sudo` or root access for the system-wide X11 installation

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/tackleza/linux-grave-key.git
   cd linux-grave-key
   ```

   Or download the repository as a ZIP:
   [Download ZIP](https://github.com/tackleza/linux-grave-key/archive/refs/heads/master.zip)

2. **Run the install script**

   ```bash
   chmod +x script.sh
   ./script.sh
   ```

   The default mode is `--auto`. The script checks `XDG_SESSION_TYPE` and
   selects Wayland or X11 automatically.

3. **Restart your session**

   Log out and back in, or reboot your computer to apply the layout switcher.

### Successful Wayland output example

```text
Detected session: wayland
Installing Wayland configuration for user: tackle
Target XKB directory: /home/tackle/.config/xkb
Copying rules...
Copying symbols...
Installation complete. Log out and back in, or reboot, to apply it.
```

The username and target directory will differ between systems.

## Usage

```bash
# Detect Wayland/X11 automatically (default)
./script.sh
./script.sh --auto

# Force a per-user Wayland installation; do not use sudo
./script.sh --wayland

# Force a system-wide X11 installation; the script invokes sudo itself
./script.sh --x11

# Show help
./script.sh --help
```

Auto mode checks `XDG_SESSION_TYPE` first, followed by `WAYLAND_DISPLAY` and
then `DISPLAY`. If the session cannot be detected, the script asks you to
choose `--wayland` or `--x11` explicitly.

After installation, log out and back in or reboot. You can then use the
grave/backquote key (`) to switch the keyboard layout.
