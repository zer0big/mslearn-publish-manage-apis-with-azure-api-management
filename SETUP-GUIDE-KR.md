# Azure API Management 설정 가이드

이 가이드는 ShoeCompany API를 Azure App Service에 배포하는 전 과정을 설명합니다.

## 전제 조건 (필수 설치)

다음 도구들이 설치되어 있어야 합니다:

### 1. Azure CLI
- **다운로드**: https://aka.ms/installazurecliwindows
- **확인 방법**: `az --version`
- **버전 요구사항**: 2.0 이상

### 2. .NET SDK
- **다운로드**: https://dotnet.microsoft.com/download
- **확인 방법**: `dotnet --version`
- **버전 요구사항**: 6.0 이상 권장

### 3. Git
- **다운로드**: https://git-scm.com/downloads
- **확인 방법**: `git --version`
- Git 설치 시 Git Bash도 함께 설치됩니다

### 4. Azure 구독
- Azure 계정 필요
- 무료 계정 생성: https://azure.microsoft.com/free/

---

## PowerShell 사용 방법 (권장)

PowerShell은 Windows에서 가장 안정적으로 동작합니다.

### 1단계: 프로젝트 다운로드

PowerShell을 열고 다음 명령어를 실행하세요:

```powershell
# 작업 폴더로 이동 (원하는 위치)
cd C:\Users\YourName\Documents

# 프로젝트 클론
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git

# 프로젝트 폴더로 이동
cd mslearn-publish-manage-apis-with-azure-api-management
```

### 2단계: Azure 로그인

```powershell
az login
```

브라우저가 열리면 Azure 계정으로 로그인하세요.

### 3단계: 프로젝트 빌드

```powershell
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

빌드가 완료되면 `publish` 폴더가 생성됩니다.

### 4단계: 배포 스크립트 실행

```powershell
# Git Bash를 통해 스크립트 실행
& "C:\Program Files\Git\bin\bash.exe" setup.sh
```

또는 Git Bash를 직접 열어서:

```bash
bash setup.sh
```

스크립트는 자동으로:
- 리소스 그룹이 없으면 생성 (RG-ShoeAPI-xxxxx)
- App Service Plan 생성 (FREE 티어)
- Web App 생성
- 애플리케이션 배포

**실행 시간:** 약 5-10분 소요

### 5단계: 배포 완료 확인

스크립트가 완료되면 다음과 같은 정보가 표시됩니다:

```
========================================
       IMPORTANT INFORMATION
========================================

App Name:        ShoeCoAPIxxxxxx
Resource Group:  RG-ShoeAPI-xxxxxx
Swagger URL:     https://shoecoapixxxxxx.azurewebsites.net/swagger
Swagger JSON:    https://shoecoapixxxxxx.azurewebsites.net/swagger/v1/swagger.json
```

### 6단계: API 확인

브라우저에서 Swagger URL을 열어 API가 정상 동작하는지 확인하세요.

**참고:** 배포 직후 앱이 시작되는 데 3-5분 정도 걸릴 수 있습니다.

---

## Git Bash 사용 방법

### 1단계: 프로젝트 다운로드

Git Bash를 열고:

```bash
# 작업 폴더로 이동
cd /c/Users/YourName/Documents

# 프로젝트 클론
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git

# 프로젝트 폴더로 이동
cd mslearn-publish-manage-apis-with-azure-api-management
```

### 2단계: Azure 로그인

```bash
az login
```

### 3단계: 프로젝트 빌드

**옵션 A) PowerShell 창을 열어서 빌드 (권장)**

새 PowerShell 창을 열고:

```powershell
cd C:\Users\YourName\Documents\mslearn-publish-manage-apis-with-azure-api-management
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

**옵션 B) Git Bash에서 직접 빌드**

```bash
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

### 4단계: 배포 스크립트 실행

Git Bash에서:

```bash
bash setup.sh
```

### 5단계: 완료 확인

Swagger URL이 표시되면 브라우저에서 열어 확인하세요.

---

## WSL (Windows Subsystem for Linux) 사용 방법

### 1단계: WSL 환경 준비

WSL 터미널을 열고:

```bash
# Azure CLI가 없는 경우 설치
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# zip 유틸리티 설치
sudo apt update
sudo apt install zip -y
```

### 2단계: 프로젝트 다운로드

```bash
# 홈 디렉토리로 이동
cd ~

# 프로젝트 클론
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git

