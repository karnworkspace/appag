# Skill.md - Knowledge Base หลักของโปรเจกต์ Appag

## วัตถุประสงค์ของไฟล์
- เป็นฐานความรู้ร่วมกันระหว่างทีมพัฒนาและผู้เกี่ยวข้อง
- บันทึกสิ่งสำคัญที่เกิดขึ้นระหว่างการพัฒนาโปรเจกต์
- เป็นแหล่งอ้างอิงเมื่อต้องการทบทวนข้อมูล

## หลักการทำงาน: PDCA (Plan-Do-Check-Act)
### กระบวนการทำงานร่วมกัน
1. **Plan (วางแผน)** 
   - AI จะเสนอแผนการทำงานและวิเคราะห์ผลที่คาดว่าจะได้รับ
   - อธิบายเหตุผลและประโยชน์ของสิ่งที่จะทำ
   - ระบุความเสี่ยงหรือข้อควรระวัง (ถ้ามี)

2. **Do (ลงมือทำ)** 
   - **รอการอนุมัติจากผู้ใช้ทุกครั้งก่อนลงมือทำ**
   - เมื่อได้รับอนุมัติ จึงเริ่มดำเนินการตามแผน
   - บันทึกขั้นตอนการทำงานอย่างละเอียด

3. **Check (ตรวจสอบ)**
   - ตรวจสอบผลลัพธ์ว่าตรงตามที่วางแผนไว้หรือไม่
   - วิเคราะห์ปัญหาที่พบ (ถ้ามี)
   - นำเสนอผลการตรวจสอบให้ผู้ใช้ทราบ

4. **Act (ปรับปรุง)**
   - ปรับปรุงแก้ไขตามข้อเสนอแนะ
   - บันทึกบทเรียนที่ได้รับ
   - อัพเดทแผนงานสำหรับรอบถัดไป

### ข้อตกลงการทำงาน
- ❌ **ไม่ลงมือทำทันที** โดยไม่ได้รับอนุมัติ
- ✅ **ต้องนำเสนอแผนก่อนเสมอ** พร้อมวิเคราะห์ผลกระทบ
- ✅ **รอการอนุมัติจากผู้ใช้** ในทุกขั้นตอนสำคัญ
- ✅ **บันทึกผลการทำงาน** ไว้ใน Skill.md เสมอ

## ข้อมูลโปรเจกต์
- ชื่อโปรเจกต์: Appag (Task Management System)
- คำอธิบายโปรเจกต์: ระบบรวบรวมและจัดการนัดหมายงานจาก Gmail เพื่อแจ้งเตือนและแสดงข้อมูลอย่างรวดเร็ว
- สถานะ: ออกแบบสถาปัตยกรรมระบบและวาด Mindmap

## สมาชิกทีม
- ผู้พัฒนาระบบ (AI Assistant)
- ผู้ประสานงานโปรเจกต์

## เทคโนโลยีที่ใช้
- **Architecture**: Web Application (Containerized with Docker)
- **Frontend**: React.js หรือ Vue.js
- **Backend**: Node.js with Express.js
- **Database**: MongoDB
- **Email Integration**: Gmail API (via Google Cloud Platform)
- **Authentication**: OAuth 2.0
- **Notification**: Web Push API, Email, SMS (Optional)
- **Deployment**: Docker Compose (Local) → Cloud Platform (Production)

## Development Environment (ผู้ใช้)
- **Host OS**: Windows 11 Pro 64-bit
- **Virtualization**: WSL2 (Windows Subsystem for Linux 2)
- **Linux Distro**: Ubuntu 22.04 LTS (ผ่าน WSL2)
- **GPU**: NVIDIA RTX 4060 Ti + Driver v581.15 + CUDA 13.0
- **Container Platform**: Docker Desktop + WSL2 backend
- **Editor/IDE**: VS Code + Remote-WSL Extension
- **Source Storage**: ~/projects (ใน WSL2) → \\wsl$\Ubuntu\home\karnc\projects
- **Network**: LAN IP (Static Fixed)

## การติดตั้งและการใช้งาน Docker ใน WSL2

### สิ่งที่ติดตั้งแล้ว
- ✅ **Docker CE version 28.5.1** ใน WSL2 Ubuntu 24.04.3 LTS
- ✅ **Docker Compose v2.40.1** (มาพร้อมกับ Docker CE)
- ✅ **User karnc** เพิ่มเข้า docker group แล้ว (ไม่ต้องใช้ sudo)
- ✅ **Docker Networks**: bridge, host, none พร้อมใช้งาน
- ✅ **Docker Socket**: /var/run/docker.sock พร้อมใช้งาน

### วิธีการใช้งาน Docker ใน WSL2

