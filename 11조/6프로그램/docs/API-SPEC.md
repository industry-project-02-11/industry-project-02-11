# 📘 API 명세서 (Cloud Cost Optimization - MVP)

## 🔐 1. 사용자 인증

### 🔹 POST /auth/register
사용자 계정 등록 (IAM Access Key 기반)

| 항목     | 설명                          |
|----------|-------------------------------|
| Method   | `POST`                        |
| URL      | `/auth/register`              |
| Payload  | `access_key`, `secret_key`    |
| Response | 201 Created / 400 Bad Request |

---

## 💰 2. 비용 수집

### 🔹 POST /cost/collect
AWS Cost Explorer에서 비용 데이터 수집 (스케줄러 외 수동 트리거용)

| 항목     | 설명                      |
|----------|---------------------------|
| Method   | `POST`                    |
| URL      | `/cost/collect`          |
| Header   | `Authorization: Bearer <token>` |
| Response | 200 OK, 수집 완료 메시지 |

### 🔹 GET /cost/history
수집된 비용 데이터 목록 조회

| 항목     | 설명          |
|----------|---------------|
| Method   | `GET`         |
| URL      | `/cost/history?month=2025-04` |
| Response | 비용 데이터 JSON 배열 반환 |

---

## 📊 3. 분석/시뮬레이션

### 🔹 POST /analyze
유휴 리소스 탐지 및 절감 시뮬레이션 수행 요청

| 항목     | 설명                      |
|----------|---------------------------|
| Method   | `POST`                    |
| URL      | `/analyze`               |
| Response | 분석 시작됨 (즉시 or 비동기 큐) |

### 🔹 GET /analyze/result
최근 분석 결과 조회

| 항목     | 설명            |
|----------|-----------------|
| Method   | `GET`           |
| URL      | `/analyze/result` |
| Response | 리소스별 분석 결과 + 절감 시뮬레이션 |

---

## 📢 4. 알림 관련

### 🔹 POST /alert/config
예산 한도 설정

| 항목     | 설명                      |
|----------|---------------------------|
| Method   | `POST`                    |
| URL      | `/alert/config`          |
| Payload  | `monthly_budget`, `email`, `slack_webhook_url` |
| Response | 설정 완료 메시지 |

---

## 📈 5. 대시보드 조회

### 🔹 GET /dashboard/summary
프론트 대시보드용 전체 요약 데이터

| 항목     | 설명                    |
|----------|-------------------------|
| Method   | `GET`                   |
| URL      | `/dashboard/summary`   |
| Response | 비용/유휴/시뮬레이션 데이터 조합 |

---

## 🗂️ 6. 기타 정보

- ✅ 모든 API는 `Authorization` 헤더를 요구합니다. (`Bearer` 토큰 방식)
- ✅ 응답은 모두 `application/json` 형식입니다.
- ✅ 인증 실패 시 `401 Unauthorized` 반환됩니다.

---

📌 **작성자:** 김기욱, 김준서  
📆 **최종 수정일:** 2025.04.16