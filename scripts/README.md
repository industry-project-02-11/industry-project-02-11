# AWS 리소스 관리 스크립트

이 디렉토리에는 AWS 비용 관리를 위한 스크립트들이 포함되어 있습니다.

## 사전 준비사항

1. AWS CLI 설치
```bash
# macOS
brew install awscli

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

2. AWS 자격 증명 설정
```bash
aws configure
# AWS Access Key ID, Secret Access Key, Region, Output format 입력
```

## 스크립트 설명

### 1. aws-cost-check.sh
현재 AWS 비용을 확인하는 스크립트입니다.
- 이번 달 총 비용
- 서비스별 비용 Top 10
- 최근 7일간 일별 비용
- 예상 월말 비용

```bash
chmod +x aws-cost-check.sh
./aws-cost-check.sh
```

### 2. aws-check-all-regions.sh
모든 AWS 리전의 실행 중인 리소스를 확인하는 스크립트입니다.
- EC2 인스턴스
- RDS 인스턴스
- Load Balancer
- NAT Gateway
- Elastic IP

```bash
chmod +x aws-check-all-regions.sh
./aws-check-all-regions.sh
```

### 3. aws-cleanup.sh
**⚠️ 주의: 이 스크립트는 모든 리소스를 삭제합니다!**

비용이 발생하는 주요 리소스들을 종료/삭제하는 스크립트입니다.
- EC2 인스턴스 종료
- RDS 인스턴스 삭제 (스냅샷 없이)
- Load Balancer 삭제
- ElastiCache 클러스터 삭제
- NAT Gateway 삭제
- Elastic IP 해제
- 사용하지 않는 EBS 볼륨 삭제

```bash
chmod +x aws-cleanup.sh
./aws-cleanup.sh
```

## 주의사항

1. **백업**: 중요한 데이터는 반드시 백업하세요.
2. **프로덕션 환경**: 프로덕션 환경에서는 신중하게 사용하세요.
3. **수동 확인 필요한 서비스**:
   - S3 버킷 (데이터 손실 위험)
   - CloudFormation 스택
   - Lambda 함수
   - CloudWatch Logs
   - Route53 호스팅 영역
   - VPC (기본 VPC 제외)

4. **비용이 계속 발생할 수 있는 항목**:
   - S3 스토리지
   - EBS 스냅샷
   - AMI
   - CloudWatch Logs
   - Route53 호스팅 영역
   - 데이터 전송 비용

## 추가 팁

### 비용 알림 설정
```bash
# AWS 콘솔에서 Billing > Budgets 메뉴로 이동
# 월별 예산 설정 및 알림 구성
```

### AWS Free Tier 확인
```bash
# AWS 콘솔에서 Billing > Free Tier 메뉴로 이동
# 무료 사용량 한도 확인
```

### 태그 기반 리소스 관리
프로젝트나 환경별로 태그를 지정하여 리소스를 관리하면 비용 추적이 쉬워집니다.

```bash
# 예: Environment=dev 태그가 있는 EC2 인스턴스만 조회
aws ec2 describe-instances --filters "Name=tag:Environment,Values=dev"
```