#### 1. เปิด WSL2 Ubuntu
```bash
wsl -d Ubuntu
```

#### 2. Start Docker Service (ต้องทำทุกครั้งที่เปิด WSL2)
```bash
sudo service docker start
```

#### 3. ตรวจสอบสถานะ Docker
```bash
docker --version
docker ps
```

#### 4. การทดสอบ Docker
```bash
# ทดสอบพื้นฐาน
docker run hello-world

# ดู containers ที่กำลังรัน
docker ps

# ดู images ทั้งหมด
docker images
```

### Scripts ที่สร้างไว้
1. **test_docker_windows.bat** - ทดสอบ Docker บน Windows
   ```cmd
   cd "D:\Coding\Appag\scripts"
   .\test_docker_windows.bat
   ```

2. **test_docker_wsl.sh** - ทดสอบ Docker ใน WSL2
   ```bash
   cd /mnt/d/Coding/Appag/scripts
   bash test_docker_wsl.sh
   ```
   
3. **ผลการทดสอบล่าสุด (18 ตุลาคม 2025)**
   - ✅ Docker daemon accessible 
   - ✅ Docker Compose v2 พร้อมใช้งาน
   - ✅ User permissions ถูกต้อง
   - ✅ สามารถรัน containers ได้
   - ✅ **สถานะ: พร้อมพัฒนาโปรเจกต์แล้ว**

### การตั้งค่า Auto-start Docker (Optional)
ถ้าต้องการให้ Docker start อัตโนมัติเมื่อเปิด WSL2:
```bash
echo "sudo service docker start" >> ~/.bashrc
```

## บันทึกการทำงาน
### วันที่: [วันที่ปัจจุบัน]
- เริ่มต้นสร้างโปรเจกต์
- สร้างไฟล์ Skill.md เพื่อเป็น Knowledge Base หลัก
- วางโครงสร้างพื้นฐานของไฟล์
### วันที่: [วันที่ปัจจุบัน]
- วิเคราะห์ปัญหา: ผู้ใช้มีงานมากมายและได้รับการนัดหมายผ่านอีเมลทั้งแบบ calendar และอีเมลปกติ
- ระบุความต้องการ: ต้องการระบบที่รวบรวมนัดหมายทั้งหมด แจ้งเตือนเมื่อถึงเวลาทำงาน และแสดงข้อมูลได้อย่างรวดเร็ว
- ได้รับ Mindmap concept จากผู้ใช้ (3 รูป) แสดงโครงสร้างระบบอย่างละเอียด
- ทบทวนและวิเคราะห์ Mindmap เพื่อปรับปรุงแนวคิดการออกแบบ

## แผนงานในอนาคต
1. ✅ วิเคราะห์ความต้องการของระบบ
2. ✅ ออกแบบสถาปัตยกรรมของโปรเจกต์ (มี Mindmap แล้ว)
3. ✅ เลือกเทคโนโลยีที่เหมาะสม
4. ⏳ เริ่มพัฒนาระบบตามลำดับ:
   - Phase 1: Gmail Integration & Email Parsing
   - Phase 2: Data Processing & Task Management
   - Phase 3: Dashboard & UI Development
   - Phase 4: Notification System
   - Phase 5: Testing & Deployment

## ข้อสังเกตและปัญหาที่พบ
- ยังไม่มีข้อมูลเพิ่มเติม

## วิเคราะห์ปัญหา
- ปัญหาหลัก: ผู้ใช้มีงานมากมาย ได้รับการนัดหมายผ่านอีเมลหลายรูปแบบ (calendar invite และ email ปกติ)
- ความยากลำบาก: ไม่สามารถติดตามงานทั้งหมดได้อย่างมีประสิทธิภาพ
- ผลกระทบ: อาจทำให้พลาดการทำงานที่สำคัญได้

## ความต้องการของระบบ
1. ต้องการรวบรวมนัดหมายงานจากอีเมลทุกรูปแบบ (calendar invite และ email ปกติ)
2. ต้องการแจ้งเตือนเมื่อถึงเวลาทำงาน
3. ต้องการดูข้อมูลงานได้อย่างรวดเร็วและง่ายดาย
4. ต้องการจัดระเบียนงานให้เป็นระบบ

## ข้อเสนอแนะวิธีแก้ปัญหา
1. สร้างระบบดึงข้อมูลจากอีเมล (email parser)
2. จัดเก็บข้อมูลนัดหมายในฐานข้อมูล
3. สร้างหน้าจอแสดงข้อมูลแบบ timeline/calendar
4. สร้างระบบแจ้งเตือน (notification) เมื่อถึงเวลา
5. มีฟังก์ชันค้นหาและกรองข้อมูลงานได้

