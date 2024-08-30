# This is my personal nvim config

To have the neovim configuration you will need to have a few things installed.- GNU C compiler `gcc`, `mingw` for windows system.
- text search `RipGrep`.
- Javascript runtime environment `Node.js`


## 🪟 Windows

```powershell
# install RipGrep
winget install BurntSushi.ripgrep.MSVC

# install gcc c windos c compiler
scoop install gcc

# install node.js
winget install CoreyButler.NVMforWindows
```

After using these commands close and open another terminal and execute these commands to finish the installation of node.js

```powershell
# install node.js and npm
nvm install latest # or any version

# Aplicar version instalada
nvm use latest
```