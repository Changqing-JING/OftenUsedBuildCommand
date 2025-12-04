```
git clone https://github.com/microsoft/vscode.git
cd vscode
git clean -xfd
nvm install
nvm use
export ELECTRON_GET_USE_PROXY=$http_proxy
npm ci
npm run compile
./scripts/code.sh
```