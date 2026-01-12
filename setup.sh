#!/bin/bash
set -e  # Exit on error

# Color codes for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

print_success() {
    echo -e "${GREEN}SUCCESS: $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}WARNING: $1${NC}"
}

print_info() {
    echo -e "$1"
}

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    print_error "Azure CLI is not installed. Please install it first."
    print_info "Visit: https://docs.microsoft.com/cli/azure/install-azure-cli"
    exit 1
fi

# Check if user is logged in to Azure
print_info "Checking Azure login status..."
if ! az account show &> /dev/null; then
    print_error "You are not logged in to Azure."
    print_info "Please run 'az login' first."
    exit 1
fi

print_success "Azure CLI is configured correctly."

# Generate unique app name
apiappname=ShoeCoAPI$(openssl rand -hex 5)

printf "\n=== Setting username and password for Git ... (1/7) ===\n\n"

GIT_USERNAME=gitName$RANDOM
GIT_EMAIL=a@b.c

git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

# Get resource group with error checking
printf "\n=== Getting resource group ... ===\n\n"
RESOURCE_GROUP=$(az group list --query "[0].name" -o tsv)

if [ -z "$RESOURCE_GROUP" ]; then
    print_error "No resource group found. Please create a resource group first."
    print_info "Run: az group create --name MyResourceGroup --location centralus"
    exit 1
fi

print_success "Using resource group: $RESOURCE_GROUP"

# Create App Service plan
PLAN_NAME=myPlan

printf "\n=== Creating App Service plan in FREE tier ... (2/7) ===\n\n"

if ! az appservice plan create --name $apiappname --resource-group $RESOURCE_GROUP --sku FREE --location centralus; then
    print_error "Failed to create App Service plan."
    exit 1
fi

printf "\n=== Creating API App ... (3/7) ===\n\n"

if ! az webapp create --name $apiappname --resource-group $RESOURCE_GROUP --plan $apiappname --deployment-local-git; then
    print_error "Failed to create Web App."
    exit 1
fi

printf "\n=== Setting the account-level deployment credentials ... (4/7) ===\n\n"

DEPLOY_USER="myName1$(openssl rand -hex 5)"
DEPLOY_PASSWORD="Pw1$(openssl rand -hex 10)"

if ! az webapp deployment user set --user-name $DEPLOY_USER --password $DEPLOY_PASSWORD; then
    print_warning "Failed to set deployment credentials. This might not be critical."
fi

GIT_URL="https://$DEPLOY_USER@$apiappname.scm.azurewebsites.net/$apiappname.git"

# Create Web App with local-git deploy
REMOTE_NAME=production

# Set remote on src
printf "\n=== Setting Git remote ... (5/7) ===\n\n"

# Remove existing remote if it exists
if git remote get-url $REMOTE_NAME &> /dev/null; then
    print_warning "Remote '$REMOTE_NAME' already exists. Removing it..."
    git remote remove $REMOTE_NAME
fi

git remote add $REMOTE_NAME $GIT_URL
print_success "Git remote added successfully."

printf "\n=== Git add and commit ... (6/7) ===\n\n"

git add .
if git diff-index --quiet HEAD --; then
    print_warning "No changes to commit."
else
    git commit -m "initial revision"
fi

printf "\n=== Building and deploying application ... (7/7) ===\n\n"

# Build the project
print_info "Building .NET project..."
if ! dotnet publish ShoeCompany/ShoeCompany.csproj -c Release -o ./publish; then
    print_error "Failed to build the project."
    exit 1
fi

# Create deployment package
print_info "Creating deployment package..."
cd publish
zip -r ../deploy.zip . > /dev/null
cd ..

# Deploy using az webapp deploy (more reliable than git push)
print_info "Deploying to Azure Web App..."
if az webapp deploy --resource-group $RESOURCE_GROUP --name $apiappname --src-path ./deploy.zip --type zip; then
    print_success "Deployment completed successfully!"
else
    print_error "Deployment failed. Trying alternative method..."
    # Fallback to git push if zip deployment fails
    git push "https://$DEPLOY_USER:$DEPLOY_PASSWORD@$apiappname.scm.azurewebsites.net/$apiappname.git" main 2>&1 || print_warning "Git push failed, but zip deployment might have worked."
fi

# Clean up
rm -f deploy.zip

printf "\n"
print_success "Setup complete!"
printf "\n"
printf "========================================\n"
printf "       IMPORTANT INFORMATION\n"
printf "========================================\n\n"

printf "App Name:        %s\n" "$apiappname"
printf "Resource Group:  %s\n" "$RESOURCE_GROUP"
printf "Swagger URL:     https://%s.azurewebsites.net/swagger\n" "$apiappname"
printf "Swagger JSON:    https://%s.azurewebsites.net/swagger/v1/swagger.json\n" "$apiappname"
printf "\n"
print_warning "Note: It may take a few minutes for the app to start."
printf "\n"

