# Check-Headers 🛡️

สคริปต์อัตโนมัติสำหรับนักทดสอบระบบ (Pentester) เพื่อใช้ตรวจสอบ **HTTP Security Headers** ของเว็บเป้าหมายแยกตามพาร์ทต่าง ๆ (Endpoints) ได้อย่างรวดเร็ว รองรับทั้งหน้าเว็บทั่วไปและ API Routes ที่ต้องผ่านการยืนยันตัวตน (Authenticated Routes) ด้วย JWT Token หรือ Cookie

---

## ✨ คุณสมบัติ (Features)
- 🚀 **Fast & Simple**: เรียกใช้งานง่ายจากทุกที่ในระบบปฏิบัติการ (System-wide Command) หลังการติดตั้ง
- 🔑 **Authentication Support**: รองรับการส่ง `Authorization` หรือ `Cookie` ไปพร้อมกับคำขอ เพื่อตรวจเช็คหน้าหลังบ้านได้อย่างแม่นยำ
- ⚡ **HTTP/2 Ready**: ปรับปรุงระบบตัวกรองคำตอบ (Response Matcher) ให้รองรับโครงสร้างโปรโตคอล HTTP/2 สมบูรณ์แบบ
- 📊 **Auto-Reporting**: บันทึกผลการตรวจสอบลงไฟล์ข้อความ (`.txt`) แยกตามชื่อโดเมนให้โดยอัตโนมัติในโฟลเดอร์ปัจจุบันที่ทำงานอยู่
- 🔍 **6 Core Headers Audit**: ตรวจสอบช่องโหว่จากการขาดหายไปของ Security Headers หลัก:
  - Content-Security-Policy (CSP)
  - X-Content-Type-Options
  - Strict-Transport-Security (HSTS)
  - X-Frame-Options
  - Referrer-Policy
  - Permissions-Policy

---

## 📂 โครงสร้างโปรเจกต์ (Repository Structure)
```text
check-headers/
├── check-headers.sh  # สคริปต์หลักในการทำงาน
├── install.sh        # สคริปต์ช่วยติดตั้งระบบเข้าสู่ส่วนกลางอัตโนมัติ
└── README.md         # เอกสารคู่มือการใช้งาน


วิธีการติดตั้งบนเครื่องใหม่ (Installation)
เปิด Terminal บนเครื่องที่คุณต้องการใช้งาน (เช่น Kali Linux) แล้วรันคำสั่งตามลำดับดังนี้:
# 1. Clone โปรเจกต์นี้ลงมาจาก GitHub
git clone [https://github.com/YOUR_USERNAME/check-headers.git](https://github.com/YOUR_USERNAME/check-headers.git)

# 2. ย้ายเข้าไปในโฟลเดอร์โปรเจกต์
cd check-headers

# 3. เปิดสิทธิ์ให้สคริปต์ติดตั้งใช้งานได้
chmod +x install.sh

# 4. เริ่มการติดตั้งเข้าสู่ระบบส่วนกลาง
./install.sh


ตัวอย่างที่ 1: ตรวจสอบหน้าเว็บทั่วไป
check-headers <ชื่อโดเมน> <พาธที่ 1> <พาธที่ 2> <พาธที่ 3> ...
check-headers securitylifecycle.one.th / /news.html /login.html

ตัวอย่างที่ 2: ตรวจสอบหน้าหลังบ้าน / API (ที่ต้องล็อกอินก่อน)
- JWT Token
export AUTH_HEADER="Authorization: Bearer eyJhbGciOiJIUzI1NiIsIn..."
check-headers ucchat.oneemail.info /api-fe/v1/notification/chat /backend/api/v1/auth/renew-token

- Cookie Session
export AUTH_HEADER="Cookie: sessionid=abcdef123456789"
check-headers target-app.com /dashboard.html /api/v1/internal