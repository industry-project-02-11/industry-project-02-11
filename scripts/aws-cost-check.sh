#!/bin/bash

# AWS 비용 확인 스크립트

echo "=== AWS 비용 확인 ==="

# 현재 월의 날짜 범위 설정
START_DATE=$(date -u +"%Y-%m-01")
END_DATE=$(date -u +"%Y-%m-%d")

echo "기간: $START_DATE ~ $END_DATE"
echo ""

# 이번 달 총 비용 확인
echo "=== 이번 달 총 비용 ==="
aws ce get-cost-and-usage \
    --time-period Start=$START_DATE,End=$END_DATE \
    --granularity MONTHLY \
    --metrics "UnblendedCost" \
    --query 'ResultsByTime[0].Total.UnblendedCost.[Amount,Unit]' \
    --output table

# 서비스별 비용 확인
echo -e "\n=== 서비스별 비용 Top 10 ==="
aws ce get-cost-and-usage \
    --time-period Start=$START_DATE,End=$END_DATE \
    --granularity MONTHLY \
    --metrics "UnblendedCost" \
    --group-by Type=DIMENSION,Key=SERVICE \
    --query 'ResultsByTime[0].Groups[?Metrics.UnblendedCost.Amount > `0`] | sort_by(@, &Metrics.UnblendedCost.Amount) | reverse(@) | [0:10].[Keys[0],Metrics.UnblendedCost.Amount]' \
    --output table

# 일별 비용 추이
echo -e "\n=== 최근 7일간 일별 비용 ==="
WEEK_AGO=$(date -u -d '7 days ago' +"%Y-%m-%d")
aws ce get-cost-and-usage \
    --time-period Start=$WEEK_AGO,End=$END_DATE \
    --granularity DAILY \
    --metrics "UnblendedCost" \
    --query 'ResultsByTime[*].[TimePeriod.Start,Total.UnblendedCost.Amount]' \
    --output table

# 예상 월말 비용
echo -e "\n=== 예상 월말 총 비용 ==="
aws ce get-cost-forecast \
    --time-period Start=$(date -u -d '+1 day' +"%Y-%m-%d"),End=$(date -u -d '+1 month' +"%Y-%m-01") \
    --metric UNBLENDED_COST \
    --granularity MONTHLY \
    --query 'Total.Amount' \
    --output text 2>/dev/null || echo "예측 데이터가 충분하지 않습니다."