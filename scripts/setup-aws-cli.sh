#!/bin/bash

echo "=== AWS CLI 설치 및 설정 가이드 ==="

# OS 확인
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS 환경입니다."
    
    # Homebrew 확인
    if ! command -v brew &> /dev/null; then
        echo "Homebrew가 설치되어 있지 않습니다."
        echo "다음 명령어로 Homebrew를 먼저 설치하세요:"
        echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        exit 1
    fi
    
    # AWS CLI 설치
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI를 설치합니다..."
        brew install awscli
    else
        echo "AWS CLI가 이미 설치되어 있습니다."
        echo "버전: $(aws --version)"
    fi
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Linux 환경입니다."
    echo "다음 명령어로 AWS CLI를 설치하세요:"
    echo 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
    echo 'unzip awscliv2.zip'
    echo 'sudo ./aws/install'
fi

echo ""
echo "=== AWS 자격 증명 설정 ==="
echo "AWS CLI가 설치되었다면, 다음 명령어로 자격 증명을 설정하세요:"
echo ""
echo "aws configure"
echo ""
echo "다음 정보가 필요합니다:"
echo "1. AWS Access Key ID"
echo "2. AWS Secret Access Key"
echo "3. Default region name (예: ap-northeast-2)"
echo "4. Default output format (예: json)"
echo ""
echo "AWS 콘솔에서 IAM > Users > Security credentials 에서 Access Key를 생성할 수 있습니다."