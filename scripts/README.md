# Docker Environment Testing Scripts

สคริปต์สำหรับทดสอบการติดตั้ง Docker บนระบบ Windows และ WSL2

## 📁 ไฟล์ในโฟลเดอร์นี้

1. **test_docker_windows.bat** - ทดสอบ Docker บน Windows
2. **test_docker_wsl.sh** - ทดสอบ Docker ใน WSL2
3. **README.md** - คู่มือการใช้งาน (ไฟล์นี้)

## 🚀 วิธีการใช้งาน

### ทดสอบบน Windows

1. เปิด Command Prompt หรือ PowerShell
2. ไปที่โฟลเดอร์ scripts:
```cmd
cd "D:\Coding\Appag\scripts"
```
3. รันสคริปต์:
```cmd
test_docker_windows.bat
```

### ทดสอบใน WSL2

มี 2 วิธี:

**วิธีที่ 1: รันจาก Windows**
```cmd
wsl -d Ubuntu bash /mnt/d/Coding/Appag/scripts/test_docker_wsl.sh
```

**วิธีที่ 2: รันจากภายใน WSL2**
1. เปิด WSL2 Ubuntu Terminal
2. Copy script ไปยัง home directory:
```bash
cp "/mnt/d/Coding/Appag/scripts/test_docker_wsl.sh" ~/
chmod +x ~/test_docker_wsl.sh
```
3. รันสคริปต์:
```bash
~/test_docker_wsl.sh
```

## ✅ ผลที่ควรได้รับ

### Windows Test ควรแสดง:
- ✅ Docker command found
- ✅ Docker Compose found
- ✅ Docker daemon is running
- ✅ Docker Desktop WSL2 integration detected
- ✅ Ubuntu WSL2 distro found
- ✅ Docker can run containers successfully

### WSL2 Test ควรแสดง:
- ✅ Docker found
- ✅ Docker daemon is accessible
- ✅ Docker socket exists
- ✅ Docker can run containers successfully
- ✅ Current user is in docker group

## 🔧 การแก้ปัญหาเบื้องต้น

### ถ้า Docker ไม่ทำงานบน Windows:
1. ตรวจสอบว่า Docker Desktop เปิดอยู่
2. ดูที่ System Tray ว่า Docker Desktop icon เป็นสีเขียว
3. ถ้ายังไม่ได้ ลอง restart Docker Desktop

### ถ้า Docker ไม่ทำงานใน WSL2:
1. ตรวจสอบ Docker Desktop Settings:
   - Settings > General > ติ๊ก "Use the WSL 2 based engine"
   - Settings > Resources > WSL Integration > ติ๊ก "Ubuntu"
2. Restart WSL2:
```cmd
wsl --shutdown
```
3. เปิด WSL2 ใหม่และทดสอบอีกครั้ง

### ถ้า User ไม่อยู่ใน docker group (WSL2):
```bash
sudo usermod -aG docker $USER
```
จากนั้น logout และ login ใหม่

## 📊 ตัวอย่างผลลัพธ์ที่ถูกต้อง

### Windows Output:
```
=====================================
Docker Environment Test for Windows
=====================================

[1] Checking Docker Desktop Installation...
-------------------------------------
✅ Docker command found
Docker version 24.0.7, build afdd53b

[2] Checking Docker Compose...
-------------------------------------
✅ Docker Compose v2 found
Docker Compose version v2.23.3

[3] Checking Docker Daemon Status...
-------------------------------------
✅ Docker daemon is running
```

### WSL2 Output:
```
=====================================
Docker Environment Test for WSL2
=====================================

[1] Checking System Information...
-------------------------------------
WSL2 Distribution: Ubuntu 22.04.3 LTS
Kernel: 5.15.133.1-microsoft-standard-WSL2

[2] Checking Docker Installation...
-------------------------------------
✅ docker found
Docker version 24.0.7, build afdd53b
```

## 💡 Tips

- ควรรันทดสอบทั้งสองสคริปต์เพื่อให้แน่ใจว่า Docker ทำงานได้ทั้งสองฝั่ง
- หากทุกอย่างแสดงผลเป็น ✅ แสดงว่าพร้อมสำหรับการพัฒนาแล้ว
- บันทึกผลการทดสอบไว้เพื่ออ้างอิงในอนาคต