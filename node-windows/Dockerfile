# 使用Windows Nano Server LTSC 2019作为基础镜像
FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

# 设置环境变量
ENV NODE_VERSION 18.16.1
#ENV NODE_DOWNLOAD_SHA 145bd2f79eaa50b76559bd78266f4585e57b88dbb94613698a9514a601f84e7f
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-win-x64.zip

# 安装Node.js
ADD $NODE_DOWNLOAD_URL C:\\node.zip

#RUN pwsh -Command "if ((Get-FileHash C:\\node.zip -Algorithm sha256).Hash -ne '$NODE_DOWNLOAD_SHA') {exit 1}"

RUN pwsh -Command "Expand-Archive -Path C:\\node.zip -DestinationPath C:\\" && \
    pwsh -Command "Move-Item -Path C:\\node-v$env:NODE_VERSION-win-x64 -Destination C:\\node"

# 将Node.js添加到PATH
ENV PATH="C:\\node;C:\\node\\node_modules\\.bin;${PATH}"

# init pnpm
RUN npm config set registry http://registry.npmmirror.com && \
    npm install -g pnpm && \
    pnpm -v && \
    pnpm config set registry http://registry.npmmirror.com