# 프로젝트 폴더로 이동
cd mslearn-publish-manage-apis-with-azure-api-management
```

### 3단계: Azure 로그인

```bash
az login
```

**참고:** WSL의 Azure CLI 세션은 Windows와 별개이므로 WSL에서 별도로 로그인해야 합니다.

### 4단계: 프로젝트 빌드

**옵션 A) Windows PowerShell에서 빌드 (권장)**

Windows PowerShell을 열고:

```powershell
# WSL 홈 디렉토리로 이동 (예시)
cd \\wsl$\Ubuntu\home\yourusername\mslearn-publish-manage-apis-with-azure-api-management
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

**옵션 B) WSL에 .NET SDK 설치 후 빌드**

```bash
# .NET SDK 설치
wget https://dot.net/v1/dotnet-install.sh
bash dotnet-install.sh --channel 8.0
export PATH="$HOME/.dotnet:$PATH"

# 빌드 실행
dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish
```

### 5단계: 배포 스크립트 실행

WSL에서:

```bash
bash setup.sh
```

### 6단계: 완료 확인

Swagger URL을 브라우저에서 열어 확인하세요.

---

## 스크립트가 자동으로 수행하는 작업

`setup.sh` 스크립트는 다음 작업을 자동으로 수행합니다:

1. **환경 확인**
   - Azure CLI 설치 여부
   - Azure 로그인 상태
   - .NET SDK 또는 기존 빌드 파일 존재 여부

2. **리소스 그룹 처리**
   - 기존 리소스 그룹 확인
   - 없으면 자동 생성: `RG-ShoeAPI-<랜덤번호>`

3. **Azure 리소스 생성**
   - App Service Plan (FREE 티어)
   - Web App (고유한 이름 자동 생성)

4. **애플리케이션 배포**
   - publish 폴더를 ZIP으로 압축
   - Azure Web App에 배포
   - 배포 완료 확인

5. **결과 출력**
   - 생성된 리소스 정보
   - Swagger URL 제공

---

## 주의 사항

### 앱 시작 시간

배포가 완료되어도 앱이 실제로 시작하는 데 **3-5분** 정도 걸립니다.

Swagger URL 접속 시 에러가 나면 잠시 기다린 후 다시 시도하세요.

### 리소스 비용

App Service FREE 티어는 무료이지만, 테스트 완료 후에는 리소스를 삭제하는 것을 권장합니다.

---

## 리소스 정리

### Azure Portal에서 삭제

1. https://portal.azure.com 접속
2. "Resource groups" 검색
3. 생성된 리소스 그룹 선택 (RG-ShoeAPI-xxxxx)
4. "Delete resource group" 클릭
5. 리소스 그룹 이름 입력 후 확인

### Azure CLI로 삭제

```bash
# 리소스 그룹 전체 삭제 (주의: 복구 불가능)
az group delete --name RG-ShoeAPI-xxxxxx --yes --no-wait
```

---

## 로그 및 디버깅 (선택 사항)

### 실시간 로그 확인

```bash
az webapp log tail --resource-group <리소스그룹명> --name <앱이름>
```

### 배포 로그 확인

```bash
az webapp log deployment show --resource-group <리소스그룹명> --name <앱이름>
```

### Azure Portal에서 로그 확인

1. Azure Portal 접속
2. App Service 선택
3. "Monitoring" > "Log stream" 선택

---

## 참고 자료

### 공식 문서
- **Azure CLI**: https://docs.microsoft.com/cli/azure/
- **Azure App Service**: https://docs.microsoft.com/azure/app-service/
- **Azure API Management**: https://docs.microsoft.com/azure/api-management/
- **.NET 다운로드**: https://dotnet.microsoft.com/download

### 관련 학습 자료
- Microsoft Learn - Azure API Management: https://docs.microsoft.com/learn/paths/architect-api-integration/

---

## 문의 및 이슈

문제가 발생하면 GitHub Issues에 등록해 주세요:

**GitHub Issues**: https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management/issues

이슈 등록 시 다음 정보를 포함해 주세요:
- 사용 중인 OS 및 셸 (PowerShell/Git Bash/WSL)
- Azure CLI 버전: `az --version`
- .NET SDK 버전: `dotnet --version`
- 발생한 에러 메시지

---

**작성자**: [@zer0big](https://github.com/zer0big)  
**최종 업데이트**: 2026-01-12  
**원본 리포지토리**: [MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management](https://github.com/MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management)
