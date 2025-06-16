#!/bin/bash

# 모든 AWS 리전의 리소스 확인 스크립트

echo "=== 모든 AWS 리전의 리소스 확인 ==="

# 모든 리전 목록 가져오기
REGIONS=$(aws ec2 describe-regions --query 'Regions[*].RegionName' --output text)

for region in $REGIONS; do
    echo -e "\n=========================================="
    echo "리전: $region"
    echo "=========================================="
    
    # EC2 인스턴스 확인
    echo -e "\n--- EC2 인스턴스 ---"
    INSTANCES=$(aws ec2 describe-instances --region $region --query 'Reservations[*].Instances[?State.Name!=`terminated`].[InstanceId,State.Name,InstanceType]' --output text)
    if [ ! -z "$INSTANCES" ]; then
        echo "$INSTANCES"
    else
        echo "실행 중인 인스턴스 없음"
    fi
    
    # RDS 인스턴스 확인
    echo -e "\n--- RDS 인스턴스 ---"
    RDS=$(aws rds describe-db-instances --region $region --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus]' --output text 2>/dev/null)
    if [ ! -z "$RDS" ]; then
        echo "$RDS"
    else
        echo "RDS 인스턴스 없음"
    fi
    
    # Load Balancer 확인
    echo -e "\n--- Load Balancer ---"
    ALB=$(aws elbv2 describe-load-balancers --region $region --query 'LoadBalancers[*].LoadBalancerName' --output text 2>/dev/null)
    if [ ! -z "$ALB" ]; then
        echo "$ALB"
    else
        echo "Load Balancer 없음"
    fi
    
    # NAT Gateway 확인
    echo -e "\n--- NAT Gateway ---"
    NAT=$(aws ec2 describe-nat-gateways --region $region --filter "Name=state,Values=available" --query 'NatGateways[*].NatGatewayId' --output text)
    if [ ! -z "$NAT" ]; then
        echo "$NAT"
    else
        echo "NAT Gateway 없음"
    fi
    
    # Elastic IP 확인
    echo -e "\n--- Elastic IP ---"
    EIP=$(aws ec2 describe-addresses --region $region --query 'Addresses[*].PublicIp' --output text)
    if [ ! -z "$EIP" ]; then
        echo "$EIP"
    else
        echo "Elastic IP 없음"
    fi
done

echo -e "\n=== 전체 리전 확인 완료 ==="