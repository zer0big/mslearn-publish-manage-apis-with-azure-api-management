# Azure API Management 설정 가이드 (한국어)

> 💡 **이 가이드는 누구나 쉽게 따라할 수 있도록 작성되었습니다!**

## 🎯 빠른 시작 (환경별 선택)

**어떤 환경을 사용하시나요?**

- [🪟 Windows (Git Bash) - **가장 쉬움! 추천**](#windows-git-bash-사용자-추천)
- [🐧 WSL (Windows Subsystem for Linux)](#wsl-사용자)
- [🍎 Linux/macOS](#linuxmacos-사용자)

---

## 🪟 Windows (Git Bash) 사용자 (추천)

### ✅ 준비물 확인

| 항목 | 확인 방법 | 설치 링크 |
|------|----------|-----------|
| Azure CLI | PowerShell에서 `az --version` | [설치하기](https://docs.microsoft.com/cli/azure/install-azure-cli-windows) |
| .NET SDK | PowerShell에서 `dotnet --version` | [설치하기](https://dotnet.microsoft.com/download) |
| Git | PowerShell에서 `git --version` | [설치하기](https://git-scm.com/downloads) |

### 📝 실행 단계

#### 1️⃣ Git Bash 열기
- Windows 검색에서 "Git Bash" 검색 후 실행

#### 2️⃣ Azure 로그인
```bash
az login
```
✅ **성공하면:** 브라우저가 열리고 로그인 완료 메시지가 표시됩니다.

#### 3️⃣ 프로젝트 폴더로 이동
```bash
cd /d/your-path/mslearn-publish-manage-apis-with-azure-api-management
```

#### 4️⃣ 스크립트 실행
```bash
bash setup.sh
```

#### 5️⃣ 완료 대기 (약 5-10분)
```
=== Setting username and password for Git ... (1/7) ===
=== Creating App Service plan in FREE tier ... (2/7) ===
=== Creating API App ... (3/7) ===
=== Setting the account-level deployment credentials ... (4/7) ===
=== Setting Git remote ... (5/7) ===
=== Git add and commit ... (6/7) ===
=== Building and deploying application ... (7/7) ===

SUCCESS: Deployment completed successfully!

========================================
       IMPORTANT INFORMATION
========================================

Swagger URL: https://shoecoapi12345.azurewebsites.net/swagger
```

#### 6️⃣ Swagger URL 접속
위에 표시된 URL을 브라우저에서 열어서 API 확인

---

## 🐧 WSL 사용자

### ⚠️ 중요: WSL은 추가 설정이 필요합니다!

WSL에는 .NET SDK가 설치되어 있지 않으므로, **Windows에서 먼저 빌드**하는 것을 권장합니다.

### ✅ 준비물 확인

**WSL에서 확인:**
```bash
az --version     # Azure CLI 있어야 함
zip --version    # zip 있어야 함 (없으면 설치)
```

**Windows PowerShell에서 확인:**
```powershell
dotnet --version  # .NET SDK 있어야 함
```

### 📝 실행 단계

#### 1️⃣ Windows PowerShell에서 프로젝트 빌드
```powershell
# 프로젝트 폴더로 이동
cd D:\your-path\mslearn-publish-manage-apis-with-azure-api-management

# 빌드 실행 (1분 소요)
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

✅ **성공하면:** `publish/` 폴더가 생성되고 파일들이 들어있습니다.

#### 2️⃣ WSL 터미널 열기
- PowerShell에서 `wsl` 입력 또는
- Windows Terminal에서 Ubuntu/WSL 선택

#### 3️⃣ WSL에서 Azure 로그인
```bash
az login
```

#### 4️⃣ zip 설치 (처음 한 번만)
```bash
sudo apt update
sudo apt install zip -y
```

#### 5️⃣ 프로젝트 폴더로 이동
```bash
# Windows C:\ 드라이브는 /mnt/c/ 로 접근
cd /mnt/c/Users/your-name/path/to/mslearn-publish-manage-apis-with-azure-api-management
```

💡 **팁:** PowerShell에서 `pwd` 명령어로 현재 경로를 확인하고, `C:\`를 `/mnt/c/`로 바꾸세요.

#### 6️⃣ 스크립트 실행
```bash
bash setup.sh
```

✅ **확인:** `publish/` 폴더를 찾으면 다음 메시지가 표시됩니다:
```
WARNING: .NET SDK not found, but using existing publish folder.
Using pre-built application from ./publish directory...
```

#### 7️⃣ 완료 대기 및 URL 확인
```
SUCCESS: Deployment completed successfully!

========================================
       IMPORTANT INFORMATION
========================================

Swagger URL: https://shoecoapi12345.azurewebsites.net/swagger
```

---

## 🍎 Linux/macOS 사용자

### ✅ 준비물 확인

```bash
az --version      # Azure CLI
dotnet --version  # .NET SDK
zip --version     # zip (대부분 기본 설치됨)
```

### 📝 실행 단계

#### 1️⃣ Azure 로그인
```bash
az login
```

#### 2️⃣ 프로젝트 폴더로 이동
```bash
cd ~/path/to/mslearn-publish-manage-apis-with-azure-api-management
```

#### 3️⃣ 스크립트 실행
```bash
chmod +x setup.sh
./setup.sh
```

---

## ❓ 문제 해결

### 🔴 "command not found" 에러가 나요!

**`az: command not found`**
```bash
# Azure CLI 설치 필요
# Windows: https://docs.microsoft.com/cli/azure/install-azure-cli-windows
# Ubuntu/Debian: curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**`dotnet: command not found` (WSL)**
```bash
# ✅ 해결 방법 1 (권장): Windows에서 빌드
# PowerShell에서:
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish

# ✅ 해결 방법 2: WSL에 .NET 설치
wget https://dot.net/v1/dotnet-install.sh
bash dotnet-install.sh --channel 8.0
export PATH="$HOME/.dotnet:$PATH"
```

**`zip: command not found` (WSL/Linux)**
```bash
sudo apt update
sudo apt install zip -y
```

### 🔴 `$'\r': command not found` 에러

**원인:** Windows 줄바꿈 문제 (CRLF)

**해결:**
```bash
# 방법 1: dos2unix 사용
sudo apt install dos2unix -y
dos2unix setup.sh
bash setup.sh

# 방법 2: VS Code에서 수정
# 1. setup.sh 파일 열기
# 2. 오른쪽 하단 "CRLF" 클릭
# 3. "LF" 선택
# 4. 저장 (Ctrl+S)
```

### 🔴 "User does not exist in MSAL token cache"

**원인:** Azure 로그인 필요

**해결:**
```bash
# MSAL 캐시 삭제 후 재로그인
rm -rf ~/.azure/msal_*.bin
az login
```

### 🔴 "argument --resource-group/-g: expected one argument"

**원인:** 리소스 그룹이 없음

**해결:**
```bash
# 리소스 그룹 생성
az group create --name MyResourceGroup --location centralus

# 또는 기존 리소스 그룹 확인
az group list --output table
```

### 🔴 웹사이트 접속 시 "리소스를 찾을 수 없음" 에러

**원인:** 배포가 완료되지 않았거나 앱이 시작 중

**해결:**
1. **5분 정도 기다리기** - 앱이 시작되는 데 시간이 걸립니다
2. Azure Portal에서 확인:
   - https://portal.azure.com 접속
   - "App Services" 검색
   - 생성된 앱 선택
   - 상태가 "Running"인지 확인

---

## 💡 추가 팁

### 🎨 에러 메시지 색상 의미

- 🔴 **빨간색 (ERROR):** 치명적 오류, 반드시 해결 필요
- 🟡 **노란색 (WARNING):** 경고, 무시해도 대부분 괜찮음
- 🟢 **녹색 (SUCCESS):** 성공 메시지

### 🔍 로그 확인

```bash
# 앱 로그 실시간 확인
az webapp log tail --resource-group <RESOURCE_GROUP> --name <APP_NAME>

# 배포 로그 확인
az webapp log deployment show --resource-group <RESOURCE_GROUP> --name <APP_NAME>
```

### 🗑️ 리소스 정리 (테스트 후)

```bash
# 특정 앱만 삭제
az webapp delete --resource-group <RESOURCE_GROUP> --name <APP_NAME>

# 리소스 그룹 전체 삭제
az group delete --name <RESOURCE_GROUP> --yes --no-wait
```

---

## 📞 도움이 필요하신가요?

### 1. 환경 정보 수집
```bash
# 이 명령어들을 실행하고 결과를 복사하세요
echo "=== Git Version ==="
git --version

echo "=== Azure CLI Version ==="
az --version

echo "=== .NET Version ==="
dotnet --version 2>&1 || echo "Not installed"

echo "=== Current Directory ==="
pwd

echo "=== setup.sh Line Endings ==="
file setup.sh 2>&1 || echo "file command not found"
```

### 2. GitHub Issues에 질문하기
- https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management/issues
- 위에서 수집한 환경 정보와 에러 메시지를 함께 올려주세요

---

## 📚 참고 자료

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

### 문제 5: `dotnet: command not found` (WSL)

**원인:** WSL에 .NET SDK가 설치되어 있지 않음

**해결 방법 1: Windows에서 미리 빌드 (권장)**
```powershell
# PowerShell에서 실행
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

## 📚 참고 자료

- [Azure CLI 공식 문서](https://docs.microsoft.com/cli/azure/)
- [Azure App Service 문서](https://docs.microsoft.com/azure/app-service/)
- [Azure API Management 문서](https://docs.microsoft.com/azure/api-management/)
- [.NET 다운로드](https://dotnet.microsoft.com/download)
- [Git for Windows](https://gitforwindows.org/)

---

**만든 사람:** [@zer0big](https://github.com/zer0big)  
**원본 리포지토리:** [MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management](https://github.com/MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management)  
**마지막 업데이트:** 2026-01-12

---

## 🎉 성공하셨나요?

Swagger URL이 정상적으로 열리면 성공입니다! 

이제 다음 단계로 진행하세요:
- Azure Portal에서 API Management 서비스 생성
- Swagger JSON을 사용하여 API 가져오기
- API 정책 설정 및 테스트

**도움이 되었다면 GitHub에 ⭐ 부탁드립니다!**  
https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management
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

3. **유연한 빌드 옵션**
   - .NET SDK가 설치되어 있으면 자동 빌드
   - .NET SDK가 없어도 기존 `publish/` 폴더 사용
   - Windows에서 빌드 후 WSL에서 배포 가능

4. **자동 배포**
   - ZIP 패키지 자동 생성
   - `az webapp deploy` 사용 (git push보다 안정적)
   - zip 명령어가 없으면 Python으로 대체

5. **기존 리소스 처리**
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

**WSL 사용 시:**
1. **Windows에서 먼저 빌드 (권장)**
   ```powershell
   # PowerShell에서 실행
   dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
   ```

2. **WSL에서 실행**
   ```bash
   # WSL에서 Azure 로그인 (WSL과 Windows는 별개 세션)
   az login
   
   # zip 설치 (처음 한 번만)
   sudo apt install zip
   
   # 스크립트 실행 (이미 빌드된 파일 사용)
   bash setup.sh
   ```

**주의사항:**
- WSL과 Windows의 Azure CLI 세션이 별개임
- WSL에서 별도로 `az login` 필요
- .NET SDK를 WSL에 설치하지 않아도 됨 (Windows에서 빌드한 파일 사용)

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
