# 🌿 Git 브랜치 전략 & 프로젝트 구조

본 문서는 조선대학교 산학프로젝트1 02분반 11조의 클라우드 비용 최적화 도구 프로젝트의  
**Git 브랜치 전략**과 **디렉토리 구조**를 설명합니다.

---

## 📌 브랜치 전략

| 브랜치 이름     | 용도 설명 |
|----------------|-----------|
| `master`       | 최종 배포용 브랜치. 발표 시점에 병합 |
| `develop`      | 개발 통합 브랜치. 모든 기능은 여기에 병합 후 테스트 |
| `feature/*`    | 기능 단위 브랜치 (ex: `feature/cost-fetch`, `feature/dashboard-ui`) |
| `hotfix/*`     | 긴급 버그 수정 브랜치 |
| `docs/*`       | 문서 작업 전용 브랜치 (ex: `docs/erd-update`, `docs/week3-notes`) |

> 🔁 모든 브랜치는 PR을 통해 `develop`에 머지하고,  
> 최종 발표 직전 `develop` → `master`로 병합합니다.

---

## 🗂️ 디렉토리 구조

```
6프로그램/
├── backend        # Spring Boot (API Gateway), FastAPI (분석 모듈)
├── frontend       # React (CRA 기반), Chart.js 시각화
├── infra          # Docker, GitHub Actions, AWS 설정
├── docs           # 기술문서, 회의록 요약, ERD, 구조 설계 등
└── scripts        # 초기 셋업 스크립트, seed 데이터, etc
```

---

## 🔧 Git 사용 규칙

- **커밋 메시지 템플릿** (한글 or 영어 둘 다 OK)
- feat: 비용 분석 기능 구현
- fix: 리소스 탐지 버그 수정
- docs: 3주차 회의록 추가 
- refactor: FastAPI 모듈 구조 정리


- **PR 제목 예시**
- [feature/cost-fetch] 비용 수집 모듈 초기 구현

---

📁 업데이트 날짜: 2025-04-07  
작성자: 김기욱 (11조 팀장)
