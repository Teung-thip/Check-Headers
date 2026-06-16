#!/bin/bash

# ตรวจสอบจำนวนอาร์กิวเมนต์
if [ "$#" -lt 2 ]; then
    echo "❌ วิธีใช้งานผิดพลาด!"
    echo "รูปแบบคำสั่ง: check-headers <ชื่อโดเมน> <พาธที่ 1> <พาธที่ 2> ..."
    exit 1
fi

INPUT_DOMAIN=$1
TARGET_DOMAIN=$(echo "$INPUT_DOMAIN" | sed -e 's|^https://||' -e 's|^http://||' -e 's|/$||')
shift 

OUTPUT_FILE="security_headers_${TARGET_DOMAIN}_report.txt"

echo "=== Security Headers Audit Report ===" > "$OUTPUT_FILE"
echo "Target: $TARGET_DOMAIN" >> "$OUTPUT_FILE"
echo "Date: $(date)" >> "$OUTPUT_FILE"

for path in "$@"; do
    if [[ ! "$path" =~ ^/ ]]; then
        path="/$path"
    fi

    url="https://${TARGET_DOMAIN}${path}"
    echo -e "\n--------------------------------------------------" >> "$OUTPUT_FILE"
    echo "URL: $url" >> "$OUTPUT_FILE"
    echo "--------------------------------------------------" >> "$OUTPUT_FILE"

    # ดึงผลลัพธ์แบบเงียบ (Silent) ดึงเฉพาะหัวข้อแบบดุดันและปลอดภัย
    if [ -n "$AUTH_HEADER" ]; then
        headers=$(curl -ksSL -X GET --head -H "$AUTH_HEADER" "$url" 2>/dev/null | tr -d '\r')
    else
        headers=$(curl -ksSL -X GET --head "$url" 2>/dev/null | tr -d '\r')
    fi

    # วิธีสกัด HTTP Status Code แบบรองรับทั้ง HTTP/1.1 และ HTTP/2 ไม่ให้หลุดพาร์ทว่าง
    status_code=$(echo "$headers" | grep -Ei "^HTTP/" | grep -Eo "HTTP/[^ ]+ [0-9]+" | tail -n 1)
    
    if [ -z "$status_code" ]; then
        status_code="❌ Connection Failed / No Response"
    fi
    echo "Status: $status_code" >> "$OUTPUT_FILE"

    # ลูปตรวจสอบ Security Headers 6 ตัวหลัก
    for header in "Content-Security-Policy" "X-Content-Type-Options" "Strict-Transport-Security" "X-Frame-Options" "Referrer-Policy" "Permissions-Policy"; do
        if ! echo "$headers" | grep -Eiq "^${header}:"; then
            echo "[-] Missing $header" >> "$OUTPUT_FILE"
        fi
    done
done

# พ่นผลสรุปที่สะอาดสวยงามออกหน้าจอทันที
cat "$OUTPUT_FILE"