## คำตอบคำถามก่อนหน้า
1. ใช้บริการอีเมล: Gmail เป็นหลัก
2. ความต้องการเพิ่มเติม: ต้องการ Mindmap แนวคิดการออกแบบระบบ

## สรุป Mindmap ที่ได้รับจากผู้ใช้

### Mindmap 1: โครงสร้างหลักของระบบ
แสดงองค์ประกอบหลัก 7 ส่วน:
1. **Gmail Integration Layer** - การเชื่อมต่อ Gmail
2. **Data Processing Core** - แกนประมวลผลข้อมูล
3. **Intelligent Dashboard** - แดชบอร์ดอัจฉริยะ
4. **Smart Notification System** - ระบบแจ้งเตือนอัจฉริยะ
5. **User Experience** - ประสบการณ์ผู้ใช้งาน
6. **Technology Stack** - เทคโนโลยีที่ใช้
7. **Development Plan** - แผนการพัฒนา

### Mindmap 2: รายละเอียด Dashboard และ Notification
**Intelligent Dashboard:**
- Timeline View (มุมมองไทม์ไลน์): Weekly, Monthly, Daily
- Quick Access (การเข้าถึงด่วน): Today's Tasks, Tomorrow's Tasks, Urgent Tasks
- Smart Filtering & Search (กรองและค้นหา): By Category, Date Range, People, Priority
- Visual Indicators (ตัวบ่งชี้ภาพ): Color Coding, Status Icons, Progress Bars

**Smart Notification System:**
- Pre-Alerts (แจ้งเตือนล่วงหน้า): 15 นาที, 1 ชั่วโมง, 1 วัน
- Daily Summary (สรุปประจำวัน): Morning Briefing, Evening Review
- Emergency Alerts (แจ้งเตือนด่วน): Real-time Critical Tasks
- Notification Channels (ช่องทางแจ้งเตือน): Email, Push Notification, SMS

### Mindmap 3: User Experience และการจัดการข้อมูล
**Multi-platform Access:**
- Web Application
- Mobile App
- Desktop Widget

**Personalization (การปรับแต่ง):**
- Custom Views (มุมมองกำหนดเอง)
- Alert Preferences (ตั้งค่าการแจ้งเตือน)
- Theme Selection (เลือกธีม)

**Data Management (การจัดการข้อมูล):**
- Export/Import (นำเข้า/ส่งออก)
- Backup & Recovery (สำรองและกู้คืน)
- History & Archive (ประวัติและจัดเก็บ)

## Mindmap แนวคิดการออกแบบระบบ (Smart Task Management System)

```
Smart Task Management System
├── Gmail Integration Layer
│   ├── Gmail API Connection
│   ├── Email Parsing Engine
│   │   ├── Calendar Invite (ICS Files)
│   │   ├── Meeting Requests
│   │   ├── Deadline Emails
│   │   └── Appointment Emails
│   └── Automated Email Scanning
│       ├── Keyword Detection (นัดหมาย, ประชุม, deadline)
│       └── Schedule Extraction
├── Data Processing Core
│   ├── Task Standardization
│   │   ├── Convert to Standard Format
│   │   ├── Categorization (Meeting, Deadline, Appointment)
│   │   └── Priority Assignment
│   ├── Information Extraction
│   │   ├── Date & Time
│   │   ├── Location
│   │   ├── Attendees
│   │   ├── Details & Description
│   │   └── Attachments
│   └── Duplicate Detection
│       └── Merge Similar Tasks
├── Intelligent Dashboard
│   ├── Timeline View
│   │   ├── Weekly Overview
│   │   ├── Monthly Overview
│   │   └── Daily Details
│   ├── Quick Access
│   │   ├── Today's Tasks
│   │   ├── Tomorrow's Tasks
│   │   └── Urgent Tasks
│   ├── Smart Filtering & Search
│   │   ├── By Category
│   │   ├── By Date Range
│   │   ├── By People
│   │   └── By Priority
│   └── Visual Indicators
│       ├── Color Coding
│       ├── Status Icons
│       └── Progress Bars
├── Smart Notification System
│   ├── Pre-Alerts
│   │   ├── 15 Minutes Before
│   │   ├── 1 Hour Before
│   │   └── 1 Day Before
│   ├── Daily Summary
│   │   ├── Morning Briefing
│   │   └── Evening Review
│   ├── Emergency Alerts
│   │   └── Real-time Critical Tasks
│   └── Notification Channels
│       ├── Email
│       ├── Push Notification
│       └── SMS (Optional)
└── User Experience
    ├── Multi-platform Access
    │   ├── Web Application
    │   ├── Mobile App
    │   └── Desktop Widget
    ├── Personalization
    │   ├── Custom Views
    │   ├── Alert Preferences
    │   └── Theme Selection
    └── Data Management
        ├── Export/Import
        ├── Backup & Recovery
        └── History & Archive
```

