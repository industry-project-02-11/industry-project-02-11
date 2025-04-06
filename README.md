# 조선대학교 산학프로젝트1 02분반 11조
# ☁️ 클라우드 비용 최적화 솔루션 개발

## 👥 담당 역할

| 이름     | 역할 |
|----------|------|
| **김기욱** | 팀장, 전체 기획 및 일정 관리, 백엔드(Spring Boot) 개발, 프론트 구조 설계, 발표 |
| **김준서** | 분석 서버(FastAPI) 개발, DB 연동, 절감 로직 구현 |
| **정욱**   | 회의록 정리, 계획서/PPT 작성 보조, 문서 관리 |
| **나승빈** | 프론트엔드 보조 (React 컴포넌트 UI 설계), 발표자료 시각 보조 |
| **이승현** | 비용 절감/경쟁 사례 리서치, 테스트 피드백, 발표 리허설 참여 |

---

## 📌 아이디어 개요

클라우드를 사용하는 프리랜서 개발자, 소규모 스타트업, 산학 협력 기업들이  
**복잡한 비용 구조**와 **비효율적인 리소스 운영**으로 어려움을 겪고 있습니다.

본 프로젝트는 다음 기능을 갖춘 **클라우드 비용 분석 및 자동 최적화 도구**를 개발합니다:

- AWS 비용 데이터 자동 수집
- 유휴 리소스 탐지 (사용률 < 20%)
- 절감 시뮬레이션 및 추천
- 대시보드 시각화
- 예산 초과 시 Slack/Email 알림

---

## 🛠️ 기술 스택

| 분야 | 기술 | 설명 |
|------|------|------|
| ![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=openjdk&logoColor=white) <br> ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white) | **Backend** | API Gateway, 비용 수집 스케줄링 |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) <br> ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white) | **분석 로직** | 유휴 리소스 탐지, 절감 시뮬레이션 |
| ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white) <br> ![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white) | **DB** | 비용 데이터 저장, 캐싱 |
| ![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB) <br> ![Chart.js](https://img.shields.io/badge/Chart.js-FF6384?style=for-the-badge&logo=chartdotjs&logoColor=white) | **Frontend** | 대시보드 UI 및 시각화 |
| ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) <br> ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white) | **DevOps** | 컨테이너화 및 CI/CD 자동화 |
| ![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white) <br> ![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white) | **클라우드 연동** | 비용 API, Lambda 알림, Email/Slack 전송 |

---

## 🔁 시스템 아키텍처

![아키텍처 이미지](./5최종발표자료/Archi.png)

> AWS 비용 수집 → Spring Boot 서버 → FastAPI 분석 → PostgreSQL 저장 → React 대시보드 → Slack/Email 알림
