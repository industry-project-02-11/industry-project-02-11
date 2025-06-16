#!/bin/bash

# AWS 리소스 정리 스크립트
# 실행 전 AWS CLI가 설치되어 있고 설정(aws configure)이 완료되어 있어야 합니다.

echo "=== AWS 비용 발생 리소스 확인 및 종료 스크립트 ==="
echo "주의: 이 스크립트는 모든 리소스를 종료합니다. 계속하시겠습니까? (y/N)"
read -r response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "스크립트를 종료합니다."
    exit 1
fi

# 현재 리전 설정
REGION=$(aws configure get region)
if [ -z "$REGION" ]; then
    REGION="ap-northeast-2"  # 서울 리전을 기본값으로 설정
fi
echo "현재 리전: $REGION"

# 1. EC2 인스턴스 종료
echo -e "\n=== EC2 인스턴스 확인 ==="
INSTANCES=$(aws ec2 describe-instances --region $REGION --query 'Reservations[*].Instances[?State.Name!=`terminated`].[InstanceId,State.Name,InstanceType,Tags[?Key==`Name`].Value|[0]]' --output table)
echo "$INSTANCES"

# 실행 중인 인스턴스 종료
RUNNING_INSTANCES=$(aws ec2 describe-instances --region $REGION --query 'Reservations[*].Instances[?State.Name==`running`].InstanceId' --output text)
if [ ! -z "$RUNNING_INSTANCES" ]; then
    echo "EC2 인스턴스 종료 중..."
    aws ec2 terminate-instances --region $REGION --instance-ids $RUNNING_INSTANCES
fi

# 2. RDS 인스턴스 확인 및 삭제
echo -e "\n=== RDS 인스턴스 확인 ==="
RDS_INSTANCES=$(aws rds describe-db-instances --region $REGION --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,DBInstanceClass]' --output table)
echo "$RDS_INSTANCES"

# RDS 인스턴스 삭제 (스냅샷 없이)
RDS_IDS=$(aws rds describe-db-instances --region $REGION --query 'DBInstances[*].DBInstanceIdentifier' --output text)
for db in $RDS_IDS; do
    echo "RDS 인스턴스 삭제 중: $db"
    aws rds delete-db-instance --region $REGION --db-instance-identifier $db --skip-final-snapshot --delete-automated-backups
done

# 3. ELB (Load Balancer) 확인 및 삭제
echo -e "\n=== Load Balancer 확인 ==="
# Classic Load Balancer
CLB=$(aws elb describe-load-balancers --region $REGION --query 'LoadBalancerDescriptions[*].LoadBalancerName' --output text)
for lb in $CLB; do
    echo "Classic Load Balancer 삭제 중: $lb"
    aws elb delete-load-balancer --region $REGION --load-balancer-name $lb
done

# Application/Network Load Balancer
ALB=$(aws elbv2 describe-load-balancers --region $REGION --query 'LoadBalancers[*].LoadBalancerArn' --output text)
for lb in $ALB; do
    echo "ALB/NLB 삭제 중: $lb"
    aws elbv2 delete-load-balancer --region $REGION --load-balancer-arn $lb
done

# 4. ElastiCache 클러스터 확인 및 삭제
echo -e "\n=== ElastiCache 클러스터 확인 ==="
CACHE_CLUSTERS=$(aws elasticache describe-cache-clusters --region $REGION --query 'CacheClusters[*].[CacheClusterId,CacheNodeType,Engine]' --output table)
echo "$CACHE_CLUSTERS"

CACHE_IDS=$(aws elasticache describe-cache-clusters --region $REGION --query 'CacheClusters[*].CacheClusterId' --output text)
for cache in $CACHE_IDS; do
    echo "ElastiCache 클러스터 삭제 중: $cache"
    aws elasticache delete-cache-cluster --region $REGION --cache-cluster-id $cache
done

# 5. NAT Gateway 확인 및 삭제
echo -e "\n=== NAT Gateway 확인 ==="
NAT_GATEWAYS=$(aws ec2 describe-nat-gateways --region $REGION --filter "Name=state,Values=available" --query 'NatGateways[*].NatGatewayId' --output text)
for nat in $NAT_GATEWAYS; do
    echo "NAT Gateway 삭제 중: $nat"
    aws ec2 delete-nat-gateway --region $REGION --nat-gateway-id $nat
done

# 6. Elastic IP 확인 및 해제
echo -e "\n=== Elastic IP 확인 ==="
EIPS=$(aws ec2 describe-addresses --region $REGION --query 'Addresses[*].[AllocationId,PublicIp,InstanceId]' --output table)
echo "$EIPS"

EIP_IDS=$(aws ec2 describe-addresses --region $REGION --query 'Addresses[*].AllocationId' --output text)
for eip in $EIP_IDS; do
    echo "Elastic IP 해제 중: $eip"
    aws ec2 release-address --region $REGION --allocation-id $eip
done

# 7. EBS 볼륨 확인 (사용하지 않는 볼륨)
echo -e "\n=== 사용하지 않는 EBS 볼륨 확인 ==="
UNUSED_VOLUMES=$(aws ec2 describe-volumes --region $REGION --filters "Name=status,Values=available" --query 'Volumes[*].[VolumeId,Size,VolumeType]' --output table)
echo "$UNUSED_VOLUMES"

VOLUME_IDS=$(aws ec2 describe-volumes --region $REGION --filters "Name=status,Values=available" --query 'Volumes[*].VolumeId' --output text)
for vol in $VOLUME_IDS; do
    echo "EBS 볼륨 삭제 중: $vol"
    aws ec2 delete-volume --region $REGION --volume-id $vol
done

# 8. S3 버킷 확인 (삭제는 수동으로 권장)
echo -e "\n=== S3 버킷 목록 ==="
aws s3 ls

echo -e "\n=== 정리 완료 ==="
echo "주의: S3 버킷, CloudFormation 스택, Lambda 함수 등은 수동으로 확인하고 삭제하세요."
echo "다른 리전의 리소스도 확인하시기 바랍니다."