# 📋 기능 요구사항 명세서 (MVP)

본 문서는 11조 클라우드 비용 최적화 솔루션의 **1차 완성 목표(MVP)** 기준 기능을 명확히 구체화한 문서입니다.

---

## 1️⃣ AWS 비용 데이터 수집

| 항목 | 내용 |
|------|------|
| 💡 목적 | AWS 서비스별 월간 비용 데이터를 수집하여 내부 DB에 저장 |
| 🔧 사용 기술 | Spring Boot, AWS Cost Explorer API, `@Scheduled`, RestTemplate |
| 🧪 테스트 데이터 | API 연결 전까지는 Mock JSON으로 테스트 예정 |
| 📦 필드 구성 | 서비스명, 계정 ID, 월, 비용(USD), 시간 범위, 태그 등 |
| 🔁 실행 주기 | 하루 1회 또는 수동 트리거 (개발단계에서는 버튼으로 실행) |

📌 참고 링크: [AWS Cost Explorer API Docs](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/Welcome.html)

---

## 2️⃣ 유휴 리소스 탐지

| 항목 | 내용 |
|------|------|
| 💡 목적 | 비용은 발생하지만 실제로 거의 사용되지 않는 리소스를 감지 |
| 대상 리소스 | EC2, RDS, EBS (우선은 EC2만 먼저 구현 후 확장) |
| 기준 | CPU 사용률 20% 이하 (변경 가능하도록 설정화 예정) |
| 수집 방식 | CloudWatch Metrics 또는 수동 입력 데이터 기반 |
| 구현 방식 | FastAPI에서 탐지 로직 수행, 결과를 Spring Boot에 전달 |
| 출력 예시 | `is_idle: true`, `usage_rate: 13.5%`, `idle_days: 7` |

---

## 3️⃣ 절감 시뮬레이션

| 항목 | 내용 |
|------|------|
| 💡 목적 | 유휴 리소스를 줄이기 위한 구체적 액션 추천 |
| 기능 | 다운사이징, 인스턴스 정지, 예약 인스턴스 전환 제안 |
| 분석 기준 | 현재 사용량, 시간대, 비용 추이 기반 |
| FastAPI 반환 예시 |
```json
{
  "resource_id": "i-0abcd1234",
  "recommendation": "Stop or downsize to t3.small",
  "current_cost": 22.5,
  "expected_cost": 6.3,
  "saving": 16.2
}
```

---

## 4️⃣ 예산 초과 알림 시스템

| 항목 | 내용 |
|------|------|
| 💡 목적 | 예상 비용이 예산 초과 시 사용자에게 즉시 알림 |
| 알림 조건 | - 이번 달 누적 비용 ≥ 설정한 예산<br>- 유휴 리소스가 N일 이상 지속됨 |
| 사용 채널 | Slack, Discord, Email (SES) |
| 트리거 방식 | CloudWatch → Lambda → Webhook 호출 |
| 예시 메시지 |
```
[예산 경고] 이번 달 비용이 220,000원을 초과할 것으로 예상됩니다. EC2 2개 유휴 상태.
```

---

## 5️⃣ 대시보드

| 항목 | 내용 |
|------|------|
| 💡 목적 | 시각적으로 비용 트렌드, 유휴 리소스, 절감 추천을 한 눈에 |
| 프론트 구성 | React (CRA) + Chart.js |
| 핵심 시각화 요소 | - 서비스별 비용 추이 선 그래프<br>- 유휴 리소스 리스트 (Table)<br>- 절감 시뮬레이션 결과 (Bar chart or Gauge) |
| 확장 고려 | Grafana + PostgreSQL (2차 버전에서 적용 가능) |

---

## 💡 추가 적용 고려 기능

### Kafka (선택)
- Spring → Kafka → FastAPI 로 비동기 분석 구조
- 현실적으론 우선 REST 방식으로 구현 후, Kafka는 실험적으로 붙이자

### Kubernetes (선택)
- Local 환경: Docker Compose 먼저
- 후에 Minikube 또는 Docker Desktop K8s 모드로 연습 가능
- 발표용 포트폴리오로는 “K8s로 컨테이너화 완료” 문구에 충분

---

## 🧱 기술 적용 우선순위 제안

| 우선순위 | 기술 | 적용 시기 |
|----------|------|------------|
| 1순위 | Spring Boot + FastAPI + PostgreSQL | 4월 중 MVP 구현 |
| 2순위 | 알림 시스템 (Slack/Lambda) | 5월 초 |
| 3순위 | Kafka, Grafana, K8s | 5월 중순 이후 실험 적용 |

---

## ✅ 향후 확장 고려사항

| 항목 | 확장 아이디어 |
|------|----------------|
| 로그인 기능 | 프리랜서 사용자 구분, 프로젝트 단위 분석 |
| 기타 클라우드 | GCP, Azure 비용 수집 기능 추가 |
| SaaS화 | 비용 관리 솔루션으로 상용화 준비 |
| ML 적용 | Auto-scaling 추천, 장기 예측 기능 등 |

---

📌 최신 수정일: 2025-04-07  
작성자: 김기욱 (팀장), 김준서 (분석 로직 담당)