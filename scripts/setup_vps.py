import os
import sys
import subprocess

def check_and_install(package):
    try:
        __import__(package)
        print(f"Модуль {package} уже установлен.")
    except ImportError:
        print(f"Устанавливаем {package}...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", package])

def check_model(path="models/vosk-model-small-ru-0.22"):
    if os.path.exists(path):
        print(f"Модель найдена: {path}")
    else:
        print(f"Модель не найдена в {path}.")
        print("Скачайте с https://alphacephei.com/vosk/models и распакуйте вручную.")
        print("Пример: wget и unzip в папку models/")
        return False
    return True

def main():
    check_and_install("vosk")
    check_and_install("soundfile")
    check_and_install("numpy")
    check_model()

if __name__ == "__main__":
    main()
