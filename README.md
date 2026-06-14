# Sales Tracker 2569 — ตารางติดตามสถานะการขาย

ระบบติดตามสถานะการขาย + แดชบอร์ด แบบหน้าเดียว (single-file HTML) เปิดไฟล์ `index.html` ใช้งานได้ทันที
ไม่ต้องติดตั้งอะไร ไม่ต้องมีเซิร์ฟเวอร์ ทำงานออฟไลน์ได้ บันทึกอัตโนมัติในเบราว์เซอร์ และเชื่อม Google Sheet เป็นฐานข้อมูลออนไลน์ได้

> Single-page sales pipeline tracker + dashboard. No build, no dependencies, no server. Just open `index.html`. Optional Google Sheet sync via SheetDB.

---

## คุณสมบัติ (Features)

**หน้ากรอกข้อมูล (Editor)**
- กรอก/แก้ไขข้อมูลลูกค้าในตารางได้โดยตรง จัดกลุ่มตามช่องทาง (SOURCE)
- ติ๊ก SOURCE / Services ด้วยการคลิก ✓ — เพิ่มลูกค้าในหมวดใดติ๊ก SOURCE ให้อัตโนมัติ
- เพิ่ม/ลบลูกค้า, เพิ่ม/ลบหมวด (กันชื่อหมวดซ้ำ), ลากเรียงลำดับได้
- **วันที่ติดต่อ** ต่อลูกค้า + ป้ายเตือน **"⏰ ค้างติดตาม"** เมื่อไม่ได้ติดต่อเกิน 14 วัน
- แต่ละขั้น Progress (CALL1…PAY2) มีช่อง **วันที่ + โน้ต** แยกกัน
- สถานะงาน **เปิด/ปิด** ต่อลูกค้า — ปิดแล้วย้ายไปแท็บ “ปิดงาน”
- ยุบ/ขยายหมวด, นับจำนวนต่อหมวด, ตรึงหัวตาราง/คอลัมน์ชื่อบริษัท
- ตัวกรอง: ค้นหา, SOURCE, Services, ผู้รับผิดชอบ, แหล่งที่มา, สถานะการปิดการขาย และ **วัน/เดือนที่ติดต่อ**
- **มุมมองการ์ดสำหรับมือถือ** — จอเล็กแสดงเป็นการ์ดต่อลูกค้า แก้ไขได้

**แดชบอร์ด (Dashboard)**
- KPI: ลูกค้าทั้งหมด, Win rate, ปิดการขาย, Forecast/Actual รวม, % Actual vs Forecast, งานเปิด/ปิด และ **ค้างติดตาม**
- กราฟ: สถานะการปิดการขาย, Pipeline, จำนวนตามช่องทาง/บริการ, Forecast ตามช่องทาง, Win rate
- ตารางสรุปตามผู้รับผิดชอบ และแหล่งที่มา
- ตัวกรอง: ผู้รับผิดชอบ, แหล่งที่มา, เดือน

