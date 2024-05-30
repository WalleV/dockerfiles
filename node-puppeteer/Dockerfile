FROM node:20-bullseye-slim
    
# 设置环境变量以避免在安装过程中出现问题
ENV DEBIAN_FRONTEND noninteractive

# 更新包列表并安装必要的库
RUN apt-get update && apt-get install -y wget unzip \
    # 安装Puppeteer运行Chrome所需的依赖
    libnss3 \
    libxss1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcairo2 \
    libatspi2.0-0 \
    libgtk-3-0 \
    # 如果你需要在Docker容器内运行无头浏览器，以下这个也可能需要
    libxi6 \
    libgdk-pixbuf2.0-0 \
    chromium \
    xvfb \
    # 安装ffmpeg
    ffmpeg \
    # 清理apt缓存，减小镜像大小
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装wget和unzip工具，用于下载和解压字体文件
RUN apt-get update && \
    apt-get install -y wget unzip && \
    # 下载思源字体压缩包（以Source Han Sans为例，记得检查最新版本）
    wget https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansHWSC.zip -O source-han-sans.zip && ls && \
    # 解压字体文件
    unzip source-han-sans.zip && \
    # 创建字体目录
    mkdir -p /usr/share/fonts/opentype/source-han-sans && \
    # 将字体文件移动到正确的目录
    mv OTF/* /usr/share/fonts/opentype/source-han-sans/ && \
    # 清理不再需要的文件和缓存
    rm -rf source-han-sans.zip OTF && \
    apt-get remove -y wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*