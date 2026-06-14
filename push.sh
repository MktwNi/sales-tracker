#!/usr/bin/env bash
# ============================================================
#  push.sh — ช่วย push โปรเจกต์ sales-tracker-2569 ขึ้น GitHub
#  วิธีใช้:
#    1) แก้ค่า GITHUB_USER ด้านล่างให้เป็น username ของคุณ
#    2) สร้าง repo เปล่าชื่อ sales-tracker-2569 บน GitHub
#       (อย่าเพิ่งติ๊ก "Add a README file")
#    3) รัน:  bash push.sh
# ============================================================
set -e

GITHUB_USER="YOUR_USERNAME"        # <-- แก้ตรงนี้
REPO="sales-tracker-2569"
BRANCH="main"

if [ "$GITHUB_USER" = "YOUR_USERNAME" ]; then
  echo "❌ กรุณาแก้ GITHUB_USER ในไฟล์ push.sh ให้เป็น username ของคุณก่อน"
  exit 1
fi

# init (ถ้ายังไม่เคย)
[ -d .git ] || git init

git add .
git commit -m "Update: sales status tracker 2569" || echo "ℹ️ ไม่มีการเปลี่ยนแปลงให้ commit"
git branch -M "$BRANCH"

# ตั้ง remote (ถ้ายังไม่มี)
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "https://github.com/$GITHUB_USER/$REPO.git"
fi

git push -u origin "$BRANCH"
echo "✅ เสร็จแล้ว: https://github.com/$GITHUB_USER/$REPO"
