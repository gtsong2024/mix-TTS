#!/bin/bash

# 设置代理
export http_proxy="http://127.0.0.1:33210"
export https_proxy="http://127.0.0.1:33210"

# 导航到项目目录
cd ~/Desktop/TTS/ChatTTS_colab

# 激活虚拟环境
source chattts_env/bin/activate

# 确保所有依赖包已安装
pip install omegaconf vocos vector_quantize_pytorch gradio cn2an pypinyin openai transformers pandas

# 启动 Gradio 服务并将输出写入日志文件
nohup python3 webui_mix.py --share > ~/Desktop/TTS/chattts_output.log 2>&1 &
