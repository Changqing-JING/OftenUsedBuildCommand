```
git clone https://github.com/microsoft/vscode.git
cd vscode
git clean -xfd
nvm install 22.21.0
nvm use 22.21.0
export ELECTRON_GET_USE_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export HTTP_PROXY=$http_proxy
export NODE_USE_ENV_PROXY=1
npm ci
npm run compile
./scripts/code.sh
```