## แนวทางการพัฒนาต่อไป

### Phase 0: Project Setup & Feasibility (สัปดาห์ที่ 1)
- [x] ติดตั้ง Docker ใน WSL2 ✅
- [x] สร้าง scripts ทดสอบ Docker environment ✅
- [x] ทดสอบและยืนยันความพร้อมของ Docker ✅
- [ ] สร้างโครงสร้างโปรเจกต์ Docker-based
- [ ] สร้าง Docker Compose configuration
- [ ] Setup Backend (Node.js + Express)
- [ ] Setup Frontend (React)
- [ ] Setup MongoDB container

### Phase 1: Gmail Integration (สัปดาห์ที่ 2-3)
- [ ] Setup Gmail API credentials ใน Google Cloud Console
- [ ] สร้าง OAuth 2.0 authentication flow
- [ ] ทดสอบการเชื่อมต่อกับ Gmail API
- [ ] พัฒนา Email Parser สำหรับ:
  - Calendar invites (ICS files)
  - Meeting requests
  - Deadline emails
  - General appointments

### Phase 2: Data Processing (สัปดาห์ที่ 3-4)
- [ ] ออกแบบ Database Schema
- [ ] สร้าง Task Standardization module
- [ ] พัฒนา Information Extraction engine
- [ ] สร้าง Duplicate Detection system

### Phase 3: Dashboard UI (สัปดาห์ที่ 5-6)
- [ ] ออกแบบ UI/UX mockups
- [ ] พัฒนา Timeline View components
- [ ] สร้าง Quick Access panels
- [ ] Implement Smart Filtering & Search

### Phase 4: Notification System (สัปดาห์ที่ 7)
- [ ] Setup notification infrastructure
- [ ] พัฒนา Pre-Alert system
- [ ] สร้าง Daily Summary generator
- [ ] Implement multi-channel notifications

### Phase 5: Testing & Deployment (สัปดาห์ที่ 8)
- [ ] Unit testing
- [ ] Integration testing
- [ ] User acceptance testing
- [ ] Deploy to production

---
หมายเหตุ: ไฟล์นี้ควรถูกอัพเดตเสมอเมื่อมีข้อมูลใหม่ๆ เกิดขึ้นในโปรเจกต์

## บันทึกการทำงานล่าสุด
### วันที่: [วันที่ปัจจุบัน]
- อัพเดทข้อมูลว่าใช้ Gmail เป็นหลัก
- สร้าง Mindmap แนวคิดการออกแบบระบบ Smart Task Management System
- จัดโครงสร้าง Mindmap เป็น 5 ส่วนหลัก: Gmail Integration, Data Processing, Dashboard, Notification, และ User Experience
- ได้รับและวิเคราะห์ Mindmap จากผู้ใช้ (3 รูป) พบว่ามีความสมบูรณ์และตรงกับแนวคิดที่วางไว้
- อัพเดท Skill.md ให้สอดคล้องกับ Mindmap ที่ได้รับ
- กำหนด Technology Stack ที่จะใช้
- วางแผนการพัฒนาเป็น 5 Phases พร้อมระยะเวลา

### วันที่: [วันที่ปัจจุบัน] - กำหนดหลักการทำงาน
- กำหนดให้ใช้หลักการ PDCA (Plan-Do-Check-Act) ในการทำงาน
- ตกลงว่าจะไม่ลงมือทำทันที ต้องนำเสนอแผนและรอการอนุมัติก่อนเสมอ
- AI จะวิเคราะห์ผลกระทบก่อนการดำเนินการทุกครั้ง
- บันทึกหลักการทำงานนี้ไว้เพื่อการทำงานร่วมกันที่มีประสิทธิภาพ

### วันที่: [18 ตุลาคม 2025] - ติดตั้ง Docker ใน WSL2
- เลือกติดตั้ง Docker CE ใน WSL2 แทน Docker Desktop เพื่อประหยัด resource
- ติดตั้ง Docker CE version 28.5.1 สำเร็จ
- สร้าง scripts ทดสอบ Docker สำหรับทั้ง Windows และ WSL2
- เพิ่ม user karnc เข้า docker group
- ทดสอบ docker run hello-world สำเร็จ
- แก้ไขปัญหา line endings ของ script ด้วย dos2unix
- ทดสอบ script test_docker_wsl.sh ผ่านทุกข้อ
- Docker CE 28.5.1 และ Docker Compose 2.40.1 พร้อมใช้งาน
- **สถานะปัจจุบัน: Environment พร้อม 100% สำหรับการพัฒนาโปรเจกต์**

