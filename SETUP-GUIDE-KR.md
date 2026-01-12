# Azure API Management 설정 가이드 (한국어)

이 가이드는 Windows 환경에서 발생할 수 있는 문제들과 해결 방법을 다룹니다.

## 📋 목차

1. [사전 요구사항](#사전-요구사항)
2. [설치 방법](#설치-방법)
3. [일반적인 문제 해결](#일반적인-문제-해결)
4. [상세 설명](#상세-설명)

## 사전 요구사항

### 필수 도구

1. **Azure 구독**
   - Azure 계정이 필요합니다
   - 무료 계정: https://azure.microsoft.com/free/

2. **Azure CLI**
   - 설치: https://docs.microsoft.com/cli/azure/install-azure-cli
   - 버전 확인: `az --version`

3. **.NET SDK**
   - 설치: https://dotnet.microsoft.com/download
   - 버전 확인: `dotnet --version`

4. **Git**
   - 설치: https://git-scm.com/downloads
   - Git Bash가 함께 설치됩니다 (Windows)

5. **Bash 셸 환경** (다음 중 하나)
   - **Git Bash** (권장 - Windows)
   - **WSL** (Windows Subsystem for Linux)
   - **Linux/macOS 터미널**

## 설치 방법

### 1단계: 리포지토리 클론

```bash
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git
cd mslearn-publish-manage-apis-with-azure-api-management
```

### 2단계: Azure 로그인

```bash
az login
```

브라우저가 열리면 Azure 계정으로 로그인하세요.

### 3단계: 리소스 그룹 확인 (선택사항)

리소스 그룹이 없다면 생성:

```bash
az group create --name MyResourceGroup --location centralus
```

기존 리소스 그룹 확인:

```bash
az group list --output table
```

### 4단계: setup.sh 실행

**Windows (Git Bash 권장):**
```bash
bash setup.sh
```

**WSL:**
```bash
bash setup.sh
```

**Linux/macOS:**
```bash
./setup.sh
```

## 일반적인 문제 해결

### 문제 1: `$'\r': command not found` 에러

**원인:** Windows의 CRLF 줄바꿈 문제

**해결 방법 1: dos2unix 사용 (WSL)**
```bash
sudo apt install dos2unix
dos2unix setup.sh
chmod +x setup.sh
bash setup.sh
```

**해결 방법 2: VS Code 사용**
1. `setup.sh` 파일 열기
2. 오른쪽 하단의 "CRLF" 클릭
3. "LF" 선택
4. 파일 저장 (Ctrl+S)

**해결 방법 3: Git 설정 변경 후 재클론**
```bash
git config --global core.autocrlf false
cd ..
rm -rf mslearn-publish-manage-apis-with-azure-api-management
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git
```

### 문제 2: `#!/bin/bash: No such file or directory`

**원인:** UTF-8 BOM (Byte Order Mark) 문제

**해결 방법:**
```bash
# WSL 또는 Linux
sed -i '1s/^\xEF\xBB\xBF//' setup.sh
bash setup.sh
```

### 문제 3: `User does not exist in MSAL token cache`

**원인:** Azure CLI 로그인이 만료되었거나 환경 간 인증 정보 불일치

**해결 방법:**

**PowerShell에서:**
```powershell
az login
az account set -s <YOUR_SUBSCRIPTION_ID>
```

**WSL에서:**
```bash
az login --use-device-code
# 또는 캐시 삭제 후 재로그인
rm -rf ~/.azure/msal_http_cache.bin
rm -rf ~/.azure/msal_token_cache.bin
az login
```

### 문제 4: `argument --resource-group/-g: expected one argument`

**원인:** 리소스 그룹이 없거나 `az group list` 실패

**해결 방법:**
1. 리소스 그룹 생성:
   ```bash
   az group create --name MyResourceGroup --location centralus
   ```

2. 리소스 그룹 확인:
   ```bash
   az group list --output table
   ```

### 문제 5: Git Push 인증 실패

**원인:** 배포 자격 증명 설정 실패

**해결 방법:** 
개선된 setup.sh는 이제 `az webapp deploy`를 사용하여 이 문제를 우회합니다. 
스크립트가 자동으로 .NET 프로젝트를 빌드하고 ZIP 파일로 배포합니다.

### 문제 6: "The resource you are looking for has been removed"

**원인:** 웹앱은 생성되었지만 코드가 배포되지 않음

**해결 방법:**

수동 배포:
```bash
# 1. 프로젝트 빌드
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish

# 2. ZIP 파일 생성
cd publish
zip -r ../app.zip .
cd ..

# 3. Azure에 배포
az webapp deploy --resource-group <RESOURCE_GROUP_NAME> \
  --name <APP_NAME> \
  --src-path ./app.zip \
  --type zip
```

## 상세 설명

### 개선된 setup.sh의 주요 기능

1. **사전 검사**
   - Azure CLI 설치 확인
   - Azure 로그인 상태 확인
   - 리소스 그룹 존재 확인

2. **에러 처리**
   - 각 단계마다 에러 체크
   - 실패 시 의미 있는 에러 메시지 출력
   - 색상 코드로 가독성 향상

3. **자동 빌드 및 배포**
   - .NET 프로젝트 자동 빌드
   - ZIP 패키지 생성
   - `az webapp deploy` 사용 (git push보다 안정적)

4. **기존 리소스 처리**
   - 기존 Git remote가 있으면 제거 후 재생성
   - 변경사항이 없으면 커밋 건너뛰기

### .gitattributes 파일의 역할

이 파일은 Git이 파일의 줄바꿈 방식을 자동으로 처리하도록 합니다:

```
*.sh text eol=lf    # Shell 스크립트는 항상 LF 사용
*.bat text eol=crlf # Windows 배치 파일은 CRLF 사용
```

이를 통해 Windows에서 클론해도 shell 스크립트가 올바른 줄바꿈을 유지합니다.

## 환경별 권장사항

### Windows 사용자

**권장 환경: Git Bash**
- 설치가 간단함
- Windows Azure CLI와 잘 통합됨
- 별도의 인증 문제가 적음

**사용 방법:**
1. Git Bash 실행
2. 프로젝트 디렉토리로 이동
3. `bash setup.sh` 실행

**WSL 사용 시 주의사항:**
- WSL과 Windows의 Azure CLI 세션이 별개임
- WSL에서 별도로 `az login` 필요
- Azure CLI 버전 충돌 가능성

### Linux/macOS 사용자

터미널에서 바로 실행:
```bash
chmod +x setup.sh
./setup.sh
```

## 성공적인 배포 확인

스크립트가 성공적으로 완료되면 다음과 같은 정보가 출력됩니다:

```
========================================
       IMPORTANT INFORMATION
========================================

App Name:        ShoeCoAPI<random>
Resource Group:  <your-resource-group>
Swagger URL:     https://<app-name>.azurewebsites.net/swagger
Swagger JSON:    https://<app-name>.azurewebsites.net/swagger/v1/swagger.json
```

Swagger URL을 브라우저에서 열어 API가 정상 작동하는지 확인하세요.

## 추가 도움말

### Azure Portal에서 확인

1. https://portal.azure.com 접속
2. "App Services" 검색
3. 생성된 앱 이름으로 검색
4. "Browse" 버튼 클릭하여 사이트 확인

### 로그 확인

```bash
# 앱 로그 스트리밍
az webapp log tail --resource-group <RESOURCE_GROUP> --name <APP_NAME>

# 배포 로그 확인
az webapp log deployment show --resource-group <RESOURCE_GROUP> --name <APP_NAME>
```

### 리소스 정리

테스트 후 리소스를 삭제하려면:

```bash
# 특정 앱만 삭제
az webapp delete --resource-group <RESOURCE_GROUP> --name <APP_NAME>

# App Service Plan도 삭제
az appservice plan delete --resource-group <RESOURCE_GROUP> --name <PLAN_NAME>

# 리소스 그룹 전체 삭제 (주의!)
az group delete --name <RESOURCE_GROUP> --yes --no-wait
```

## 문제가 계속 발생하는 경우

1. **로그 수집**
   ```bash
   bash setup.sh 2>&1 | tee setup.log
   ```

2. **환경 정보 확인**
   ```bash
   echo "=== Git Version ==="
   git --version
   
   echo "=== Azure CLI Version ==="
   az --version
   
   echo "=== .NET Version ==="
   dotnet --version
   
   echo "=== Current Directory ==="
   pwd
   
   echo "=== File Line Endings ==="
   file setup.sh
   ```

3. **GitHub Issues에 보고**
   - https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management/issues
   - 로그와 환경 정보 첨부

## 참고 자료

- [Azure CLI 설명서](https://docs.microsoft.com/cli/azure/)
- [Azure App Service 문서](https://docs.microsoft.com/azure/app-service/)
- [Azure API Management 문서](https://docs.microsoft.com/azure/api-management/)
- [Git for Windows](https://gitforwindows.org/)

---

**마지막 업데이트:** 2026-01-12
