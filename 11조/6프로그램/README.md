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

## 🔧 Git 사용 규칙

- **커밋 메시지 템플릿** (한글 or 영어 둘 다 OK)
- feat: 비용 분석 기능 구현
- fix: 리소스 탐지 버그 수정
- docs: 3주차 회의록 추가
- refactor: FastAPI 모듈 구조 정리


- **PR 제목 예시**
- [feature/cost-fetch] 비용 수집 모듈 초기 구현

---

## 🗂️ 디렉토리 구조

```
/6프로그램
├── apps/                            # 🌐 모든 서비스 애플리케이션 모음 (서비스 중심)
│   ├── backend/                     # 🔧 Spring Boot (API Gateway + 사용자 인증 + 비용 수집)
│   │   ├── src/                     #   └ 주요 컨트롤러, 서비스, 도메인 등
│   │   └── README.md                #   └ 백엔드 구조 및 실행법 설명
│   ├── analysis/                    # 🧠 FastAPI (유휴 리소스 탐지 + 절감 시뮬레이션)
│   │   ├── app/                     #   └ 유휴 분석 및 추천 알고리즘 모듈
│   │   └── README.md
│   ├── frontend/                    # 🎨 React (대시보드 UI, 사용자 인터페이스)
│   │   └── src/                     #   └ 사용자 뷰, 컴포넌트, API 통신
│   └── README.md                    #   └ 전체 앱 설명서 및 실행 방법

├── infra/                           # 🛠 인프라 설정 및 운영 관리
│   ├── docker/                      #   └ Dockerfile 및 docker-compose 구성
│   │   ├── docker-compose.dev.yml  #     └ 로컬 개발 환경
│   │   ├── docker-compose.prod.yml #     └ 실제 운영 환경
│   │   └── nginx/                   #     └ reverse proxy / 정적 리소스 제공
│   ├── k8s/                         # ☸ 쿠버네티스 관련 리소스 정의
│   │   ├── backend.yaml             #     └ backend용 deployment, service 등
│   │   ├── analysis.yaml
│   │   ├── frontend.yaml
│   │   └── postgres.yaml
│   ├── terraform/                   # ⚙ AWS 리소스 자동 생성 스크립트 (IaC)
│   │   ├── iam/                     #     └ 사용자 권한 설정
│   │   ├── lambda/                  #     └ 비용 임계 알림용 Lambda 트리거
│   │   ├── cloudwatch/             #     └ 모니터링 지표 설정
│   │   └── variables.tf            #     └ 공통 변수 파일
│   └── ansible/                     # 🔁 초기 설정 자동화 플레이북 (선택 사항)

├── monitoring/                      # 📈 시스템 모니터링 구성
│   ├── prometheus/                  #     └ metrics 수집 설정
│   │   └── prometheus.yml
│   └── grafana/                     #     └ 대시보드 json 및 alert rule 등

├── .github/                         # 🚀 CI/CD 자동화 설정 (GitHub Actions)
│   └── workflows/
│       ├── backend.yml              #     └ backend 빌드/테스트/배포 플로우
│       ├── frontend.yml
│       └── deploy.yml              #     └ 전체 시스템 배포 정의

├── scripts/                         # 🧬 seed 및 초기 설정 스크립트
│   ├── init-db.sql                  #     └ PostgreSQL 초기 스키마 삽입
│   └── load-mock-data.py           #     └ 테스트용 mock 데이터 삽입

├── docs/                            # 📚 프로젝트 문서 (계획서, 설계, 명세서 등)
│   ├── ERD.png                      #     └ 최종 ERD 이미지
│   ├── ERD-DDL.sql                  #     └ DDL 스크립트
│   ├── API-SPEC.md                  #     └ API 명세서
│   ├── ARCHITECTURE.png            #     └ 시스템 아키텍처 다이어그램
│   └── README.md

├── tests/                           # ✅ 통합 테스트, API 테스트 등 자동화 스크립트
│   ├── backend/
│   ├── analysis/
│   └── frontend/

├── .env                             # 🔐 로컬 환경 변수 파일 (.gitignore 필수)
├── docker-compose.yml              # 🧩 전체 서비스 통합 구성 파일 (간편 실행용)
├── Makefile                         # 🛠 `make up`, `make deploy` 등 CLI 단축 명령
├── README.md                        # 🏁 루트 레벨 프로젝트 개요 및 실행 가이드
└── LICENSE                          # 📜 오픈소스 라이선스 정보
```

---

📁 업데이트 날짜: 2025-04-16
작성자: 김기욱 (11조 팀장)
