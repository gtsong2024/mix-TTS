#!/bin/bash

# 设置代理
export http_proxy="http://127.0.0.1:33210"
export https_proxy="http://127.0.0.1:33210"

# 检查并安装 Homebrew
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 检查并安装 Python
if ! command -v python3 &> /dev/null
then
    brew install python
fi

# 克隆项目（如果尚未克隆）
if [ ! -d "~/Desktop/TTS/ChatTTS_colab" ]; then
    git clone https://github.com/6drf21e/ChatTTS_colab ~/Desktop/TTS/ChatTTS_colab
    cd ~/Desktop/TTS/ChatTTS_colab
    git clone https://github.com/2noise/ChatTTS
    cd ChatTTS
    git checkout f4c8329
    cd ..
    mv ChatTTS abc
    mv abc/ChatTTS ./ChatTTS

    # 创建虚拟环境
    python3 -m venv chattts_env
fi

# 激活虚拟环境
source ~/Desktop/TTS/ChatTTS_colab/chattts_env/bin/activate

# 安装依赖
pip3 install --user omegaconf vocos vector_quantize_pytorch gradio cn2an pypinyin openai transformers pandas

# 导航到项目目录
cd ~/Desktop/TTS/ChatTTS_colab

# 启动 Gradio 服务并将输出写入日志文件
nohup python3 webui_mix.py --share > ~/Desktop/TTS/chattts_output.log 2>&1 &