**ข้อมูล / การเชื่อมต่อ (โหมดแชร์ — ทุกคนเห็นข้อมูลเดียวกัน)**
- ฝัง URL ของ Google Sheet ไว้ในแอป (ค่าคงที่ `DEFAULT_SHEETDB_URL` ในโค้ด) → ทุกคนที่เปิดแอปต่อ **Sheet เดียวกันอัตโนมัติ** ไม่ต้องตั้งค่า
- **เปิดแอป → ดึงข้อมูลล่าสุดทันที** / **แก้ไข → ส่งขึ้น Sheet อัตโนมัติ** / **รีเฟรชจาก Sheet ทุก ~60 วินาที** (ข้ามรอบเมื่อกำลังพิมพ์หรือมีงานค้างส่ง กันข้อมูลตีกัน)
- ยังสำรองในเครื่องด้วย `localStorage` แยกตามปี (พ.ศ.) — ใช้งานต่อได้แม้เน็ตหลุด
- ข้อมูลแต่ละปีแยกแถวด้วยคอลัมน์ `year` ไม่ทับกัน
- บันทึกแบบ “เขียนใหม่ก่อนค่อยลบของเก่า” (ใช้ `syncId`) กันข้อมูลหายตอนเน็ตหลุด
- คอลัมน์สถานะอ่านง่ายใน Sheet: `statusJob`, `statusDeal`, `statusOverall`
- ⚠️ ระบบเป็นแบบ last-writer-wins (ทั้งชุดต่อปี) เหมาะกับทีมเล็ก; ถ้าใช้หนัก/หลายคนพร้อมกันบ่อย แนะนำอัปเกรดแพ็ก SheetDB หรือเปลี่ยนไป Google Apps Script. ถ้าเปลี่ยน Sheet ให้แก้ค่า `DEFAULT_SHEETDB_URL` ในไฟล์ `index.html`
- ⚠️ ถ้าเอาขึ้น GitHub แบบ public คนที่เจอ URL จะเข้าถึง Sheet ได้ — แนะนำให้ repo เป็น private
- Export: Excel (.xls), CSV, สำรอง (JSON) — ชื่อไฟล์ติดปีอัตโนมัติ
- Import: กู้คืนจากไฟล์ JSON (ตรวจรูปแบบไฟล์ก่อนนำเข้า)

---

## วิธีใช้ (Usage)

1. ดาวน์โหลดหรือ clone โปรเจกต์นี้
2. ดับเบิลคลิกเปิด `index.html` ด้วยเบราว์เซอร์ (Chrome / Edge / Safari)
3. กรอกข้อมูลได้เลย ระบบบันทึกอัตโนมัติ
4. (ถ้าต้องการ) เชื่อม Google Sheet ตาม [คู่มือ](คู่มือเชื่อม-GoogleSheet.md)

> ข้อมูลเก็บใน `localStorage` ของเบราว์เซอร์เครื่องนั้น ถ้าจะกันข้อมูลหาย/ย้ายเครื่อง ให้กด “สำรอง (JSON)” หรือเชื่อม Google Sheet

---

## เทคโนโลยี (Tech)
- HTML + CSS + Vanilla JavaScript ไฟล์เดียว ไม่มี dependency
- ฟอนต์ Kanit จาก Google Fonts (ออฟไลน์ใช้ฟอนต์ระบบแทน)
- กราฟวาดด้วย SVG/CSS เอง
- เชื่อม Google Sheet ผ่าน SheetDB REST API

---

## โครงสร้างไฟล์ (Structure)

```
sales-tracker-2569/
├── index.html                  # แอปทั้งหมดอยู่ในไฟล์นี้
├── คู่มือเชื่อม-GoogleSheet.md   # วิธีเชื่อม Google Sheet (SheetDB)
├── logo.png
├── README.md
├── LICENSE
├── .gitignore
└── push.sh                     # สคริปต์ช่วย push ขึ้น GitHub
```

---

## วิธี push ขึ้น GitHub

```bash
# 1) สร้าง repo เปล่าชื่อ sales-tracker-2569 บน GitHub ก่อน (อย่าเพิ่งติ๊ก Add README)

# 2) ในโฟลเดอร์โปรเจกต์
git init
git add .
git commit -m "Initial commit: Sales status tracker 2569"
git branch -M main
git remote add origin https://github.com/<YOUR_USERNAME>/sales-tracker-2569.git
git push -u origin main
```

หรือถ้ามี GitHub CLI:

```bash
git init && git add . && git commit -m "Initial commit"
gh repo create sales-tracker-2569 --public --source=. --push
```

ดูสคริปต์ช่วยใน [push.sh](push.sh)

---

## เปิดใช้งานเป็นเว็บไซต์ฟรีด้วย GitHub Pages

1. Push โค้ดขึ้น GitHub แล้ว
2. ไปที่ repo → **Settings → Pages**
3. Source เลือก **Deploy from a branch** → Branch: **main** → Folder: **/ (root)** → Save
4. รอสักครู่ จะได้ลิงก์ `https://<username>.github.io/sales-tracker-2569/` เปิดแอปผ่านเว็บได้เลย

---

## License
MIT — ดู [LICENSE](LICENSE)
