#!/bin/bash

echo "⚙️ กำลังติดตั้ง check-headers เข้าสู่ระบบส่วนกลาง..."

# 1. คัดลอกไฟล์หลักไปที่พื้นที่ส่วนกลางและตัดนามสกุลออก
sudo cp check-headers.sh /usr/local/bin/check-headers

# 2. ตั้งสิทธิ์ให้ทุก User สามารถเรียกใช้ได้
sudo chmod 755 /usr/local/bin/check-headers

echo "✅ ติดตั้งสำเร็จเรียบร้อย! ต่อจากนี้คุณสามารถใช้คำสั่ง 'check-headers' ได้ทันที"