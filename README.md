# Azure API Management - Publishing and Managing APIs

This repository contains the sample code for the Microsoft Learn module on publishing and managing APIs with Azure API Management.

> **한국어 가이드**: [SETUP-GUIDE-KR.md](SETUP-GUIDE-KR.md) 파일을 참고하세요.

## 🚀 Quick Start

### Prerequisites

- Azure subscription
- Azure CLI installed and configured
- .NET SDK (for building the sample application)
- Git
- Bash shell (Linux, macOS, WSL on Windows, or Git Bash)

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git
   cd mslearn-publish-manage-apis-with-azure-api-management
   ```

2. **Login to Azure**
   ```bash
   az login
   ```

3. **Run the setup script**
   ```bash
   bash setup.sh
   ```

The script will:
- Create an Azure App Service plan
- Deploy a sample Shoe Company API
- Configure deployment credentials
- Build and deploy the application
- Provide you with the Swagger URL

## 📝 Important Notes

### For Windows Users

If you encounter line ending issues (CRLF errors), the repository now includes a `.gitattributes` file that automatically handles this. However, if you cloned before this fix:

**Option 1: Using dos2unix**
```bash
dos2unix setup.sh
chmod +x setup.sh
bash setup.sh
```

**Option 2: Using VS Code**
1. Open `setup.sh`
2. Click "CRLF" in the bottom-right corner
3. Select "LF"
4. Save the file

**Option 3: Re-clone the repository** (recommended)
```bash
git clone https://github.com/zer0big/mslearn-publish-manage-apis-with-azure-api-management.git
```

### Improvements Over Original

This fork includes several improvements:
- ✅ **Fixed line ending issues** - `.gitattributes` ensures shell scripts always use LF
- ✅ **Better error handling** - Script checks prerequisites and provides helpful error messages
- ✅ **Enhanced deployment** - Uses `az webapp deploy` for more reliable deployments
- ✅ **Colored output** - Better visibility of errors, warnings, and success messages
- ✅ **Automatic build** - Builds and deploys the .NET application automatically
- ✅ **Korean documentation** - Added comprehensive Korean setup guide

## 🛠️ Troubleshooting

See [SETUP-GUIDE-KR.md](SETUP-GUIDE-KR.md) for detailed troubleshooting steps in Korean.

Common issues:
- **Line ending errors**: Ensure you're using LF line endings (not CRLF)
- **Azure CLI not found**: Install Azure CLI from https://docs.microsoft.com/cli/azure/install-azure-cli
- **Not logged in to Azure**: Run `az login` first
- **No resource group**: Create one with `az group create --name MyResourceGroup --location centralus`

## 📖 Original Repository

This is a fork of the official Microsoft Learn repository with improvements for better cross-platform compatibility.

Original: https://github.com/MicrosoftDocs/mslearn-publish-manage-apis-with-azure-api-management

---

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

# Legal Notices

Microsoft and any contributors grant you a license to the Microsoft documentation and other content
in this repository under the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/legalcode),
see the [LICENSE](LICENSE) file, and grant you a license to any code in the repository under the [MIT License](https://opensource.org/licenses/MIT), see the
[LICENSE-CODE](LICENSE-CODE) file.

Microsoft, Windows, Microsoft Azure and/or other Microsoft products and services referenced in the documentation
may be either trademarks or registered trademarks of Microsoft in the United States and/or other countries.
The licenses for this project do not grant you rights to use any Microsoft names, logos, or trademarks.
Microsoft's general trademark guidelines can be found at http://go.microsoft.com/fwlink/?LinkID=254653.

Privacy information can be found at https://privacy.microsoft.com/en-us/

Microsoft and any contributors reserve all other rights, whether under their respective copyrights, patents,
or trademarks, whether by implication, estoppel or otherwise.
